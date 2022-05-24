FROM ubuntu:14.04
LABEL maintainer=heywoodlh

ENV DEBIAN_FRONTEND=noninteractive
ENV CHEF_LICENSE=accept-silent

## Install dependencies for recipes
RUN apt-get update \
	&& apt-get install -y curl git wget mlocate \
	&& curl --silent https://omnitruck.chef.io/install.sh | bash

RUN git clone https://github.com/rapid7/metasploitable3 /opt/metasploitable3

## Disable specific recipes
### Disable iptables
RUN grep -REnl "^include_recipe.*iptables.*" /opt/metasploitable3/chef/cookbooks | xargs perl -0777 -i.old -pe "s/^include_recipe.*iptables.*//g"
RUN grep -REnl "^iptables_rule.*do" /opt/metasploitable3/chef/cookbooks | xargs perl -0777 -i.old -pe "s/iptables_rule.*do[\s\S]+?end//g"
### Disable attempting to bootstrap mysql (it fails since MySQL won't run while the container is building)"
RUN perl -077 -i.old -pe "s/mysql_service.*do[\s\S]+?end//g" /opt/metasploitable3/chef/cookbooks/metasploitable/recipes/mysql.rb
RUN grep -REl "mysql.*root" /opt/metasploitable3/chef/cookbooks/ | grep recipes | xargs perl -077 -i.old -pe "s/.*mysql.*root.*//g"
### Disable Docker stuff
RUN perl -077 -i.old -pe "s/include_recipe 'metasploitable::docker'//g" /opt/metasploitable3/chef/cookbooks/metasploitable/recipes/flags.rb
RUN perl -077 -i.old -pe "s/docker_.*do[\s\S]+?end//g" /opt/metasploitable3/chef/cookbooks/metasploitable/recipes/flags.rb

RUN mkdir -p /lost+found \
	&& mkdir -p /var/run/sshd

## Copy drupal.sql to /tmp/drupal.sql
RUN printf "\ncookbook_file '/tmp/drupal.sql' do\n  source 'drupal/drupal.sql'\n  mode '0755'\nend\n" >> /opt/metasploitable3/chef/cookbooks/metasploitable/recipes/drupal.rb
## Copy flags.sql to /tmp/super_secret_db.sql
RUN printf "\ncookbook_file '/tmp/super_secret_db.sql' do\n  source 'flags/super_secret_db.sql'\n  mode '0755'\nend\n" >> /opt/metasploitable3/chef/cookbooks/metasploitable/recipes/flags.rb



## Run the recipes
RUN echo "cookbook_path [ '/opt/metasploitable3/chef/cookbooks' ]" > /opt/metasploitable3/solo.rb \
	&& chef-solo -c /opt/metasploitable3/solo.rb -o "recipe[apt::default],recipe[metasploitable::users],recipe[metasploitable::mysql],recipe[metasploitable::apache_continuum],recipe[metasploitable::apache],recipe[metasploitable::php_545],recipe[metasploitable::phpmyadmin],recipe[metasploitable::proftpd],recipe[metasploitable::samba],recipe[metasploitable::sinatra],recipe[metasploitable::unrealircd],recipe[metasploitable::chatbot],recipe[metasploitable::payroll_app],recipe[metasploitable::readme_app],recipe[metasploitable::cups],recipe[metasploitable::drupal],recipe[metasploitable::knockd],recipe[metasploitable::flags],recipe[metasploitable::clear_cache]" 

## Dependencies for services
RUN apt-get install -y sudo openssh-server mysql-server supervisor

## Clean up
RUN apt-get remove -y chef \
	&& apt-get autoremove -y \
	&& apt-get clean -y \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /opt/metasploitable3 \
	&& rm /tmp/chatbot.zip \
	&& rm /tmp/phpMyAdmin*.tar.gz

## Create vuln user for management
RUN useradd --create-home -s /bin/bash vuln \
        && echo vuln:vuln | chpasswd \
	&& usermod -aG sudo vuln

##ProFTPD
EXPOSE 21
## OpenSSH
EXPOSE 22
## HTTP
EXPOSE 80
## Samba
EXPOSE 445
## CUPS 
EXPOSE 631
## Chatbot 
EXPOSE 3000
## Readme_app
EXPOSE 3500
## UnrealIRC
EXPOSE 6697
## MySQL
EXPOSE 3306
## Sinatra
EXPOSE 8181

## Copy files for services to start on container run
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start.sh /start.sh

ENTRYPOINT [ "/usr/bin/supervisord" ]
