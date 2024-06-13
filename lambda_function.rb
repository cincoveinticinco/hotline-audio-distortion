require 'sox'
require 'securerandom'
require 'aws-sdk-s3'


def download_from_s3(bucket_name, object_key, download_path)
    s3 = Aws::S3::Client.new
    s3.get_object(
      response_target: download_path,
      bucket: bucket_name,
      key: object_key
    )
end

def upload_to_s3(bucket_name, object_key, file_path)
    s3 = Aws::S3::Client.new
    s3.put_object(
      bucket: bucket_name,
      key: object_key,
      body: File.open(file_path, 'rb')
    )
end
  

def distort_audio(input_file, output_file)
    cmd = Sox::Cmd.new
    cmd.add_input(input_file)
    cmd.set_output(output_file)
    cmd.set_effects(:speed => 0.8, :tempo => 1.7)
    cmd.run
    
    puts "Archivo distorsionado guardado en #{output_file}"
end

def process_audio(payload)
    event = payload[:event]
    source_bucket = event['Records'][0]['s3']['bucket']['name']
    source_key = event['Records'][0]['s3']['object']['key']

    original_dir = ENV['ORIGINAL_DIR']
    secure_dir = ENV['SECURE_DIR']

    target_bucket = source_bucket
    target_key = source_key.gsub(original_dir,secure_dir)
    target_key = target_key.gsub('wav','mp3')

    download_path = "/tmp/#{SecureRandom.uuid}_input.wav"
    output_path = "/tmp/#{SecureRandom.uuid}_output.wav"

    download_from_s3(source_bucket, source_key, download_path)

    distort_audio(download_path, output_path)

    upload_to_s3(target_bucket, target_key, output_path)

    puts "Processed file updated from #{source_bucket}/#{source_key}"
    puts "Processed file uploaded to #{target_bucket}/#{target_key}"
end
