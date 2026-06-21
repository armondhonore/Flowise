# Nexlayer — flowise

<!-- nexlayer:meta version=1 analyzed=2026-06-21T00:40:26Z repo=https://github.com/armondhonore/flowise branch=nexlayer -->

> **For AI agents (Claude Code, Cursor, Gemini CLI, Copilot):**
> This file is the **project context** for this Nexlayer deployment — tech stack, env vars, secrets, live URL.
> For full platform detail (nexlayer.yaml schema, Dockerfile rules, CI/CD, task recipes) read **`nexlayer.skills`** in this repo.
>
> **Critical rules (full detail in `nexlayer.skills`):**
> - Inter-pod refs: `${podName:port}` only — never `localhost` or bare hostnames
> - Docker Hub images: prefix with `mirror.gcr.io/library/` — bare tags fail on the cluster
> - Secrets: set in the Nexlayer dashboard — never commit to `nexlayer.yaml` or Dockerfile
>
> **This file:** `agent-managed` sections update automatically. `user-editable` sections (Local Development Setup, Nexlayer Deployment Plan, Build Notes) are yours — preserved across re-analysis.

## Project Summary
<!-- nexlayer:section agent-managed=project_summary -->
Flowise is a low-code visual tool for building customized LLM orchestration flows and AI agents, allowing users to drag-and-drop components to create complex AI workflows.
<!-- nexlayer:end -->

## Technology Stack
<!-- nexlayer:section agent-managed=tech_stack -->
| Name | Kind | Version | Detected From |
|------|------|---------|---------------|
| Node.js | language | 24.15.0 | .nvmrc |
| pnpm | tool | 10.26.0 | Dockerfile |
| TurboRepo | build | latest | turbo.json |
| Chromium | infra | latest | Dockerfile |
<!-- nexlayer:end -->

## Repository Structure
<!-- nexlayer:section agent-managed=structure_map -->
- packages/ — Monorepo packages containing the core logic, server, and UI
- docker/ — Docker configuration files for deployment
- i18n/ — Internationalization files
- assets/ — Static assets for the application
<!-- nexlayer:end -->

## External Services Required
<!-- nexlayer:section agent-managed=external_deps -->
Services that must be configured separately (not deployed by Nexlayer):

- LLM Providers (OpenAI, Anthropic, etc.)
- Vector Databases (Pinecone, Milvus, etc.)
<!-- nexlayer:end -->

## Local Development Setup
<!-- nexlayer:section user-editable=local_setup -->
### Prerequisites

- Node.js >= 20
- pnpm >= 10

### Environment variables

Copy `.env.example` to `.env.local` and fill in:

```
PORT=3000
DATABASE_PATH=./database.sqlite
```

### Steps

1. `pnpm install` — Install workspace dependencies
2. `pnpm build` — Build the project using Turbo
3. `pnpm start` — Start Flowise on http://localhost:3000

<!-- nexlayer:end -->

## Nexlayer Setup
<!-- nexlayer:section agent-managed=nexlayer_setup -->
### Pod Environment Variables

| Pod | Variable | Value | Kind |
|-----|----------|-------|------|
| `app` | `NODE_ENV` | `production` | plain |
| `app` | `PORT` | `"3000"` | plain |
| `app` | `HOSTNAME` | `"0.0.0.0"` | plain |

### nexlayer.yaml

```yaml
application:
  name: flowise
  pods:
    - name: app
      image: "registry.nexlayer.io/user_01kece1xyh817dwff7wnarhkxd/flowise:19ee79eb5ac"
      path: /
      servicePorts:
        - 3000
      vars:
        NODE_ENV: production
        PORT: "3000"
        HOSTNAME: "0.0.0.0"
```

<!-- nexlayer:end -->

## Nexlayer Deployment Plan
<!-- nexlayer:section user-editable=deployment_plan -->
### Pod Topology

| Pod | Image | Port | Role |
|-----|-------|------|------|
| flowise | mirror.gcr.io/library/node:24-alpine | 3000 | web |
| postgres | mirror.gcr.io/library/postgres:16-alpine | 5432 | database |

### Deployment notes

- Flowise application pod connects to the database pod using the address postgres.pod:5432
- The image uses mirror.gcr.io for the base Node.js alpine image to comply with Nexlayer rules
- Chromium is installed as a system dependency in the web pod for puppeteer-based web scraping capabilities

<!-- nexlayer:end -->

## Build Notes
<!-- nexlayer:section user-editable=build_notes -->
<!-- Add notes for future builds here — preserved across re-analysis -->
<!-- nexlayer:end -->

## Nexlayer Configuration
<!-- nexlayer:section agent-managed=nexlayer_config -->
**Last deployed:** 2026-06-21T00:56:08Z  
**Live URL:** https://relaxed-weasel-flowise.cloud.nexlayer.ai  
**Runtime:**  · **Port:** auto-detected  
**Deploy branch:** nexlayer  

```yaml
application:
  name: flowise
  pods:
    - name: app
      image: "registry.nexlayer.io/user_01kece1xyh817dwff7wnarhkxd/flowise:19ee79eb5ac"
      path: /
      servicePorts:
        - 3000
      vars:
        NODE_ENV: production
        PORT: "3000"
        HOSTNAME: "0.0.0.0"
```
<!-- nexlayer:end -->

## Build History
<!-- nexlayer:section agent-managed=build_history -->
| Date | Status | Notes |
|------|--------|-------|
| 2026-06-21T00:40:26Z | analyzed | initial repo analysis |
| 2026-06-21T00:56:08Z | success | deployed https://relaxed-weasel-flowise.cloud.nexlayer.ai |
<!-- nexlayer:end -->
