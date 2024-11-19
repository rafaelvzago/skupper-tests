#!/bin/bash

set -e
set -o pipefail

echo "Running role tests in specified order..."

RESULTS_DIR="test_results"
ROLES_DIR="$PWD/collections/ansible_collections/rhsiqe/skupper/roles"
LOG_FILE="test_run.log"
LINE_LENGTH=60  # Length of the line for the dots

# Create directory to store test results
mkdir -p $RESULTS_DIR

# Define the order of roles to test, with teardown last
ROLE_ORDER=(
  "env_shakeout"
  "generate_namespaces"
  "deploy_workload"
  "install_skupper"
  "skupper_site"
  "expose_connector"
  "consume_service"
  "teardown_namespaces"  # Teardown should be the last role to run
)

# Function to calculate the number of dots needed
add_dots() {
  local text=$1
  local dots_count=$((LINE_LENGTH - ${#text} - 10))  # Reserve space for status
  printf "%s" "$text"
  for ((i = 0; i < dots_count; i++)); do
    printf "."
  done
}

# Function to run a role's test
run_role_test() {
  local role=$1
  local test_dir="$ROLES_DIR/$role/tests"
  local playbook="$test_dir/test_playbook.yml"
  local inventory="$test_dir/inventory/hosts.yml"

  if [[ -f "$playbook" && -d "$test_dir/inventory" ]]; then
    add_dots "$role"

    # Redirect full output to the log file, and only show the simplified result
    if ansible-playbook -i "$inventory" "$playbook" >> "$LOG_FILE" 2>&1; then
      echo " [PASSED]"
    else
      echo " [FAILED]"
      tail -n 10 "$LOG_FILE"  # Show last 10 lines of the log for debugging
      exit 1
    fi
  else
    add_dots "$role"
    echo " [SKIPPED] (No test_playbook.yml or inventory found)"
  fi
}

# Run tests in the defined order
for role in "${ROLE_ORDER[@]}"; do
  run_role_test "$role"
done

echo "All role tests completed."
