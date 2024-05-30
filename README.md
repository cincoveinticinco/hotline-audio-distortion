# Hotline voice audio distortion

### Using Ruby 3.3.1

####Instalation

'''
bundle install

ruby index.rb
'''

####Empaquetar y desplegar

This repo deploys in AWS Elastic Container Registry

docker build -t sox-ruby-container .

docker tag sox-ruby-container:latest 406495642741.dkr.ecr.us-west-2.amazonaws.com/sox-ruby-container:latest

docker push 406495642741.dkr.ecr.us-west-2.amazonaws.com/sox-ruby-container:latest
