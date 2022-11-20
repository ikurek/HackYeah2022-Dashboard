#!/bin/bash

# Set the port
PORT=5432

# Stop any program currently running on the set port
echo 'preparing port' $PORT '...'
fuser -k 5432/tcp

# switch directories
cd build/web/

# Start the server
echo 'Server starting on port' $PORT '...'
python3 -m http.server $PORT