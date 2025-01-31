#!/bin/bash

CONFIG_FILE="/root/.mooproxy/worlds/config"

# Generate auth hash using provided password (if set)
if [[ -n "$MOO_CONNECT_STRING" ]]; then
    AUTH_HASH=$(python3 /usr/local/bin/generate_mooproxy_hash.py "$MOO_CONNECT_STRING")
else
    AUTH_HASH=""
fi

echo "MOO connect string: $MOO_CONNECT_STRING"

# Create the config file dynamically
cat <<EOF > "$CONFIG_FILE"
listenport = "${LISTEN_PORT:-7777}"
auth_hash = "$AUTH_HASH"
host = "${MOO_HOST:-example.org}"
port = ${MOO_PORT:-8888}
autologin = ${MOO_AUTOLOGIN:-true}
autoreconnect = ${MOO_AUTORECONNECT:-true}
commandstring = "${MOO_COMMANDSTRING:-,}"
strict_commands = ${MOO_STRICT_COMMANDS:-true}
infostring = "${MOO_INFOSTRING:-%c%% }"
newinfostring = "${MOO_NEWINFOSTRING:-%C%% }"
EOF

echo "Generated mooproxy config file:"
cat "$CONFIG_FILE"

# Run mooproxy with the generated config file
exec mooproxy -d -w config

