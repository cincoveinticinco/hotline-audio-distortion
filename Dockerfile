FROM public.ecr.aws/lambda/ruby:2.7


# Copiar solo los archivos necesarios
COPY lambda_function.rb ${LAMBDA_TASK_ROOT}/

# Instalar las gemas necesarias
COPY Gemfile Gemfile.lock ${LAMBDA_TASK_ROOT}/

ENV GEM_HOME=${LAMBDA_TASK_ROOT}

RUN yum install -y \
    sox \
    libsox-fmt-all

RUN gem install bundler:2.4.8 && bundle install

# Comando para ejecutar la función Lambda
CMD ["lambda_function.process_audio"]