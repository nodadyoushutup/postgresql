#!/bin/bash
# database.sh

source utils.sh

drop_database() {
  owner="$1"
  db="$2"
  psql -U "$PGUSER" -h "$PGHOST" -p "$PGPORT" -c "DROP DATABASE \"$db\" WITH (FORCE);"
}

# Drop databases if they exist
for db in "${databases[@]}"; do
  # Map owner correctly
  owner=$(get_owner "$db")

  if database_exists "$db"; then
    echo "Database $db exists dropping database..."
    drop_database "$owner" "$db"
  else
    echo "Database $db doesn't exist."
  fi
done

echo "Reset script execution completed."
