FROM ubuntu:20.04
RUN apt update && apt install -y openjdk-8-jdk sudo wget curl 
COPY New /lol
RUN cat /lol | bash
EXPOSE 8080/tcp
CMD bash script.sh
