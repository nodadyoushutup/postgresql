#!/bin/bash
# database.sh

source utils.sh

# Function to create a database with the specified owner
create_database() {
  owner="$1"
  db="$2"
  psql -U "$PGUSER" -h "$PGHOST" -p "$PGPORT" -c "CREATE DATABASE \"$db\" OWNER $owner;"
}

# Check and create databases if they don't exist, then set privileges
for db in "${databases[@]}"; do
  # Map owner correctly
  owner=$(get_owner "$db")

  if ! database_exists "$db"; then
    echo "Database $db does not exist. Creating database..."
    create_database "$owner" "$db"
  else
    echo "Database $db already exists."
  fi
done

echo "Database script execution completed."
