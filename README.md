# Hotline Audio Distorter

This is a ruby 3.3.1 script powered with AudioVox, is made for distort an audio and save it in a S3 bucket, the environment is dockerized and hosted in a AWS Elastic Container Registry instance.

## Installation

Install the project locally

# Install Sox

Install locally Sox

```bash
yum -y install sox
```

Install dependencies

```bash
bundle install
```

Run
(Is a TODO make a fake call to S3, or local credentials are needed)

```bash
ruby index.rb
```

## Deployment

This project is made for be deploied on a AWS Lambda using a docker container powered by a custom docker file and hosted in AWS Elastic Container Registry

To deploy this project run

1. Build dockerfile with custom name.

```bash
docker build -t sox-ruby-container .
```

2. Tag the container and link to AWS ECR service

```bash
docker tag sox-ruby-container:latest 406495642741.dkr.ecr.us-west-2.amazonaws.com/sox-ruby-container:latest

#Take care with AWS timezone and account id
```

3. Push container to AWS ECR

```bash
docker push 406495642741.dkr.ecr.us-west-2.amazonaws.com/sox-ruby-container:latest

#Take care with AWS timezone and account id
```

## Support

For support, email santiago.h@cincoveinticinco.com or alexander.o@cincoveinticinco.com

## Used By

This project is used by the following companies:

- Grupo CINCOVEINTICINCO.
