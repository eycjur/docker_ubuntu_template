FROM ubuntu:20.04
WORKDIR /app

RUN apt update && apt install -y sudo make git vim

ARG ROOT_PASSWORD=pass
RUN echo "root:${ROOT_PASSWORD}" | chpasswd

ARG DOCKER_UID=1000
ARG DOCKER_USER=user
ARG DOCKER_PASSWORD=pass
RUN useradd -m --uid ${DOCKER_UID} --groups sudo ${DOCKER_USER} \
    && echo "${DOCKER_USER}:${DOCKER_PASSWORD}" | chpasswd

USER ${DOCKER_USER}
