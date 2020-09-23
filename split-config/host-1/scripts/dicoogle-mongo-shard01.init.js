rs.initiate(
   {
      _id: "shard01",
      version: 1,
      members: [
         { _id: 0, host: "172.27.150.32:8081" },
         { _id: 1, host: "172.27.150.32:8082" },
      ]
   }
)
