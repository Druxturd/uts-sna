FROM jenkins/jenkins:lts-jdk11

USER root

RUN apt-get update &&  apt-get install docker.io -y && apt-get install sudo -y

EXPOSE 8080
EXPOSE 50000

RUN usermod -aG docker jenkins

# RUN usermod -aG sudo jenkins

# USER jenkins
