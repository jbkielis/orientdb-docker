orientdb-docker
===============

[OrientDB](http://www.orientdb.org) is the first Multi-Model Open Source NoSQL DBMS that combines the power of graphs and the flexibility of documents into one scalable, high-performance operational database.

This repository is a dockerfile for creating an orientdb image with :
- explicit orientdb version (orientdb-2.0) for image cache stability
- distributed mode configured for multicast between local dockers

This image is intended to be used to test and explore OrientDB in distributed configuration.


Building the image on your own
------------------------------

1. Checkout this project to a local folder cding to it

2. Build the image:
  ```bash
docker build -t <YOUR_DOCKER_HUB_USER>/orientdb-2.0-distributed .
```

3. Push it to your Docker Hub repository (it will ask for your login credentials):
  ```bash
docker push <YOUR_DOCKER_HUB_USER>/orientdb-2.0-distributed
```

Running orientdb
----------------

To run the first image, execute:

```bash
docker run --name orientdb1 -d --env="ORIENTDB_NODE_NAME=node1" -p 2424:2424 -p 2480:2480 vagas/orientdb-2.0-distributed
```

For the second container and on, add 1 to "--name", "ORIENTDB\_NODE\_NAME" env variable and local ports:

```bash
docker run --name orientdb2 -d --env="ORIENTDB_NODE_NAME=node2" -p 2425:2424 -p 2481:2480 vagas/orientdb-2.0-distributed
```
