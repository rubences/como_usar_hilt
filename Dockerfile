FROM gradle:7.4.1 AS build
COPY --chown=gradle:gradle . /gradle/src
WORKDIR /gradle/src
RUN gradle build

FROM openjdk:8-jre-slim
EXPOSE 3000
COPY --from=build /home/gradle/src/build/libs/spring-petclinic-kotlin-2.6.2.jar /app/
RUN bash -c 'touch /app/spring-petclinic-kotlin-2.6.2.jar'
ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/spring-petclinic-kotlin-2.6.2.jar"]
