FROM heywoodlh/jenkins:latest

USER root

RUN apt-get update && apt-get install -y ansible \
	&& rm -rf /var/lib/apt/lists/*

RUN jenkins-plugin-cli --plugins ansible:1.1

ARG JENKINS_URL=http://updates.jenkins-ci.org/latest/jenkins.war
ARG JENKINS_PLUGIN_MANAGER_URL=https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.10.0/jenkins-plugin-manager-2.10.0.jar

RUN curl -fsSL ${JENKINS_URL} -o /usr/share/jenkins/jenkins.war
RUN curl -fsSL ${JENKINS_PLUGIN_MANAGER_URL} -o /usr/lib/jenkins-plugin-manager.jar

USER jenkins

# Defaults
EXPOSE 8080
EXPOSE 50000
VOLUME /var/jenkins_home

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]
