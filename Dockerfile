FROM ubuntu:20.04
COPY New /lol
RUN apt update && apt install -y --no-install-recommends openjdk-8-jdk sudo wget curl && cat /lol | bash && apt clean && apt autoremove && rm -rf /var/lib/apt/lists/* 
EXPOSE 8080/tcp
CMD bash script.sh
