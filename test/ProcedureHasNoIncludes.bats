#!/usr/bin/env bats

load test_helper

@test "Procedure has no includes: procedure without includes" {
  run run_vale "$BATS_TEST_FILENAME" test1.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Procedure has no includes: includes before procedure" {
  run run_vale "$BATS_TEST_FILENAME" test2.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "test2.adoc:2:1:ModularDocs.ProcedureHasNoIncludes:Do not include files in procedure modules: include::test1.adoc[leveloffset=+1]" ]
  [ "${lines[1]}" = "test2.adoc:3:36:ModularDocs.ProcedureHasNoIncludes:Do not include files in procedure modules: include::test2.adoc[]" ]
}

@test "Procedure has no includes: includes after procedure" {
  run run_vale "$BATS_TEST_FILENAME" test3.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "test3.adoc:7:1:ModularDocs.ProcedureHasNoIncludes:Do not include files in procedure modules: include::test1.adoc[leveloffset=+1]" ]
  [ "${lines[1]}" = "test3.adoc:8:36:ModularDocs.ProcedureHasNoIncludes:Do not include files in procedure modules: include::test2.adoc[]" ]
}

@test "Procedure has no includes: CR+LF line ending" {
  run run_vale "$BATS_TEST_FILENAME" test4.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "test4.adoc:2:1:ModularDocs.ProcedureHasNoIncludes:Do not include files in procedure modules: include::test1.adoc[leveloffset=+1]" ]
  [ "${lines[1]}" = "test4.adoc:3:36:ModularDocs.ProcedureHasNoIncludes:Do not include files in procedure modules: include::test2.adoc[]" ]
}

@test "Procedure has no includes: LF line ending" {
  run run_vale "$BATS_TEST_FILENAME" test5.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "test5.adoc:2:1:ModularDocs.ProcedureHasNoIncludes:Do not include files in procedure modules: include::test1.adoc[leveloffset=+1]" ]
  [ "${lines[1]}" = "test5.adoc:3:36:ModularDocs.ProcedureHasNoIncludes:Do not include files in procedure modules: include::test2.adoc[]" ]
}
