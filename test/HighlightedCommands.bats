#!/usr/bin/env bats

load test_helper

@test "Ignore command prompts in single-line comments" {
  run run_vale "$BATS_TEST_FILENAME" ignore_comment_lines.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Ignore command prompts in comment blocks" {
  run run_vale "$BATS_TEST_FILENAME" ignore_comment_blocks.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Ignore already highlighted commands" {
  run run_vale "$BATS_TEST_FILENAME" ignore_highlighted_commands.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Ignore invalid code blocks" {
  run run_vale "$BATS_TEST_FILENAME" ignore_invalid_code_blocks.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Ignore lines without an explicit command prompt" {
  run run_vale "$BATS_TEST_FILENAME" ignore_promptless_lines.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Recognize valid code block variations" {
  run run_vale "$BATS_TEST_FILENAME" report_code_block_variations.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "report_code_block_variations.adoc:3:1:ModularDocs.HighlightedCommands:Highlight commands entered at a shell prompt in bold." ]
  [ "${lines[1]}" = "report_code_block_variations.adoc:8:1:ModularDocs.HighlightedCommands:Highlight commands entered at a shell prompt in bold." ]
  [ "${lines[2]}" = "report_code_block_variations.adoc:13:1:ModularDocs.HighlightedCommands:Highlight commands entered at a shell prompt in bold." ]
  [ "${lines[3]}" = "report_code_block_variations.adoc:18:1:ModularDocs.HighlightedCommands:Highlight commands entered at a shell prompt in bold." ]
}

@test "Recognize common prompt variations" {
  run run_vale "$BATS_TEST_FILENAME" report_prompt_variations.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "report_prompt_variations.adoc:3:1:ModularDocs.HighlightedCommands:Highlight commands entered at a shell prompt in bold." ]
  [ "${lines[1]}" = "report_prompt_variations.adoc:8:1:ModularDocs.HighlightedCommands:Highlight commands entered at a shell prompt in bold." ]
  [ "${lines[2]}" = "report_prompt_variations.adoc:13:1:ModularDocs.HighlightedCommands:Highlight commands entered at a shell prompt in bold." ]
  [ "${lines[3]}" = "report_prompt_variations.adoc:18:1:ModularDocs.HighlightedCommands:Highlight commands entered at a shell prompt in bold." ]
}

@test "Report correct line numbers for identical commands" {
  run run_vale "$BATS_TEST_FILENAME" report_correct_line_numbers.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "report_correct_line_numbers.adoc:3:1:ModularDocs.HighlightedCommands:Highlight commands entered at a shell prompt in bold." ]
  [ "${lines[1]}" = "report_correct_line_numbers.adoc:8:1:ModularDocs.HighlightedCommands:Highlight commands entered at a shell prompt in bold." ]
}

@test "Do not mistake wild cards for highlighted commands" {
  run run_vale "$BATS_TEST_FILENAME" report_wild_cards.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "report_wild_cards.adoc:3:1:ModularDocs.HighlightedCommands:Highlight commands entered at a shell prompt in bold." ]
  [ "${lines[1]}" = "report_wild_cards.adoc:8:1:ModularDocs.HighlightedCommands:Highlight commands entered at a shell prompt in bold." ]
}
