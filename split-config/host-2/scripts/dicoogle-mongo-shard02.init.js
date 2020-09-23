rs.initiate(
   {
      _id: "shard02",
      version: 1,
      members: [
         { _id: 0, host: "172.27.150.33:8081" },
         { _id: 1, host: "172.27.150.33:8082" },
      ]
   }
)
