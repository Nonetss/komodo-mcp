#!/bin/sh

# Generar komodo.json dinámicamente usando las variables de entorno
cat <<EOF > /app/komodo.json
{
  "mcpServers": {
    "komodo": {
      "command": "node",
      "args": ["/app/dist/index.js"],
      "env": {
        "KOMODO_URL": "${KOMODO_URL}",
        "KOMODO_KEY": "${KOMODO_KEY}",
        "KOMODO_SECRET": "${KOMODO_SECRET}"
      }
    }
  }
}
EOF

echo "✅ komodo.json generado con éxito."

# Ejecutar el comando pasado al contenedor
exec "$@"
