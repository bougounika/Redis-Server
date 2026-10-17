
# Redis Server Stack with Web UI management

A modular, production-ready **Docker Compose** orchestration stack running
 **Redis Server**, **Redis Insight web UI Management** behind an **Nginx Reverse Proxy**. 

This setup features hardened networks, completely isolated backend components, health-checked, automatic scheduled hot backups.

Redis(Remote Dictionary Server) is a highly popular, open-source, in-memory data store.
Redis is a NoSQL database.
Redis keeps all its data in the computer’s RAM.
Redis uses a key-value structure.

# Redis Used for:
- **Caching (Most Common):** Instead of making your application slow down by constantly querying a heavy database for the same information, you store a copy of frequently accessed data in Redis. This drastically reduces website loading times.

- **Session Management:** Storing temporary user data—like keeping a user logged in or holding items in an e-commerce shopping cart while they browse.

- **Real-time Leaderboards:** Using its built-in sorted structures to instantly compute rankings or high scores for gaming or trading apps.

- **Message Brokers (Pub/Sub):** Passing messages instantly between different microservices or parts of an application (e.g., real-time chat apps).

- **Geospatial Indexes:** Storing latitude/longitude coordinates to quickly find "nearby" locations, which is how ride-sharing apps track vehicles.



## Directory Structure
```text
.
├── .dockerignore
├── .env
├── .gitignore
├── .vscode
│   └── mcp.json
├── README.md
├── backups
│   └── manual_dump.2026-10-17_063824.rdb
├── compose
│   ├── redis-backup.yml
│   ├── redis-server.yml
│   └── web-server.yml
├── config
│   ├── initdb
│   │   └── init.sh
│   ├── nginx
│   │   └── nginx.conf
│   └── redis
│       └── redis.conf
└── docker-compose.yml
```

`chmod +x config/initdb/init.sh`


## How to Run
1. Open a terminal inside the `redis-project` directory.
2. Start the containers by running:
   ```bash
   docker compose up -d --build
   ```
3. Open your web browser and visit: `http://localhost:8500/redis_ui` to access the RedisInsight UI dashboard.

## Connecting to Redis from the Dashboard
When RedisInsight loads, add a database connection using these details:
- **Database alias:** `any name`
- **Host:**            `redis` (This matches the internal container service name)
- **Port:**            `6379`
- **Password:**        `your pssword set in .env file`


# Connection String:
1. If App runs INSIDE the same Docker Network

• Format: redis://:<password>@<container_hostname>:<internal_port>
          redis://:Labasset1122!!@redis-server:6379

2. If App runs on your HOST machine (Outside Docker)
*Add this block to your compose/redis-server.yml under the redis service:*
ports:
  - "6379:6379"

Format: redis://:<password>@127.0.0.1:<exposed_port>
        redis://:Labasset1122!!@127.0.0.1:6379
