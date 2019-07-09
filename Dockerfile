FROM elixir:1.8.2

MAINTAINER sunder.narayanaswamy@gmail.com

# Setup node
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

# Add microsoft keys

RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
RUN mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
RUN wget -q https://packages.microsoft.com/config/debian/9/prod.list
RUN mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
RUN chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
RUN chown root:root /etc/apt/sources.list.d/microsoft-prod.list

RUN apt-get update && \
		apt-get install -y --no-install-recommends \
    		git curl wget \
    		zip unzip \
		    build-essential \
        apt-transport-https dotnet-sdk-3.0.100-preview6-012264 \
		    software-properties-common \
        ca-certificates nodejs && \ 
        apt-get -y upgrade && \
        apt-get -y autoclean && \
        apt-get -y clean && \
        apt-get -y autoremove 


WORKDIR /opt/app

CMD ["/bin/bash"]
