FROM ubuntu:bionic

MAINTAINER sunder.narayanaswamy@gmail.com



RUN apt-get update && apt-get install -y --no-install-recommends \
            git curl wget zip unzip build-essential software-properties-common ca-certificates \
            gpg-agent gnupg2 python3-pip python3-setuptools openssh-server openssh-client

RUN  bash -c "pip3 install awscli"

ENV TZ=Asia/Colombo
ENV LANG C.UTF-8 
ENV LC_ALL C.UTF-8

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add microsoft keys

RUN apt-key adv --keyserver packages.microsoft.com --recv-keys EB3E94ADBE1229CF
RUN apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893
RUN bash -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-bionic-prod bionic main" > /etc/apt/sources.list.d/dotnetdev.list'


RUN  bash -c "curl -sL https://deb.nodesource.com/setup_10.x | bash -"
RUN  bash -c "wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb"

RUN apt-get update && apt-get install -y --no-install-recommends erlang elixir=1.8.2-1 nodejs=10.16.0-1nodesource1 dotnet-sdk-2.1
RUN apt-get -y autoclean && apt-get -y clean && apt-get -y autoremove 

RUN mix local.hex --force &&  mix local.rebar --force

WORKDIR /opt/app

CMD ["/bin/bash"]
