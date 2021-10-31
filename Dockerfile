FROM python:3.6.4

# ref: https://docs.docker.com/engine/reference/builder/#workdir
# The WORKDIR instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile
# specified work directory -> following cmd will run in this path
WORKDIR /workdir

COPY . /workdir

ENV DOCKER_ENV="This is an env var in docker file"

# install dependencies
RUN pip install -r requirements.txt

# create db
RUN python manage.py create_db

# run the app finally
CMD ["python", "run.py"]

