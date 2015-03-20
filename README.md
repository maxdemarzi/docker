# Unofficial Neo4j Dockerfile

# Neo4j Community Edition 2.2.0-RC01

This repository contains a Docker image of the latest version release candidate (2.2.0-RC01) of the [Neo4j community server](http://www.neo4j.com/download). This Docker image of Neo4j provides instructions on how to map a Docker data volume to an already existing `data/graph.db` store file located on your host machine.

# Build Docker Image

To build the source from the Dockerfile as an image:

```
docker build -t maxdemarzi/neo4j .
```

# Pull Docker Image

This image is automatically built and is available from the Docker registry. Use the following `pull` command to download the image to your local Docker server.

```
docker pull maxdemarzi/neo4j
```

# Start Neo4j Container

To run the Neo4j image inside a container after either building it or pulling it, run the following docker command.

```
docker run -p 7474:7474 -p 7473:7473 -p 1337:1337 --name neo4j maxdemarzi/neo4j
```

Four volumes are exposed so you can make changes.

```
VOLUME  ["/opt/neo4j/conf", "/opt/neo4j/data/graph.db", "/opt/neo4j/data/log", "/opt/neo4j/plugins"]
```
For example to use an existing graph.db directory:

```
docker run -d -P -v /path/to/neo4j/data/:/opt/neo4j/data/graph.db --name neo4j maxdemarzi/neo4j
```




