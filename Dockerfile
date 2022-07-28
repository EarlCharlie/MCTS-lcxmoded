FROM ubuntu:20.04 AS builder

WORKDIR /

RUN apt update && apt install -y locales wget tar && locale-gen zh_CN.utf8
RUN wget -c https://download.java.net/openjdk/jdk17/ri/openjdk-17+35_linux-x64_bin.tar.gz -O - | tar -xz

FROM python:3-slim

COPY --from=builder /jdk-17 /openjdk
ENV JAVA_HOME=/openjdk
ENV PATH=$PATH:$JAVA_HOME/bin
ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8
ENV TZ=Asia/Shanghai

RUN pip install --upgrade pip && pip install mcdreforged && pip cache purge

VOLUME /workspace
WORKDIR /workspace
CMD ["python", "-m", "mcdreforged"]
