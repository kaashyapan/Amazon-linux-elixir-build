FROM amazonlinux

MAINTAINER sunder.narayanaswamy@gmail.com

RUN amazon-linux-extras install epel -y
RUN yum install -y  git wget curl tar unzip openssh --enablerepo=epel

RUN rpm --import https://packages.erlang-solutions.com/rpm/erlang_solutions.asc

RUN echo -e '\n' >> /etc/yum.repos.d/epel.repo
RUN echo -e '[erlang-solutions]' >> /etc/yum.repos.d/epel.repo
RUN echo -e 'name=CentOS 7 - x86_64 - Erlang Solutions' >> /etc/yum.repos.d/epel.repo
RUN echo -e 'baseurl=https://packages.erlang-solutions.com/rpm/centos/7/x86_64' >> /etc/yum.repos.d/epel.repo
RUN echo -e 'gpgcheck=1' >> /etc/yum.repos.d/epel.repo
RUN echo -e 'gpgkey=https://packages.erlang-solutions.com/rpm/erlang_solutions.asc' >> /etc/yum.repos.d/epel.repo
RUN echo -e 'enabled=1' >> /etc/yum.repos.d/epel.repo

RUN yum install -y erlang

RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash -
RUN yum install -y nodejs

RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.6.3
RUN echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc

RUN bash -c "source ~/.bashrc; asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git"
RUN bash -c "source ~/.bashrc; asdf plugin-update elixir"
RUN bash -c "source ~/.bashrc; asdf install elixir 1.6.6"
RUN bash -c "source ~/.bashrc; asdf global elixir 1.6.6"



# Add local node module binaries to PATH
ENV PATH=./node_modules/.bin:$PATH \
    MIX_HOME=/opt/mix \
    HEX_HOME=/opt/hex 

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Install Hex+Rebar
RUN bash -c "source ~/.bashrc; mix local.hex --force &&  mix local.rebar --force"

WORKDIR /opt/app

CMD ["/bin/bash"]
