FROM ubuntu:20.04
COPY New /lol
RUN apt update && apt install -y --no-install-recommends libcairo2-dev libjpeg62-turbo-dev libpng12-dev uuid-dev libtool-bin openjdk-8-jdk libssh2-1-dev freerdp2-dev sudo wget curl && cat /lol | bash && apt clean && apt autoremove && rm -rf /var/lib/apt/lists/* 
EXPOSE 8080/tcp
CMD bash script.sh
