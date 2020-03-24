# Move to the directory with the corresponding sample files and run Vale
# on them.
#
# Usage: run_vale BATS_TEST_FILENAME [SAMPLE_FILE]
function run_vale {
  # Strip the directory name from the supplied file name:
  local -r testname=${1##*/}

  # Determine whether the sample file was specified and replace it with
  # a dot if not:
  local -r filename=${2:-'.'}

  # Compose the path to the directory with sample files:
  local -r fixtures="fixtures/${testname/%.bats/}/"

  # Move the directory and run Vale on its contents:
  cd "$fixtures" && \vale --output line --no-wrap --sort --config vale.ini $filename
}
