# A custom makefile for the ModularDocs Vale style
# Copyright (C) 2020, 2023 Jaromir Hradilek

# General settings:
SHELL     = /bin/sh

# Source files and directories:
SRCSDIR   = ModularDocs
TESTDIR   = test
SRCS     := $(wildcard $(SRCSDIR)/*.yml)
TESTS    := $(wildcard $(TESTDIR)/*.bats)
LOGFILE   = CHANGELOG.adoc

# Command aliases:
BATS      = \bats
YAMLLINT  = \yamllint -s -f auto
CHANGELOG = \git log --pretty='{%D}* %s' | \sed -e 's/^{[^}]*tag: \([^},]\+\)[^}]*}/\n\#\# \1\n\n/;s/^{[^}]*}//;1i \# Changelog\n'

# Generate a changelog file from the revision hisotry:
.PHONY: changelog
changelog:
	@echo "Generating $(LOGFILE)..."
	@$(CHANGELOG) > $(LOGFILE)
	@echo "Done."

# Verify that all Vale rules are valid YAML files:
.PHONY: validate
validate: $(SRCS)
	@echo "Validating Vale rules in $(SRCSDIR)..."
	@$(YAMLLINT) $^
	@echo "Done."

# Verify that all Vale rules produce expected results on test data:
.PHONY: test
test: $(TESTS)
	@echo "Running test files in $(TESTDIR)..."
	@$(BATS) $^
	@echo "Done."

# Remove generated files:
.PHONY: clean
clean:
	@echo "Removing generated files:"
	-rm -f $(LOGFILE)
	@echo "Done."
