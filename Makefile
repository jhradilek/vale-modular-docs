# A custom makefile for the modular-docs Vale style.
# Copyright (C) 2020 Jaromir Hradilek <jhradilek@gmail.com>

# General settings:
SHELL    = /bin/sh

# Source files and directories:
SRCSDIR  = modular-docs
TESTDIR  = test
SRCS    := $(wildcard $(SRCSDIR)/*.yml)
TESTS   := $(wildcard $(TESTDIR)/*.bats)

# The yamllint command:
YAMLLINT = \yamllint -s -f auto

# The bats command:
BATS     = \bats

# Check all Vale rules to ensure they are valid YAML files:
.PHONY: validate
validate: $(SRCS)
	@echo "Validating Vale rules in $(SRCSDIR)..."
	@$(YAMLLINT) $^
	@echo "Done."

# Run all tests to ensure Vale rules produce expected results:
.PHONY: test
test: $(TESTS)
	@echo "Running test files in $(TESTDIR)..."
	@$(BATS) $^
	@echo "Done."
