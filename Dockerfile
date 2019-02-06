FROM elixir:1.6.6

MAINTAINER sunder.narayanaswamy@gmail.com

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get update && \
		apt-get install -y --no-install-recommends \
    		git curl wget \
    		zip unzip \
		    build-essential \
		    software-properties-common \
        ca-certificates nodejs && \ 
        apt-get -y upgrade && \
        apt-get -y autoclean && \
        apt-get -y clean && \
        apt-get -y autoremove 

RUN mix local.hex --force &&  mix local.rebar --force

WORKDIR /opt/app

CMD ["/bin/bash"]
