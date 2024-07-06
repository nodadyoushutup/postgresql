#!/bin/bash
# user.sh

source utils.sh

# Function to check if a user exists
user_exists() {
  psql -U "$PGUSER" -h "$PGHOST" -p "$PGPORT" -tAc "SELECT 1 FROM pg_roles WHERE rolname='$1'" | grep -q 1
}

# Function to create a user with superuser privileges
create_user() {
  psql -U "$PGUSER" -h "$PGHOST" -p "$PGPORT" -c "CREATE USER $1 WITH SUPERUSER PASSWORD '$1';"
}

# Check and create users if they don't exist
for user in "${users[@]}"; do
  if ! user_exists "$user"; then
    echo "User $user does not exist. Creating user..."
    create_user "$user"
  else
    echo "User $user already exists."
  fi
done

echo "User script execution completed."