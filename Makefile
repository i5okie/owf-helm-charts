###################################################################################################
# Makefile: OWF Helm Charts                                                                      #
# Goal: Simple, readable developer ergonomics mirroring CI (see hack/versions.env for tool pins)  #
###################################################################################################

SHELL := /usr/bin/env bash
.DEFAULT_GOAL := help
.PHONY: help tools-check lint ct-lint ct-install local-test docs _ensure-chart _cluster-name \
	sync-versions check test

# -------------------------------------------------------------------------------------------------
# Core variables
# -------------------------------------------------------------------------------------------------
CHART           ?=
CHART_PATH       = charts/$(CHART)
VERSIONS_FILE    = hack/versions.env
HELP_COLUMNS     = 28

# Load version pins (export all uppercase names)
include $(VERSIONS_FILE)
export $(shell sed -n 's/^\([A-Z0-9_]*\)=.*/\1/p' $(VERSIONS_FILE))

# -------------------------------------------------------------------------------------------------
# Helper / internal targets
# -------------------------------------------------------------------------------------------------
_ensure-chart: ## (internal) Validate CHART variable & path
	@if [ -z "$(CHART)" ]; then \
		echo "CHART variable required (e.g. make lint CHART=acapy)"; exit 1; \
	fi
	@if [ ! -d "$(CHART_PATH)" ]; then \
		echo "Chart directory $(CHART_PATH) not found"; exit 1; \
	fi

_cluster-name: ## (internal) Echo deterministic kind cluster name
	@echo owf-$(CHART)-dev

# -------------------------------------------------------------------------------------------------
# Help / meta
# -------------------------------------------------------------------------------------------------
help: ## List available targets with descriptions
	@echo "Available targets"; echo "-----------------"; \
	grep -hE '^[a-zA-Z0-9_.-]+:.*?##' $(MAKEFILE_LIST) | \
	  sed -E 's/^([a-zA-Z0-9_.-]+):.*?##\s*/\1: /' | \
	  awk -F': ' '{printf "% -$(HELP_COLUMNS)s %s\n", $$1, $$2}' | sort

sync-versions: ## Show pinned versions file
	@echo "Versions pinned in $(VERSIONS_FILE):"; echo; sed 's/^/# /' $(VERSIONS_FILE) | sed 's/^# #/#/'; echo

# -------------------------------------------------------------------------------------------------
# Tooling / environment
# -------------------------------------------------------------------------------------------------
tools-check: ## Verify installed tool versions match pins (drift => fail)
	@bash hack/dev/tools-check.sh

# -------------------------------------------------------------------------------------------------
# Linting / formatting
# -------------------------------------------------------------------------------------------------
lint: _ensure-chart ## Lint chart (Helm + YAML validation)
	@echo "[lint] Running helm lint..."
	@helm lint $(CHART_PATH)
	@echo "[lint] Running yamllint..."
	@if command -v yamllint >/dev/null 2>&1; then \
		yamllint -c .yamllint $(CHART_PATH); \
	else \
		echo "yamllint not installed; install with: pip install --user yamllint"; \
		exit 1; \
	fi
	@echo "[lint] ✓ All linting passed"

ct-lint: _ensure-chart ## chart-testing lint for CHART
	@if [ ! -f .github/ct.yaml ]; then echo "Missing .github/ct.yaml config"; exit 1; fi
	ct lint --charts $(CHART_PATH) --config .github/ct.yaml

# -------------------------------------------------------------------------------------------------
# Install tests
# -------------------------------------------------------------------------------------------------
ct-install: _ensure-chart ## Run ct install test in ephemeral kind cluster
	@hack/chart/ct-install.sh "$(CHART)"

test: ct-install ## Alias for install test

local-test: _ensure-chart ## Run local CI-like test: deps+lint+template+ct-install
	@hack/chart/local-test.sh "$(CHART)"

# -------------------------------------------------------------------------------------------------
# Documentation & Changelog
# -------------------------------------------------------------------------------------------------
docs: _ensure-chart ## Validate chart README is up-to-date
	@hack/chart/docs.sh "$(CHART)"

# -------------------------------------------------------------------------------------------------
# Check meta target (validation before PR)
# -------------------------------------------------------------------------------------------------
check: _ensure-chart ## Run all validations for CHART (lint suite + docs validation)
	@echo "[check] Running lint (helm + yaml)..."
	@$(MAKE) lint CHART=$(CHART) || exit 1
	@if [ -f .github/ct.yaml ]; then \
		echo "[check] Running ct lint..."; \
		$(MAKE) ct-lint CHART=$(CHART) || exit 1; \
	else \
		echo "[check] Skipping ct lint (no .github/ct.yaml)"; \
	fi
	@echo "[check] Validating README..."
	@$(MAKE) docs CHART=$(CHART) || exit 1
	@echo "[check] ✓ All checks passed"
