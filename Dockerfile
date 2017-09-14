FROM ubuntu

#add  software-properties-common for add-apt-repository
RUN apt-get update \
 && apt-get install -y software-properties-common \
#Needed for unrar
 && apt-add-repository multiverse \
#This line is optional but that repo has a more recent version than multiverse
 && apt-add-repository ppa:jcfp/ppa \
 && apt-add-repository ppa:jcfp/sab-addons \
 && apt-get update \
 && apt-get install -y sabnzbdplus python-sabyenc unrar \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8080 9090

ENV LANG C.UTF-8

VOLUME ["/sabnzbd_data", "/data/complete", "/data/incomplete"]

ENTRYPOINT ["/usr/bin/sabnzbdplus", \
						"--server", "0.0.0.0:8080", \
						"--https", "9090", \
						"--browser", "0", \
						"--config-file", "/sabnzbd_data"]
