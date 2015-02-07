FROM node:latest
MAINTAINER Justin Garrison <justinleegarrison@gmail.com>

# Install CoffeeScript, Hubot
RUN \
  npm install -g coffee-script hubot yo generator-hubot && \
  apt-get -q update && \
  apt-get install -y git-core && \
  rm -rf /var/lib/apt/lists/*

# make user for bot
# yo requires uid/gid 501
RUN groupadd -g 501 hubot
RUN useradd -m -u 501 -g 501 hubot
WORKDIR /home/hubot/bot

# make directories and files
RUN mkdir -p /home/hubot/.config/configstore && \
  echo "optOut: true" > /home/hubot/.config/configstore/insight-yo.yml && \
  chown -R hubot:hubot /home/hubot

USER hubot

# optionally override variables with docker run -e HUBOT_...
# You also will need to specify HUBOT_SLACK_TOKEN when running the cantainer
ENV HUBOT_OWNER hubot
ENV HUBOT_NAME hubot
ENV HUBOT_ADAPTER slack
ENV HUBOT_DESCRIPTION Just a friendly robot

# generate and run our new bot
# docker run -e HUBOT_SLACK_TOKEN=... -v /etc/localtime:/etc/localtime:ro rothgar/hubot:latest
CMD /usr/local/bin/yo hubot --adapter $HUBOT_ADAPTER --owner $HUBOT_OWNER --name $HUBOT_NAME --description $HUBOT_DESCRIPTION --defaults && bin/hubot --adapter $HUBOT_ADAPTER
