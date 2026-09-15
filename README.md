# cryptad

Development environment for [CryptPad](https://cryptpad.org/) (v2025.3.0) in Docker.

CryptPad is a secure, end-to-end encrypted collaborative document editor (docs,
sheets, slides, code, kanban, forms, whiteboards, etc.). This repository
contains the Docker tooling to run a local development instance quickly, with
data persisted in named volumes and the config mounted read-only.

## Architecture

```
┌──────────────────────────────────────────────┐
│  host                                         │
│  ┌────────────┐   ┌────────────┐   ┌───────┐ │
│  │ start.sh   │...│ make logs  │   │ curl  │ │
│  └──────┬─────┘   └────────────┘   └───────┘ │
│         │ docker-compose                       │
│  ┌──────▼────────────────────────────────┐     │
│  │ cryptpad-dev (node:18-alpine)         │     │
│  │  - git clone cryptpad → /cryptpad     │     │
│  │  - npm install + components           │     │
│  │  - USER node, EXPOSE 3000             │     │
│  │  - CMD npm run dev                    │     │
│  │  ports 2001:3000                      │     │
│  └───────────────────────────────────────┘     │
│  volumes: cryptpad_data / block / datastore / │
│           metadata (+ ./config.js ro)        │
└──────────────────────────────────────────────┘
```

The container maps host port **2001** to the app's **3000**. The CryptPad web UI
serves on `http://localhost:2001`.

## Quick start

Prerequisites: Docker running, `docker` and `docker-compose` on PATH.

```bash
# One command: build + start + wait + report
./start.sh
```

Or step by step:

```bash
# Build the image (clones CryptPad, installs deps)
make build        # or: docker-compose build

# Start in background
make up           # or: docker-compose up -d

# Check it is alive
curl -s http://localhost:2001 && echo OK
```

Open <http://localhost:2001> in your browser.

## Makefile

| Command | Effect |
|---|---|
| `make build` | Build the Docker image |
| `make up` | Start the container (`-d`) |
| `make down` | Stop it |
| `make logs` | Follow the logs (`-f`) |
| `make shell` | Shell inside the container (`exec sh`) |
| `make restart` | Restart the container |
| `make status` | `docker-compose ps` |
| `make clean` | Stop, remove volumes and the image |

## Configuration

`config.js` is a CryptPad config file for development. It is mounted read-only
into the container at `/cryptpad/config/config.js`.

Key tunables:

| Setting | Value | Meaning |
|---|---|---|
| `httpUnsafeOrigin` | `http://localhost:2001` | Public URL the app advertises |
| `defaultStorageLimit` | 500 MB | Per-pad storage cap (prod default is 50 MB) |
| `maxUploadSize` | 20 MB | Max file upload size |
| `retentionTime` | 30 days | Pad retention (prod: 90) |
| `archiveRetentionTime` | 7 days | Archive retention (prod: 15) |
| `accountRetentionTime` | 180 days | Inactive account retention (prod: 365) |
| `verbose` | `true` | Verbose logging |
| `availablePadTypes` | all 16 types | Which pads to expose in the UI |

`start.sh` regenerates a minimal `config.js` if none exists.

## Data persistence

Four named Docker volumes keep state across rebuilds:

- `cryptpad_data` → `/cryptpad/blob`
- `cryptpad_block` → `/cryptpad/block`
- `cryptpad_datastore` → `/cryptpad/datastore`
- `cryptpad_metadata` → `/cryptpad/data`

To wipe everything: `make clean` (also removes the image).

## Updating CryptPad

Edit the `git checkout` line in `Dockerfile` (currently `2025.3.0`) and rebuild:

```bash
make build && make restart
```

## Notes

- The container runs as non-root user `node`.
- `./customize` may be mounted into the container for custom branding.
- Port 2001 on the host is used so it does not collide with the default 3000.
- For production use, swap the dev config for a real CryptPad config and set
  `NODE_ENV=production`.

## License

Proprietary dev scaffolding. CryptPad itself is AGPL-3.0.