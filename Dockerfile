FROM ubuntu:20.04

RUN apt-get update \
    && apt-get upgrade -y \
        make \
        vim \
        git \
