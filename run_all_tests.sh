#!/bin/bash

set -e
set -o pipefail

echo "Running all role tests..."

ROLES_DIR="$PWD/collections/ansible_collections/rhsiqe/skupper/roles"
RESULTS_DIR="test_results"

# Create a directory to store test results
mkdir -p $RESULTS_DIR

for role in $(ls $ROLES_DIR); do
  TEST_DIR="$ROLES_DIR/$role/tests"
  PLAYBOOK="$TEST_DIR/test_playbook.yml"
  INVENTORY="$TEST_DIR/inventory/hosts.yml"

  if [[ -f "$PLAYBOOK" && -d "$TEST_DIR/inventory" ]]; then
    echo "Running tests for role: $role"
    ansible-playbook -i "$INVENTORY" "$PLAYBOOK" | tee "$RESULTS_DIR/${role}_result.log"

    if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
      echo "Role $role: SUCCESS"
    else
      echo "Role $role: FAILURE"
      exit 1
    fi
  else
    echo "Skipping $role: No test_playbook.yml or inventory found"
  fi
done

echo "All role tests completed."
