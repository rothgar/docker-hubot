# docker-hubot
Container for running hubot.

###Clone Repository

```
git clone https://github.com/rothgar/docker-hubot.git
```

###Build Container

```
docker build --tag=hubot .
```

###Run Container

```
docker run --env-file ./ENV -v /etc/localtime:/etc/localtime:ro --name hubot hubot
```
