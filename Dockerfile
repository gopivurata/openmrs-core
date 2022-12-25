# Dockerfile ,,,openmrs build, stage-1
FROM maven:3.8.6-openjdk-11 as build
RUN git clone https://github.com/gopivurata/openmrs-core.git && \
    cd openmrs-core && \
    mvn package

# Dockerfile ,,,openmrs run i,e stage-2
#war file location: /game-of-life/gameoflife-web/target/gameoflife.war
FROM tomcat:8-jdk11-corretto
LABEL application="openmrs"
LABEL owner="Gopi"
COPY --from=build /openmrs-core/webapp/target/openmrs.war /usr/local/tomcat/webapps/openmrs.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
