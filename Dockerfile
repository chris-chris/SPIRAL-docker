# A Dockerfile that sets up a full Gym install
FROM ubuntu:16.07

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8

RUN apt-get update
# RUN apt-get install console-common -y

# RUN L='us' && sed -i 's/XKBLAYOUT=\"\w*"/XKBLAYOUT=\"'$L'\"/g' /etc/default/keyboard
RUN apt-get install -y git python python-pip tmux gtk+-3.0 build-essential 
RUN apt-get install -y libjson-c-dev \
    libgirepository1.0-dev \
    libglib2.0-dev \
    python-gobject-2-dev \
    liblcms2-dev \
    swig \
    locales \
    python-cairo \
    xorg \
    openbox \
    meld \
    python-gi-cairo \
    xvfb \ 
    wget \ 
    scons \
    xorg \
    openbox

RUN locale-gen en_US.UTF-8

RUN Xvfb :99 -ac -screen 0 1280x1024x24 > /dev/null &

RUN echo "export DISPLAY=:99" >> ~/.profile
ENV DISPLAY :99

RUN git clone https://github.com/chris-chris/SPIRAL-tensorflow

WORKDIR /root/SPIRAL-tensorflow

RUN pip install -r requirements.txt

RUN bash install.sh

RUN pip install tensorflow==1.5

RUN pip install pycairo

WORKDIR /root
# ENTRYPOINT ["/usr/local/gym/bin/docker_entrypoint"]
