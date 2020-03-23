#!/usr/bin/env bats

load test_helper

@test "Context in section IDs" {
  run run_vale "$BATS_TEST_FILENAME"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "test.adoc:16:1:modular-docs.ContextInSectionIDs:Use {context} in the section ID." ]
}
