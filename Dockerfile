FROM ubuntu:16.04
MAINTAINER Dilawar Singh <dilawar.s.rajput@gmail.com>

#RUN apt-get update 
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y python2.7
RUN apt-get install -y wget
RUN apt-get install -y python-matplotlib==2.2.2
RUN apt-get install -y ipython ipython-notebook
RUN apt-get install curl


#RUN sudo easy_install pip==20.3.4
RUN curl https://bootstrap.pypa.io/2.7/get-pip.py --output get-pip.py
RUN python get-pip.py


RUN wget -nv https://download.opensuse.org/repositories/home:moose/xUbuntu_16.04/Release.key -O /tmp/Release.key
RUN apt-key add - < /tmp/Release.key
RUN sh -c "echo 'deb http://download.opensuse.org/repositories/home:/moose/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/moose.list"
RUN apt-get update && apt-get install -y --allow-unauthenticated moose
RUN pip install pip  --upgrade
RUN pip install python-libsbml
RUN pip install --ignore-installed pyzmq ipython
RUN pip install jupyter --upgrade

ENV NB_USER mooser
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
