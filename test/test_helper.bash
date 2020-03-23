# Move to the directory with the corresponding sample files and run Vale
# on them.
#
# Usage: run_vale BATS_TEST_FILENAME
function run_vale {
  # Strip the directory name from the supplied file name:
  local -r basename="${1##*/}"

  # Compose the path to the directory with sample files:
  local -r fixtures="fixtures/${basename/%.bats/}/"

  # Move the directory and run Vale on its contents:
  cd "$fixtures" && \vale --output line --no-wrap --sort --config vale.ini .
}
