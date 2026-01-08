# Komodo MCP Server

Un servidor MCP (Model Context Protocol) completo para la API de Komodo. Proporciona acceso a todas las funcionalidades de Komodo a través de una arquitectura modular y bien estructurada.

## 🚀 Despliegue Rápido (Docker Compose)

La forma más sencilla de ejecutar este servidor es utilizando Docker Compose con la imagen pre-construida.

1. **Crea un archivo `docker-compose.yml`**:
```yaml
version: '3.8'

services:
  komodo-mcp:
    image: ghcr.io/nonetss/komodo-mcp:latest
    container_name: komodo-mcp-server
    ports:
      - "3333:3333"
      - "8090:8090"
    environment:
      - KOMODO_URL=${KOMODO_URL}
      - KOMODO_KEY=${KOMODO_KEY}
      - KOMODO_SECRET=${KOMODO_SECRET}
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3333/sse"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
```

2. **Crea un archivo `.env`**:
```env
KOMODO_URL=https://tu-instancia.komo.do
KOMODO_KEY=tu_api_key
KOMODO_SECRET=tu_secret
```

3. **Inicia el servidor**:
```bash
docker compose up -d
```

4. **Verifica la conexión**:
```bash
curl http://localhost:3333/sse
```

## 🛠️ Herramientas Disponibles

El servidor MCP proporciona **40+ herramientas** organizadas en los siguientes módulos:

### 🖥️ Servidores
- `list_servers`, `get_server_info`, `create_server`, `update_server`, `delete_server`, `get_server_stats`

### 📚 Stacks
- `list_stacks`, `get_stack_info`, `deploy_stack`, `create_stack`, `update_stack`, `delete_stack`, `start_stack`, `stop_stack`, `restart_stack`

### 🚀 Deployments
- `list_deployments`, `get_deployment_info`, `deploy_deployment`, `create_deployment`, `update_deployment`, `delete_deployment`, `start_deployment`, `stop_deployment`, `restart_deployment`, `get_deployment_logs`

### 🔨 Builds
- `list_builds`, `get_build_info`, `run_build`, `create_build`, `update_build`, `delete_build`, `cancel_build`

### 📁 Repositorios
- `list_repos`, `get_repo_info`, `create_repo`, `update_repo`, `delete_repo`, `pull_repo`, `clone_repo`

### ⚙️ Procedimientos
- `list_procedures`, `get_procedure_info`, `run_procedure`, `create_procedure`, `update_procedure`, `delete_procedure`

### 🔧 Sistema
- `list_updates`, `get_system_info`, `get_version`, `list_alerters`, `get_alerter_info`, `create_alerter`, `update_alerter`, `delete_alerter`

## 🏗️ Desarrollo Local

Si deseas contribuir o modificar el código:

1. **Instala dependencias**: `pnpm install`
2. **Desarrollo**: `pnpm dev`
3. **Construir**: `pnpm build`

## 🔗 Enlaces

- [Documentación de Komodo](https://docs.komo.do)
- [Model Context Protocol](https://modelcontextprotocol.io)
