export LS_ACCESS_TOKEN=YJ/7/UUODD6b93YoauvRy+vKY6/sqvsN9UR/ZL1d++W3Eyg3KfCUpgktAymsj3huDkQgIJwLBrSgQzJaUJJuVx6iE8oen+5UqnNjZcay
export LS_SERVICE_NAME=castor
export LS_SERVICE_VERSION=latest
java -javaagent:lightstep-opentelemetry-javaagent.jar -Xshare:off \
     -jar target/app.jar