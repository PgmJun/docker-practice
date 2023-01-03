FROM azul/zulu-openjdk:11

VOLUME /tmp

ARG JAR_FILE="build/libs/*.jar"

COPY ${JAR_FILE} app.jar

ENV PROFILE dev

ENTRYPOINT ["java", "-Dspring.profiles.active=${PROFILE}", "-jar","/app.jar"]