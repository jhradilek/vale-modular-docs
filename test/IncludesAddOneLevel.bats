#!/usr/bin/env bats

load test_helper

@test "Includes add one level: add levels inline" {
  run run_vale "$BATS_TEST_FILENAME" test1.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "test1.adoc:8:1:ModularDocs.IncludesAddOneLevel:Use leveloffset to add one level at most: include::test4.adoc[leveloffset=+2]" ]
  [ "${lines[1]}" = "test1.adoc:9:1:ModularDocs.IncludesAddOneLevel:Use leveloffset to add one level at most: include::test5.adoc[leveloffset=+10]" ]
}

@test "Includes add one level: subtract levels inline" {
  run run_vale "$BATS_TEST_FILENAME" test2.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Includes add one level: set absolute levels inline" {
  run run_vale "$BATS_TEST_FILENAME" test3.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Includes add one level: add levels separately" {
  run run_vale "$BATS_TEST_FILENAME" test4.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "test4.adoc:15:1:ModularDocs.IncludesAddOneLevel:Use leveloffset to add one level at most: :leveloffset: +2" ]
  [ "${lines[1]}" = "test4.adoc:19:1:ModularDocs.IncludesAddOneLevel:Use leveloffset to add one level at most: :leveloffset: +10" ]
}

@test "Includes add one level: subtract levels separately" {
  run run_vale "$BATS_TEST_FILENAME" test5.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Includes add one level: set absolute levels separately" {
  run run_vale "$BATS_TEST_FILENAME" test5.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}
