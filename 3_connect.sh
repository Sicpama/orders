# Detect the operating system
if [[ "$(uname)" == "Darwin" ]]; then
    # macOS
    HOST="localhost"
elif [[ "$(uname)" == "Linux" ]]; then
    # Ubuntu/Linux
    HOST="127.0.0.1"
else
    echo "Unsupported OS"
    exit 1
fi

# Use the determined host in the docker exec command
docker exec -it orders-db mysql -h $HOST -u dev --password=pwd -e "use orders; show tables; select count(*) from orders;"
