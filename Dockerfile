FROM php:7.3-apache 

ARG WORKDIR=/workmed
ENV WORKDIR=${WORKDIR}
ENV OAUTH_TOKEN=""
ENV VERSION='${{ steps.vars.outputs.tag }}'
## imagen base##
##  instalacion de dependencias ##
WORKDIR $WORKDIR
#RUN docker-php-ext-install mysqli pdo_mysql
RUN apt-get update \
    && apt-get install git -y \
    && apt-get install -y unzip \
    && apt-get install -y wget \
   # && apt-get install -y libzip-dev \
   # && apt-get install -y zlib1g-dev \
    && rm -rf /var/lib/apt/lists/* 
   # && docker-php-ext-install zip 
#RUN export lsls="${{ secrets.OAUTH_TOKEN }}" 
RUN printenv VERSION


RUN wget https://github.com/gruntwork-io/fetch/releases/download/v0.4.2/fetch_linux_amd64\
    && chmod +x ./fetch_linux_amd64
   
#RUN mkdir /usr/local/jdk
#RUN chmod 777 /usr/local/jdk
RUN  ./fetch_linux_amd64 --github-oauth-token="$OAUTH_TOKEN"  --repo="$REPO" --tag="$VERSION" --release-asset="stage.zip" ./
