require 'sox'
require 'securerandom'

input_file = 'prueba.wav'

# Ruta del archivo de salida distorsionado
output_file = 'archivo_distorsionado.wav'

def download_from_s3(bucket_name, object_key, download_path)
    s3 = Aws::S3::Client.new
    s3.get_object(
      response_target: download_path,
      bucket: bucket_name,
      key: object_key
    )
end

def upload_to_s3(bucket_name, object_key, file_path)
  puts "entrando a descarga s3"
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

def process_audio(event)
    puts "entrando a base"
    puts event
    source_bucket = event['Records'][0]['s3']['bucket']['name']
    source_key = event['Records'][0]['s3']['object']['key']
    file_name = File.basename(source_key)
    target_bucket = source_bucket
    target_key = "output/#{file_name}"

    # Paths for the local filesystem
    download_path = "/tmp/#{SecureRandom.uuid}_input.mp3"
    output_path = "/tmp/#{SecureRandom.uuid}_output.mp3"

    # Download the file from S3
    download_from_s3(source_bucket, source_key, download_path)

    # Distort the audio
    puts "distorsion de audio #{download_path} #{output_path}"
    distort_audio(download_path, output_path)

    # Upload the distorted file back to S3
    upload_to_s3(target_bucket, target_key, output_path)

    puts "Processed file uploaded to #{target_bucket}/#{target_key}"
end


# Uncomment for local testing
# event = {
#   'Records' => [
#     {
#       's3' => {
#         'bucket' => {
#           'name' => 'your-source-bucket-name'
#         },
#         'object': {
#           'key': 'input/path/to/your/input/file.mp3'
#         }
#       }
#     }
#   ]
# }
# process_audio(event, nil)
