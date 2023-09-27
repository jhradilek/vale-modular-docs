#!/usr/bin/env bats

load test_helper

@test "Ignore attribute definitions in single-line comments" {
  run run_vale "$BATS_TEST_FILENAME" ignore_comment_lines.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "ignore_comment_lines.adoc:6:1:ModularDocs.ContextDefinition:Define :context: to enable module reuse." ]
}

@test "Ignore attribute definitions in comment blocks" {
  run run_vale "$BATS_TEST_FILENAME" ignore_comment_blocks.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "ignore_comment_blocks.adoc:9:1:ModularDocs.ContextDefinition:Define :context: to enable module reuse." ]
}

@test "Ignore attribute definitions in code blocks" {
  run run_vale "$BATS_TEST_FILENAME" ignore_code_blocks.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "ignore_code_blocks.adoc:8:1:ModularDocs.ContextDefinition:Define :context: to enable module reuse." ]
}

@test "Ignore escaped conditional directives" {
  run run_vale "$BATS_TEST_FILENAME" ignore_escaped_conditionals.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "ignore_escaped_conditionals.adoc:4:1:ModularDocs.ContextDefinition:Store inherited context in :parent-context: before assigning a new value." ]
}

@test "Ignore escaped include directives" {
  run run_vale "$BATS_TEST_FILENAME" ignore_escaped_includes.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Ignore include directives in comment blocks" {
  run run_vale "$BATS_TEST_FILENAME" ignore_commented_includes.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Report missing context definition" {
  run run_vale "$BATS_TEST_FILENAME" report_missing_context_definition.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "report_missing_context_definition.adoc:2:1:ModularDocs.ContextDefinition:Define :context: to enable module reuse." ]
}

@test "Report missing context retention" {
  run run_vale "$BATS_TEST_FILENAME" report_missing_context_retention.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "report_missing_context_retention.adoc:2:1:ModularDocs.ContextDefinition:Store inherited context in :parent-context: before assigning a new value." ]
}

@test "Report missing context restoration" {
  run run_vale "$BATS_TEST_FILENAME" report_missing_context_restoration.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "report_missing_context_restoration.adoc:2:1:ModularDocs.ContextDefinition:Restore inherited context from :parent-context: at the end of the file." ]
}

@test "Recognize include directives in code blocks" {
  run run_vale "$BATS_TEST_FILENAME" report_code_blocks.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "report_code_blocks.adoc:3:1:ModularDocs.ContextDefinition:Define :context: to enable module reuse." ]
}

@test "Recognize parent context name variations" {
  run run_vale "$BATS_TEST_FILENAME" report_parent_context_variations.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

