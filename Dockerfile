FROM tomcat:9.0-jdk17-temurin

# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR as ROOT app
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Render uses dynamic port
ENV PORT=8080

EXPOSE 8080

CMD ["catalina.sh", "run"]
