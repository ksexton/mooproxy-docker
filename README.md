# mooproxy Docker Container

This repository provides a Dockerized environment for running [mooproxy](https://github.com/irfinnew/mooproxy), a proxy/bouncer for connecting to MOO servers.

## Features
- Generates the world configuration file from environment variables.
- Provides a non-interactive alternative to the built-in connection string hashing functionality.

## Getting Started
### Prerequisites
Ensure you have the following installed:
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Installation and Usage
1. Clone this repository:
   ```sh
   git clone <repository-url>
   cd <repository-folder>
   ```

2. Update the values in docker-compose.yml 

3. Build and start the container:
   ```sh
   docker-compose up --build
   ```

3. Once running, mooproxy will listen by default on port **7777** for connections.

### Connecting to the Proxy
Use any MOO client (e.g., `telnet` or `mushclient`) to connect:
```sh
telnet localhost 7777
```
This will proxy your connection to the MOO server specified in `docker-compose.yml`.

## Configuration
Configuration is managed via environment variables in `docker-compose.yml`:
- `LISTEN_PORT`: The port mooproxy listens on (default: 7777)
- `MOO_CONNECT_STRING`: The command for logging in (`co username password`)
- `MOO_HOST`: The MOO server hostname
- `MOO_PORT`: The MOO server port
- `MOO_AUTOLOGIN`: Enable automatic login (`true`/`false`)
- `MOO_AUTORECONNECT`: Enable automatic reconnection (`true`/`false`)
- `MOO_COMMANDSTRING`: The prefix for sending commands (default: `,`)
- `MOO_STRICT_COMMANDS`: Whether to enforce strict command mode (`true`/`false`)
- `MOO_INFOSTRING`: The string used for parsing output (default: `%c%% `)
- `MOO_NEWINFOSTRING`: The string used for parsing new output since your last connection (default: `%C%% `)

## Password Hashing Utility
The `generate_mooproxy_hash.py` script generates an MD5-based hash for mooproxy authentication. It is used in `entrypoint.sh` when generating the world configuration.

### Usage:
```sh
python generate_mooproxy_hash.py <connection string>
```
Example:
```sh
python generate_mooproxy_hash.py "co username password"
```
Output:
```
$1$abcd1234$K7CvvUuXekEAMe4qjZnVQ/
```
This hash can be used in the MOO login configuration.

## File Overview
- **`docker-compose.yml`**: Defines the services and environment variables.
- **`Dockerfile`**: Builds the Docker image and installs mooproxy.
- **`generate_mooproxy_hash.py`**: Generates hashed passwords for mooproxy authentication.

## Stopping the Container
To stop the running container:
```sh
docker-compose down
```

## License
This project is licensed under the MIT License.

## Contributing
Feel free to submit issues or pull requests to improve the setup.

## Contact
For questions or feedback, open an issue in this repository.

