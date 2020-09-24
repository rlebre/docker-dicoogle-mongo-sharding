rs.initiate(
   {
      _id: "configserver",
      configsvr: true,
      version: 1,
      members: [
         { _id: 0, host: "172.27.150.39:8082" },
         { _id: 1, host: "172.27.150.39:8083" },
         { _id: 2, host: "172.27.150.39:8084" }
      ]
   }
)