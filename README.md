# Mongo Sharded Cluster with Docker Compose
=========================================

A :whale: &nbsp; *docker-compose* descriptor to create the following components:


* Config Server (3 replica sets): 
	* `config01`
	* `config02`
	* `config03`

* Shards (3 shard servers, each with 2 replica sets):
	* `shard01a` and `shard01b`
	* `shard02a` and `shard02b`
	* `shard03a` and `shard03b`

* Router (mongos):
	* `router`

<!-- * (TODO): DB data persistence using docker data volumes -->

:warning: &nbsp; Development and testing purposes only :warning:


## First Run (initial setup)
```bash
sh init.sh
```

This script has a `sleep 40` to wait for the config server and shards to elect their primaries before initializing the router

**Verify the status of the sharded cluster**

```bash
docker exec -it dicooglemongo_router_1 mongo --port 8081  -u'dicoogle' -p'dicoogle'

mongos> sh.status()

--- Sharding Status ---
  sharding version: {
  	"_id" : 1,
  	"minCompatibleVersion" : 5,
  	"currentVersion" : 6,
  	"clusterId" : ObjectId("5f6a7f73cad87736ef244137")
  }
  shards:
        {  "_id" : "shard01",  "host" : "shard01/shard01a:27018,shard01b:27018",  "state" : 1 }
        {  "_id" : "shard02",  "host" : "shard02/shard02a:27019,shard02b:27019",  "state" : 1 }
        {  "_id" : "shard03",  "host" : "shard03/shard03a:27020,shard03b:27020",  "state" : 1 }
  active mongoses:
        "4.4.1" : 1
  autosplit:
        Currently enabled: yes
  balancer:
        Currently enabled:  yes
        Currently running:  no
        Failed balancer rounds in last 5 attempts:  0
        Migration Results for the last 24 hours:
                No recent migrations
  databases:
        {  "_id" : "config",  "primary" : "config",  "partitioned" : true }
```

## Normal Startup
The cluster only has to be initialized on the first run. Subsequent startup can be achieved simply with `docker-compose up` or `docker-compose up -d`

## Accessing the Mongo Shell
Its as simple as:

```bash
docker exec -it dicooglemongo_router_1 mongo --port 8081  -u'dicoogle' -p'dicoogle'
```

## Shutdown

```bash
sh down.sh
```

## Resetting the Cluster
To remove all data and re-initialize the cluster, make sure the containers are stopped and then:

```bash
docker-compose rm
```

Execute the **First Run** instructions again.

# Credits

Credits to for the inspiration and guidance:
- [jfollenfant/mongodb-sharding-docker-compose](https://github.com/jfollenfant/mongodb-sharding-docker-compose)
- [chefsplate/mongo-shard-docker-compose](https://github.com/chefsplate/mongo-shard-docker-compose)