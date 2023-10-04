#!/usr/bin/env bats

load test_helper

@test "Ignore section IDs in code blocks" {
  run run_vale "$BATS_TEST_FILENAME" ignore_code_blocks.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Ignore section IDs in comment blocks" {
  run run_vale "$BATS_TEST_FILENAME" ignore_comment_blocks.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Ignore section IDs in single-line comments" {
  run run_vale "$BATS_TEST_FILENAME" ignore_comment_lines.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Ignore section IDs with the context attribute" {
  run run_vale "$BATS_TEST_FILENAME" ignore_context_variations.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Report section IDs without the context attribute" {
  run run_vale "$BATS_TEST_FILENAME" report_missing_context.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "report_missing_context.adoc:2:1:ModularDocs.ContextUsage:Use {context} in the section ID to enable module reuse." ]
}
