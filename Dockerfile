# Usar Node.js 18 LTS como imagen base
FROM node:18-alpine

# Establecer directorio de trabajo
WORKDIR /app

# Copiar archivos de configuración de dependencias
COPY package.json pnpm-lock.yaml ./

# Instalar pnpm globalmente
RUN npm install -g pnpm

# Instalar dependencias
RUN pnpm install --frozen-lockfile

# Copiar código fuente
COPY src/ ./src/
COPY tsconfig.json ./
# Copiar script de entrada
COPY entrypoint.sh ./
RUN chmod +x ./entrypoint.sh


# Compilar TypeScript
RUN pnpm run build

# Instalar Python y uv para uvx
RUN apk add --no-cache python3 py3-pip curl && \
    curl -LsSf https://astral.sh/uv/install.sh | sh && \
    mv /root/.local/bin/uv /usr/local/bin/ && \
    mv /root/.local/bin/uvx /usr/local/bin/

# Crear usuario no-root para seguridad
RUN addgroup -g 1001 -S nodejs && \
    adduser -S komodo -u 1001

# Cambiar ownership de archivos
RUN chown -R komodo:nodejs /app
USER komodo

# Expose port for API
EXPOSE 3333 8090

# Default environment variables
ENV NODE_ENV=production \
    KOMODO_URL="" \
    KOMODO_KEY="" \
    KOMODO_SECRET="" \
    KOMODO_API_KEY=""

# Set entrypoint to generate config and start services
ENTRYPOINT ["./entrypoint.sh"]

# Default command - run both services
CMD ["sh", "-c", "npx -y supergateway --stdio 'node /app/dist/index.js' --port 3333 --baseUrl http://0.0.0.0:3333 --ssePath /sse --messagePath /message --cors & uvx mcpo --config ./komodo.json --port 8090 --api-key '' --hot-reload"]
