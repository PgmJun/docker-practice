FROM azul/zulu-openjdk:11

RUN apt-get update && apt-get -y install sudo

ARG JAR_FILE="build/libs/*.jar"

COPY ${JAR_FILE} app.jar

ENV PROFILE dev

ENTRYPOINT ["java", "-Dspring.profiles.active=${PROFILE}", "-jar","/app.jar"]