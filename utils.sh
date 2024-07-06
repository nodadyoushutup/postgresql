#!/bin/bash
# utils.sh

# PostgreSQL credentials
PGUSER="postgres"
PGPASSWORD="postgres"
PGHOST="localhost"
PGPORT="5432"

# Arrays of users and corresponding databases
users=(
  "jellyseerr"
  "lidarr"
  "prowlarr"
  "radarr"
  "readarr"
  "rtorrent"
  "sonarr"
)

databases=(
  "jellyseerr"
  "lidarr-log"
  "lidarr-main"
  "prowlarr-log-book"
  "prowlarr-main-book"
  "prowlarr-log-cross-seed"
  "prowlarr-main-cross-seed"
  "prowlarr-log-movie"
  "prowlarr-main-movie"
  "prowlarr-log-music"
  "prowlarr-main-music"
  "prowlarr-log-television"
  "prowlarr-main-television"
  "radarr-log"
  "radarr-log"
  "radarr-main"
  "readarr-log"
  "readarr-main"
  "rtorrent-book"
  "rtorrent-cross-seed"
  "rtorrent-movie"
  "rtorrent-music"
  "rtorrent-television"
  "sonarr-log"
  "sonarr-main"
  "tautulli"
)

# Export the PostgreSQL password to avoid password prompts
export PGPASSWORD="$PGPASSWORD"


# Function to map the correct owner for each database
get_owner() {
  case "$1" in
    jellyseerr) echo "jellyseerr" ;;
    lidarr-*) echo "lidarr" ;;
    prowlarr-*) echo "prowlarr" ;;
    radarr-*) echo "radarr" ;;
    readarr-*) echo "readarr" ;;
    rtorrent-*) echo "rtorrent" ;;
    sonarr-*) echo "sonarr" ;;
    tautulli) echo "radarr" ;;
    *) echo "${1%-*}" ;;
  esac
}

# Function to check if a database exists
database_exists() {
  psql -U "$PGUSER" -h "$PGHOST" -p "$PGPORT" -tAc "SELECT 1 FROM pg_database WHERE datname='$1'" | grep -q 1
}