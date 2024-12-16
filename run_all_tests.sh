#!/bin/bash

set -e
set -o pipefail

echo "Running role tests in specified order..."

RESULTS_DIR="test_results"
ROLES_DIR="$PWD/collections/ansible_collections/rhsiqe/skupper/roles"
LOG_FILE="$RESULTS_DIR/$(date +%Y%m%d%H%M)_test.log"
STATUS_COLUMN=60  # Column where the status will start

# Create directory to store test results
mkdir -p "$RESULTS_DIR"

# Define the order of roles to test, with teardown last
ROLE_ORDER=(
  "env_shakeout"
  "generate_namespaces"
  "deploy_workload"
  "install_skupper"
  "skupper_site"
  "create_connector"
  "consume_service"
  "access_grant"
  "link_site"
  "expose_service"
  "run_curl"
)

# Function to calculate the number of dots needed
add_dots() {
  local text="$1"
  local status="$2"
  local time_info="$3"
  local text_length=${#text}
  local dots_count=$((STATUS_COLUMN - text_length))
  if (( dots_count < 0 )); then dots_count=0; fi
  local dots
  dots=$(printf '%*s' "$dots_count" '' | tr ' ' '.')
  printf "%s%s%s%s\n" "$text" "$dots" "$status" "$time_info"
}

# Function to run a role's test
run_role_test() {
  local role="$1"
  local test_dir="$ROLES_DIR/$role/tests"
  local playbook="$test_dir/test_playbook.yml"
  local inventory="$test_dir/inventory/hosts.yml"

  if [[ -f "$playbook" && -d "$test_dir/inventory" ]]; then
    # Start timer
    local start_time
    start_time=$(date +%s)

    # Run the ansible playbook and redirect output
    if ansible-playbook -i "$inventory" "$playbook" >> "$LOG_FILE" 2>&1; then
      # End timer
      local end_time
      end_time=$(date +%s)
      local elapsed_time=$((end_time - start_time))
      local status=" [PASSED]"
      local time_info=" [${elapsed_time}s]"
      add_dots "$role" "$status" "$time_info"
    else
      # End timer
      local end_time
      end_time=$(date +%s)
      local elapsed_time=$((end_time - start_time))
      local status=" [FAILED]"
      local time_info=" [${elapsed_time}s]"
      add_dots "$role" "$status" "$time_info"
      tail -n 10 "$LOG_FILE"  # Show last 10 lines of the log for debugging
      exit 1
    fi
  else
    local status=" [SKIPPED]"
    local time_info=" (No test_playbook.yml or inventory found)"
    add_dots "$role" "$status" "$time_info"
  fi
}

# Run tests in the defined order
for role in "${ROLE_ORDER[@]}"; do
  run_role_test "$role"
done

echo "All role tests completed."
