require 'wavefile'
require 'rubberband'
require 'sox'
include WaveFile



input_file = 'prueba.wav'

# Ruta del archivo de salida distorsionado
output_file = 'archivo_distorsionado.wav'

cmd = Sox::Cmd.new
cmd.add_input(input_file)
cmd.set_output(output_file)
cmd.set_effects(:speed => 0.8, :tempo => 1.7)
cmd.run

puts "Archivo distorsionado guardado en #{output_file}"