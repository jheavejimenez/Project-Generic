#!/bin/bash
git fetch
git branch
CHANGED_FILES=`git diff origin/develop --numstat **/migrations`
existing_apps=()
while IFS=$'\n' read -ra ADDR; do
  for line in "${ADDR[@]}"; do
    if [[ $line == 0* ]]; then
      echo "DELETED: $line..."
    else
      [[ $line =~ ([a-z/]+[0-9_a-z]+.py) ]]
      new_migration=$BASH_REMATCH

      [[ $line =~ ^([0-9]+[[:space:]]+0) ]]
      num_changes=$BASH_REMATCH

      if [[ ! $num_changes ]]; then
        echo "CHANGED MIGRATION: $new_migration"
        continue
      fi

      [[ $line =~ (_merge_) ]]
      merged=$BASH_REMATCH

      if [[ $merged ]]; then
        echo "MERGE MIGRATION: $new_migration"
        continue
      fi

      echo "NEW MIGRATION: $new_migration"

      [[ $line =~ ([a-z]+/) ]]
      app=$BASH_REMATCH

      existing=$(echo ${existing_apps[@]} | grep -o $app | wc -w)
      if [[ $existing -gt 0 ]]; then
          echo "Found multiple new migrations in $app! Please squash your new migrations!"
          exit 1
      fi
      existing_apps+=($app)
    fi
  done
done <<< "$CHANGED_FILES"
