#!/usr/bin/env bats

load test_helper

@test "Recognize comment lines" {
  run run_vale "$BATS_TEST_FILENAME" report_comment_lines.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "report_comment_lines.adoc:1:1:ModularDocs.ExcessiveComments:Commented lines should not exceed 50% of the file. Current number is 100%." ]
  [ "${lines[1]}" = "report_comment_lines.adoc:2:1:ModularDocs.ExcessiveComments:Commented lines should not exceed 50% of the file. Current number is 100%." ]
}

@test "Recognize comment blocks" {
  run run_vale "$BATS_TEST_FILENAME" report_comment_blocks.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "report_comment_blocks.adoc:1:1:ModularDocs.ExcessiveComments:Commented lines should not exceed 50% of the file. Current number is 100%." ]
}

@test "Recognize empty comment lines" {
  run run_vale "$BATS_TEST_FILENAME" report_empty_commet_lines.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "report_empty_commet_lines.adoc:1:1:ModularDocs.ExcessiveComments:Commented lines should not exceed 50% of the file. Current number is 66%." ]
  [ "${lines[1]}" = "report_empty_commet_lines.adoc:2:1:ModularDocs.ExcessiveComments:Commented lines should not exceed 50% of the file. Current number is 66%." ]
}

@test "Ignore invalid comment lines" {
  run run_vale "$BATS_TEST_FILENAME" ignore_invalid_comment_lines.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Ignore invalid comment blocks" {
  run run_vale "$BATS_TEST_FILENAME" ignore_invalid_comment_blocks.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "ignore_invalid_comment_blocks.adoc:3:1:ModularDocs.ExcessiveComments:Commented lines should not exceed 50% of the file. Current number is 87%." ]
}

@test "Ignore files with less than 50% of commented lines" {
  run run_vale "$BATS_TEST_FILENAME" ignore_forty_percent.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Ignore files with exactly 50% of commented lines" {
  run run_vale "$BATS_TEST_FILENAME" ignore_fifty_percent.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Report files with more than 50% of commented lines" {
  run run_vale "$BATS_TEST_FILENAME" report_sixty_percent.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "report_sixty_percent.adoc:1:1:ModularDocs.ExcessiveComments:Commented lines should not exceed 50% of the file. Current number is 60%." ]
  [ "${lines[1]}" = "report_sixty_percent.adoc:2:1:ModularDocs.ExcessiveComments:Commented lines should not exceed 50% of the file. Current number is 60%." ]
  [ "${lines[2]}" = "report_sixty_percent.adoc:3:1:ModularDocs.ExcessiveComments:Commented lines should not exceed 50% of the file. Current number is 60%." ]
}
