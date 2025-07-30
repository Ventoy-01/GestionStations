# Image Tomcat officielle (Tomcat 10 + JDK 17)
FROM tomcat:10.1-jdk17

# Supprimer les applications par défaut de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copier ton fichier .war généré par NetBeans dans Tomcat
COPY dist/GestionStations.war /usr/local/tomcat/webapps/ROOT.war

# Exposer le port 8080 (Render l'utilise automatiquement)
EXPOSE 8080

# Démarrer Tomcat
CMD ["catalina.sh", "run"]
