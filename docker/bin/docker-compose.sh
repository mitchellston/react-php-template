# docker compose -f compose.yml -f compose.admin.yml build

# Find root docker-compose of the project (docker/docker-compose.yml)
ROOT_COMPOSE_FILE=$(find . -name "docker-compose.yml" | head -n 1)

# Find all the child docker-compose files
CHILD_COMPOSE_FILES=$(find . -name "docker-compose.yml" | sort)

# Remove the root docker-compose file from the list
CHILD_COMPOSE_FILES=$(echo "$CHILD_COMPOSE_FILES" | grep -v "$ROOT_COMPOSE_FILE")

# Child compose files add -f to every file
CHILD_COMPOSE_FILES=$(echo "$CHILD_COMPOSE_FILES" | sed 's/^/-f /')

# Build the list of all the docker-compose files
docker-compose -f "$ROOT_COMPOSE_FILE" $CHILD_COMPOSE_FILES "$@"
