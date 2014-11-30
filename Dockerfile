FROM        debian:jessie

# Based on https://github.com/sqawasmi/readthedocs-docker
MAINTAINER  Kostis Anagnostopoulos "http://github.com/ankostis"

# Update the package repository
RUN DEBIAN_FRONTEND=noninteractive apt-get update -q && \ 
	DEBIAN_FRONTEND=noninteractive apt-get upgrade -qy && \
	DEBIAN_FRONTEND=noninteractive apt-get install -qy \
		wget curl locales git \
		libxml2-dev libxslt-dev \
		texlive-full libevent-dev dvipng graphviz \
		python python-pip python-dev python-matplotlib \
		python3 python3-pip python3-dev 

# Configure locale
RUN export LANGUAGE=en_US.UTF-8 && \
	export LANG=en_US.UTF-8 && \
	export LC_ALL=en_US.UTF-8 && \
	locale-gen en_US.UTF-8 && \
	DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# Install readthedocs
RUN mkdir /www/ && cd /www/ && git clone https://github.com/rtfd/readthedocs.org.git
RUN pip install --upgrade pip
RUN cd /www/readthedocs.org/ && pip install -r pip_requirements.txt && pip3 install -r pip_requirements.txt
RUN cd /www/readthedocs.org/readthedocs && ./manage.py syncdb --noinput
RUN cd /www/readthedocs.org/readthedocs && ./manage.py migrate 
RUN cd /www/readthedocs.org/readthedocs && echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@localhost', 'admin')" | ./manage.py shell

# Install supervisord
RUN pip install supervisor
ADD files/supervisord.conf /etc/supervisord.conf

CMD ["supervisord"]
