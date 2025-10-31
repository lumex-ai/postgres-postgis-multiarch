# Multi-Architecture PostgreSQL 17 + PostGIS 3.5
# Supports: linux/amd64, linux/arm64
# Built for testing with testcontainers

FROM ghcr.io/cloudnative-pg/postgresql:17

# PostGIS version configuration
ENV POSTGIS_MAJOR=3 \
    PG_MAJOR=17

# Switch to root to install packages
USER root

# Install PostGIS packages (works on both ARM64 and AMD64)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        postgresql-${PG_MAJOR}-postgis-${POSTGIS_MAJOR} \
        postgresql-${PG_MAJOR}-postgis-${POSTGIS_MAJOR}-scripts \
        postgis && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Switch back to postgres user
USER postgres

# Metadata
LABEL org.opencontainers.image.source="https://github.com/lumex-ai/postgres-postgis-multiarch"
LABEL org.opencontainers.image.description="Multi-architecture PostgreSQL 17 + PostGIS 3.5 for testing"
LABEL org.opencontainers.image.licenses="MIT"
LABEL maintainer="Lumex"
