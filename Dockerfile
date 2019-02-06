FROM elixir:1.6.6

MAINTAINER sunder.narayanaswamy@gmail.com

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && \
		apt-get install -y --no-install-recommends \
    		git curl wget \
    		zip unzip \
		    build-essential \
		    software-common-properties \
        nodejs


ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Install Hex+Rebar
RUN mix local.hex --force &&  mix local.rebar --force

WORKDIR /opt/app

CMD ["/bin/bash"]
