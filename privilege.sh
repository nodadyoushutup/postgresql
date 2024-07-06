#!/bin/bash
# build.sh

source utils.sh

# Function to set privileges for a database
set_privileges() {
  db="$1"
  owner="$2"
  revoke_query="REVOKE ALL ON DATABASE \"$db\" FROM PUBLIC;"
  grant_query="GRANT ALL PRIVILEGES ON DATABASE \"$db\" TO $owner;"
  
  psql -U "$PGUSER" -h "$PGHOST" -p "$PGPORT" -c "$revoke_query"
  psql -U "$PGUSER" -h "$PGHOST" -p "$PGPORT" -c "$grant_query"
}


# Check and create databases if they don't exist, then set privileges
for db in "${databases[@]}"; do
  # Map owner correctly
  owner=$(get_owner "$db")

  echo "Setting privileges for database $db..."
  set_privileges "$db" "$owner"
done

echo "Privilege script execution completed."
