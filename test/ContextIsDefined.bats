#!/usr/bin/env bats

load test_helper

@test "Context is defined: context before include" {
  run run_vale "$BATS_TEST_FILENAME" test1.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Context is defined: context after include" {
  run run_vale "$BATS_TEST_FILENAME" test2.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "test2.adoc:2:1:modular-docs.ContextIsDefined:Define {context} before including other files: include::test.adoc" ]
}

@test "Context is defined: context without include" {
  run run_vale "$BATS_TEST_FILENAME" test3.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Context is defined: context without value" {
  run run_vale "$BATS_TEST_FILENAME" test4.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "test4.adoc:6:1:modular-docs.ContextIsDefined:Define {context} before including other files: include::test.adoc" ]
}

@test "Context is defined: include without context" {
  run run_vale "$BATS_TEST_FILENAME" test5.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "test5.adoc:4:1:modular-docs.ContextIsDefined:Define {context} before including other files: include::test.adoc" ]
}

@test "Context is defined: include on the first line" {
  run run_vale "$BATS_TEST_FILENAME" test6.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "test6.adoc:1:1:modular-docs.ContextIsDefined:Define {context} before including other files: include::test.adoc" ]
}
