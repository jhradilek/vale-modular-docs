#!/usr/bin/env bats

load test_helper

@test "Context is defined" {
  run run_vale "$BATS_TEST_FILENAME"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "test3.adoc:2:1:modular-docs.ContextIsDefined:Define {context} when including other files." ]
  [ "${lines[1]}" = "test4.adoc:4:1:modular-docs.ContextIsDefined:Define {context} when including other files." ]
  [ "${lines[2]}" = "test5.adoc:6:1:modular-docs.ContextIsDefined:Define {context} when including other files." ]
}
