#!/usr/bin/env bats

load test_helper

@test "Ignore empty lines after include directives" {
  run run_vale "$BATS_TEST_FILENAME" ignore_empty_lines_after_includes.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Ignore include directives in single-line comments" {
  run run_vale "$BATS_TEST_FILENAME" ignore_comment_lines.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Ignore include directives in comment blocks" {
  run run_vale "$BATS_TEST_FILENAME" ignore_comment_blocks.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Ignore escaped include directives" {
  run run_vale "$BATS_TEST_FILENAME" ignore_escaped_includes.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Ignore comments between include directives" {
  run run_vale "$BATS_TEST_FILENAME" ignore_comments_between_includes.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "ignore_comments_between_includes.adoc:1:1:ModularDocs.EmptyLineAfterInclude:Add an empty line after the include directive." ]
  [ "${lines[1]}" = "ignore_comments_between_includes.adoc:6:1:ModularDocs.EmptyLineAfterInclude:Add an empty line after the include directive." ]
}

@test "Report include directives not followed by empty lines" {
  run run_vale "$BATS_TEST_FILENAME" report_includes_without_empty_lines.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "report_includes_without_empty_lines.adoc:2:1:ModularDocs.EmptyLineAfterInclude:Add an empty line after the include directive." ]
  [ "${lines[1]}" = "report_includes_without_empty_lines.adoc:3:1:ModularDocs.EmptyLineAfterInclude:Add an empty line after the include directive." ]
  [ "${lines[2]}" = "report_includes_without_empty_lines.adoc:5:1:ModularDocs.EmptyLineAfterInclude:Add an empty line after the include directive." ]
}

@test "Recognize include directives in code blocks" {
  run run_vale "$BATS_TEST_FILENAME" report_code_blocks.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "report_code_blocks.adoc:3:1:ModularDocs.EmptyLineAfterInclude:Add an empty line after the include directive." ]
}

@test "Recognize common include directive variations" {
  run run_vale "$BATS_TEST_FILENAME" report_include_variations.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "report_include_variations.adoc:2:1:ModularDocs.EmptyLineAfterInclude:Add an empty line after the include directive." ]
  [ "${lines[1]}" = "report_include_variations.adoc:3:1:ModularDocs.EmptyLineAfterInclude:Add an empty line after the include directive." ]
  [ "${lines[2]}" = "report_include_variations.adoc:4:1:ModularDocs.EmptyLineAfterInclude:Add an empty line after the include directive." ]
  [ "${lines[3]}" = "report_include_variations.adoc:5:1:ModularDocs.EmptyLineAfterInclude:Add an empty line after the include directive." ]
  [ "${lines[4]}" = "report_include_variations.adoc:6:1:ModularDocs.EmptyLineAfterInclude:Add an empty line after the include directive." ]
}
