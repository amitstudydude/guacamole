FROM ubuntu:20.04
COPY New /lol
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends libssh2-1-dev freerdp2-dev libossp-uuid-dev libtool-bin libpng-dev libjpeg-turbo8-dev libcairo2-dev  openjdk-8-jdk libssh2-1-dev freerdp2-dev sudo wget curl && cat /lol | bash && apt clean && apt autoremove && rm -rf /var/lib/apt/lists/* 
EXPOSE 8080/tcp
CMD bash script.sh
