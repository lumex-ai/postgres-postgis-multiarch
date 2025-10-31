#
# Multi-Architecture PostgreSQL 17 + PostGIS 3.5
# Supports: linux/amd64, linux/arm64
# Built for cross-platform use in testcontainers
#

FROM postgres:17-bookworm

LABEL maintainer="Lumex" \
      org.opencontainers.image.description="Multi-architecture PostgreSQL 17 + PostGIS 3.5 for testcontainers" \
      org.opencontainers.image.source="https://github.com/lumex-ai/postgres-postgis-multiarch" \
      org.opencontainers.image.licenses="MIT"

ENV POSTGIS_MAJOR=3
ENV POSTGIS_VERSION=3.5.*

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
           ca-certificates \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts \
      && rm -rf /var/lib/apt/lists/*

# Copy PostGIS initialization script
RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/10_postgis.sh
