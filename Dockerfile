# syntax=docker/dockerfile:1
FROM alpine:3.18                              # Base minimalista, <5 MB :contentReference[oaicite:1]{index=1}

# Instalar dependencias necesarias
RUN apk update && apk add --no-cache \
      ca-certificates \
      libstdc++ \
      boost-dev \
      openssl-dev \
      git make g++            # Build tools para compilar ckpool :contentReference[oaicite:2]{index=2}

# Directorio de trabajo
WORKDIR /bchpool                             # Ubicación estándar en la imagen :contentReference[oaicite:3]{index=3}

# Copiar código de tu fork
COPY . .                                     # Copia todo el contenido de bchp/ al contexto de build :contentReference[oaicite:4]{index=4}

# Compilar el pool
RUN make                                   # Asume que tu fork incluye Makefile para ckpool :contentReference[oaicite:5]{index=5}

# Puertos y comando de arranque
EXPOSE 32888                                # Puerto Stratum por defecto :contentReference[oaicite:6]{index=6}
CMD ["./bchpool", "--config", "/bchpool/ckpool.conf"]
