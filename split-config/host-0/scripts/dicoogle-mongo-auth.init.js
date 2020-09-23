admin = db.getSiblingDB("admin")
admin.createUser(
    {
        user: "dicoogle",
        pwd: "dicoogle",
        roles: [{ role: "root", db: "admin" }]
    }
)