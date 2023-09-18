#!/usr/bin/env bats

load test_helper

@test "Context in IDs: single quotes" {
  run run_vale "$BATS_TEST_FILENAME" test1.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "test1.adoc:1:1:ModularDocs.ContextInIDs:Use {context} in the section ID: [id='test-context" ]
  [ "${lines[1]}" = "test1.adoc:6:1:ModularDocs.ContextInIDs:Use {context} in the section ID: [id='test" ]
}

@test "Context in IDs: double quotes" {
  run run_vale "$BATS_TEST_FILENAME" test2.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "test2.adoc:1:1:ModularDocs.ContextInIDs:Use {context} in the section ID: [id=\"test-context" ]
  [ "${lines[1]}" = "test2.adoc:6:1:ModularDocs.ContextInIDs:Use {context} in the section ID: [id=\"test" ]
}

@test "Context in IDs: different separators" {
  run run_vale "$BATS_TEST_FILENAME" test3.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Context in IDs: commented out sections" {
  run run_vale "$BATS_TEST_FILENAME" test4.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}
