#!/bin/sh
echo "Background database seeder initialized. Awaiting local loopback availability..."

# Loop until local database instance responds to authenticated ping queries
until redis-cli -h 127.0.0.1 -p 6379 -a "$REDIS_PASSWORD" --no-auth-warning ping | grep -q "PONG"; do
    sleep 0.5
done

echo "Local server found. Injecting embedded schemas..."

# 1. Establish app version controls
redis-cli -h 127.0.0.1 -p 6379 -a "$REDIS_PASSWORD" --no-auth-warning SET app:system:status "initialized"

# 2. Establish global configuration maps
redis-cli -h 127.0.0.1 -p 6379 -a "$REDIS_PASSWORD" --no-auth-warning HSET app:config default_language "en" maintenance_mode "false"

# 3. Setup core lookup system keys
redis-cli -h 127.0.0.1 -p 6379 -a "$REDIS_PASSWORD" --no-auth-warning SADD app:roles "administrator" "manager" "customer"

echo "Embedded volume initialization phase successfully complete!"
