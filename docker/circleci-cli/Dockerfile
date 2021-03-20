FROM alpine:latest

MAINTAINER Nenad Stefanovic <stefanovic21@sbb.rs>

# SYS: Set build arguments

ARG MUSL_LOCPATH=/usr/share/i18n/locales/musl

ARG HOST_USER_ID

ARG HOST_GROUP_ID

ARG CONTAINER_LANGUAGE

ARG CONTAINER_TIMEZONE

# SYS: Set environments

ENV USER=sphere-master

ENV HOME /home/$USER

ENV LANG=$CONTAINER_LANGUAGE

ENV LANGUAGE=$CONTAINER_LANGUAGE

ENV LC_ALL=$CONTAINER_LANGUAGE

## SYS: Install required packages

RUN apk update && \
	apk --no-cache upgrade && \
    apk add \
    	autoconf \
    	bash \
    	cmake \
    	curl \
    	docker-cli \
        g++ \
    	gcc \
    	gettext \
        gettext-dev \
    	make \
    	musl-dev \
    	shadow \
    	sudo \
    	tzdata \
    	jq

RUN apk add --no-cache \
    $MUSL_LOCALE_DEPS && \
    wget https://gitlab.com/rilian-la-te/musl-locales/-/archive/master/musl-locales-master.zip && \
    unzip musl-locales-master.zip && \
    cd musl-locales-master && \
    cmake -DLOCALE_PROFILE=OFF -D CMAKE_INSTALL_PREFIX:PATH=/usr . && \
    make && \
    make install && \
    cd .. && \
    rm -r musl-locales-master

RUN curl -fLSs https://raw.githubusercontent.com/CircleCI-Public/circleci-cli/master/install.sh | bash

# SYS: Set container timezone

RUN ln -snf "/usr/share/zoneinfo/$CONTAINER_TIMEZONE" /etc/localtime && \
    echo "$CONTAINER_TIMEZONE" > /etc/timezone

# SYS: Remove /etc/dpkg that get's installed with $PHPIZE_DEPS

RUN rm -rf /etc/dpkg

# SYS: Add sphere-master user

RUN adduser -D $USER && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers

# SYS: Set sphere-master user and group id

RUN /bin/bash -c 'if [ -n $HOST_USER_ID ] && [ $HOST_USER_ID -lt 60000 ]; then \
        usermod -u $HOST_USER_ID $USER; \
    fi'

RUN /bin/bash -c 'if [ -n $HOST_GROUP_ID ] && [ $HOST_GROUP_ID -lt 60000 ]; then \
        groupmod -g $HOST_GROUP_ID $USER; \
    fi'

# SYS: Copy local execute script

COPY --chown=$USER:$USER scripts/circleci-local-execute.sh $HOME/circleci-local-execute.sh

# SYS: Copy startup script

COPY --chown=$USER:$USER scripts/startup.sh $HOME/startup.sh

# SYS: Set sphere-master as current user

USER $USER

# SYS: Change working dir

WORKDIR $HOME/project

# SYS: Trigger startup script

CMD ["/home/sphere-master/startup.sh"]
