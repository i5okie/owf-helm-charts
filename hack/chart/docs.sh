#!/usr/bin/env bash
# docs.sh - Regenerate README for a chart using the appropriate generator based on values.yaml format.
# Usage: docs.sh <chart>

set -Eeuo pipefail
# Resolve repo root relative to this script to avoid dependence on caller CWD
script_dir=$(cd "$(dirname "$0")" && pwd)
# shellcheck source=../lib/log.sh
# shellcheck disable=SC1091
source "${script_dir}/../lib/log.sh"
chart="${1:-}"
[[ -z "${chart}" ]] && die "Usage: $0 <chart>"
repo_root=$(cd "${script_dir}/../.." && pwd)
chart_dir="${repo_root}/charts/${chart}"
values_file="${chart_dir}/values.yaml"
readme_file="${chart_dir}/README.md"
[[ ! -d "${chart_dir}" ]] && die "chart dir missing: ${chart_dir}"
[[ ! -f "${values_file}" ]] && die "values.yaml missing: ${values_file}"

# Detect which documentation tool to use based on values.yaml annotations
log_info "Detecting documentation format for ${chart}..."
doc_tool="none"

if grep -q "^## @param" "${values_file}"; then
  doc_tool="readme-generator"
  log_info "Detected readme-generator format (## @param annotations)"
elif grep -q "^# --" "${values_file}"; then
  doc_tool="helm-docs"
  log_info "Detected helm-docs format (# -- annotations)"
else
  log_warn "No documentation annotations found in values.yaml"
  log_warn "Consider adding '## @param' (readme-generator) or '# --' (helm-docs) annotations"
fi

# Generate README based on detected tool
if [[ "${doc_tool}" == "helm-docs" ]]; then
  if command -v helm-docs > /dev/null 2>&1; then
    log_info "Generating README with helm-docs"
    helm-docs -c "${chart_dir}"
  else
    die "helm-docs not found. Install: go install github.com/norwoodj/helm-docs/cmd/helm-docs@latest"
  fi
elif [[ "${doc_tool}" == "readme-generator" ]]; then
  BITNAMI_README_GENERATOR_VERSION="${BITNAMI_README_GENERATOR_VERSION:-}"
  pkg_name="@bitnami/readme-generator-for-helm"
  if [[ -n "${BITNAMI_README_GENERATOR_VERSION}" ]]; then
    pkg_spec="${pkg_name}@${BITNAMI_README_GENERATOR_VERSION}"
  else
    pkg_spec="${pkg_name}"
  fi

  if npx --yes --quiet "${pkg_spec}" --help > /dev/null 2>&1; then
    log_info "Generating README with Bitnami readme-generator"
    npx --yes "${pkg_spec}" --readme "${readme_file}" --values "${values_file}"
  else
    die "readme-generator not available. Install: npm install -g ${pkg_name}"
  fi
else
  log_warn "Skipping README generation (no documentation annotations found)"
  log_warn "To add documentation:"
  log_warn "  - For helm-docs: Add '# --' comments above values in values.yaml"
  log_warn "  - For readme-generator: Add '## @param' comments in values.yaml"
fi
