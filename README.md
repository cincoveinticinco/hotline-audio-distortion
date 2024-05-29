# Hotline voice audio distortion

### Using Ruby 3.3.1

####Instalation

'''
bundle install

ruby index.rb
'''


####Empaquetar y desplegar

bundle config set path 'vendor/bundle'

bundle install

zip -r function.zip lambda_function.rb Gemfile Gemfile.lock vendor