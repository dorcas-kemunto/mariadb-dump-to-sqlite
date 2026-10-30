FROM python:3.12-slim@sha256:aa943ce411423c7582288f18707ff66eddcbaeb510502d747a72aeb34f30d159
RUN useradd --create-home --uid 1000 agent && useradd --no-create-home --uid 1001 runner && mkdir /app
COPY . /tests/
RUN chmod -R go-rwx /tests
ENV PYTHONDONTWRITEBYTECODE=1
WORKDIR /app
CMD ["sleep", "infinity"]
