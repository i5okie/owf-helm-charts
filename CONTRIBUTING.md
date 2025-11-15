# Contributing to OpenWallet Foundation Helm Charts

Thank you for contributing to the OpenWallet Foundation Helm Charts repository!

To maintain clarity, consistency, and automation reliability, please follow these contribution guidelines.

## General Guidelines

- **Keep PRs focused:** Each pull request should be scoped to a single chart.
  - You may introduce **one new** Helm chart, **or**
  - Modify **one existing** Helm chart.
  - Please don't include changes for multiple charts in the same PR (CI validates this for you).

- **Chart Location:** Create new charts under `charts/<CHART>` using a unique, meaningful name that reflects the OWF project the chart supports.

- **Chart Versioning:** Do NOT bump the chart `version` in `Chart.yaml` for normal changes; the Release PR automation handles version increments.

- **Maintainers:** Ensure that a valid `maintainers` list is included in the chart’s `Chart.yaml`.

- **Documentation:**
  - Keep `values.yaml` annotations current; CI enforces README regeneration.
  - Preferred generator: `helm-docs` (fast, common in Helm repos). Alternative: Bitnami README generator.
    - Run via helper (auto-detects either tool): `make docs CHART=<CHART>` or `hack/chart/docs.sh <CHART>`
    - Use helm-docs directly: `helm-docs -c charts/<CHART>`
    - Use Bitnami directly: `npx @bitnami/readme-generator-for-helm --readme charts/<CHART>/README.md --values charts/<CHART>/values.yaml`
  - Do NOT manually edit `CHANGELOG.md`; Release PR automation prepends entries using conventional-changelog.
  - New scripts should source the shared logging helpers `hack/lib/log.sh` and use `log_info`, `log_warn`, `log_error`, `die` for consistent output.
  - Tool versions are pinned in `hack/versions.env` and validated by `hack/dev/tools-check.sh`. Pins cover helm, kubectl, kind, yq, jq, shellcheck, shfmt, helm-docs, yamllint, Node-based generators, ct, and chart-releaser.

## Testing & Validation

All testing commands require `CHART=<name>` parameter (e.g., `acapy`, `vc-authn-oidc`, `endorser-service`).

### Quick Reference

```bash
make check CHART=acapy           # Fast (~30s): lint + docs validation
make test CHART=acapy            # Full (~5m): deps + lint + template + install
make lint CHART=acapy            # Lint only (helm + yaml + maintainers + version)
make install CHART=acapy         # Install test only (requires kind cluster)
make docs CHART=acapy            # Regenerate/validate README
```

### Recommended Workflow

1. **During development** - Run `make check CHART=<name>` frequently for fast feedback:
   - Validates chart structure with `ct lint` (includes helm lint, yamllint, maintainers, version checks)
   - Ensures README is up-to-date with values.yaml annotations
   - Takes ~30 seconds, no cluster required

2. **Before opening PR** - Run `make test CHART=<name>` for full validation:
   - Builds chart dependencies
   - Runs all linting checks
   - Smoke tests template rendering
   - Installs chart in ephemeral kind cluster
   - Takes ~3-5 minutes (cluster creation is slow)

3. **Debugging install issues** - Use `make install CHART=<name>`:
   - Skips linting (faster iteration)
   - Only runs the kind cluster install test
   - Useful when linting passes but install fails

### What Each Target Does

- **`make check`**: Pre-PR sanity check (fast)
  - `ct lint` - validates chart structure, YAML, maintainers, version increment
  - `make docs` - ensures README matches values.yaml

- **`make test`**: Full CI-like test suite (slow but comprehensive)
  - Builds Helm dependencies
  - Runs `ct lint`
  - Renders templates with `helm template` (smoke test)
  - Creates kind cluster and runs `ct install`
  - Mirrors CI workflow exactly

- **`make lint`**: Just the chart-testing lint
  - Runs `helm lint` (chart structure validation)
  - Runs `yamllint` (YAML syntax validation)
  - Validates maintainers in Chart.yaml
  - Checks version increment (can fail during development - this is expected)

- **`make install`**: Just the install test
  - Creates ephemeral kind cluster
  - Installs chart using `ct install`
  - Uses `ci/*-values.yaml` files if present

## Pre-commit Hooks (Optional)

Pre-commit hooks help catch common issues before pushing to CI. Setup is optional but recommended:

```bash
# Install pre-commit (if not already installed)
pip install pre-commit

# Enable pre-commit checks
pre-commit install

# Enable commit message validation
pre-commit install --hook-type commit-msg

# Run manually on all files
pre-commit run --all-files
```

The hooks validate:
- Commit messages follow Conventional Commits (feat, fix, docs, etc.)
- YAML syntax in `values.yaml` and `Chart.yaml`
- Shell scripts in `hack/` (shellcheck)
- File hygiene (trailing whitespace, merge conflicts)

## CI / Test-Install Values (Kind-friendly)

- To supply CI-only overrides without changing chart defaults, add one or more files under:
`charts/<CHART>/ci/*-values.yaml`

  Examples:
  - `charts/acapy/ci/ci-values.yaml`
  - `charts/acapy/ci/disable-ingress-values.yaml`
  - `charts/acapy/ci/minimal-values.yaml`

- The chart-testing tool (`ct`) **automatically discovers** and uses any files ending in `-values.yaml` in the `ci/` folder during test installs.

- **Packaging tip:** Add the following to your chart’s `.helmignore` so CI-only files aren’t included in release artifacts: `ci/*.*`


## CI/CD and Automation (Release PR Model)

We use the Release PR workflow for versioning & publishing:

1. Feature/fix PRs DO NOT bump `Chart.yaml` version.
2. All commits must follow Conventional Commits. Include the chart scope in your PR title: `<type>(<chart>): <description>` (e.g., `feat(acapy): add health check probe`).
3. A scheduled (or manually triggered) workflow detects changes since the last tag (`<chart>-<version>`), classifies commits, and opens/updates a Release PR: `release/<chart>-vX.Y.Z`.
4. The Release PR updates `Chart.yaml`, prepends a new changelog section (generated via conventional-changelog), and regenerates README from annotated values.
5. Maintainers can apply labels to adjust or defer release:

- `bump:major | bump:minor | bump:patch` (override)
- `no-release` (skip publishing but keep aggregating commits)

6. Merging the Release PR triggers packaging with chart-releaser and index update on `gh-pages`.
7. All workflows and scripts source tool versions from `hack/versions.env` to keep local and CI in sync.

Helm repo usage:

```bash
helm repo add owf https://openwallet-foundation.github.io/helm-charts
helm repo update
helm search repo owf
helm install my-release owf/acapy --version <x.y.z>
```

Changelog generation uses conventional-changelog (Conventional Commits preset) scoped to the chart path for deterministic entries.

### Manually trigger the Release‑PR workflow (maintainers)

You can run the Release‑PR workflow on demand via the Actions tab:

- Actions → "Generate Release PRs" → Run workflow
- Inputs:
  - `chart` (optional): limit processing to a single chart (e.g., `acapy`). If provided, the same deterministic bump/filtering is applied but scoped to `charts/<chart>`.

Notes:
- The workflow is idempotent and safe to re‑run; concurrency guards prevent per‑chart races.
- Manual runs are restricted to repository maintainers/admins.
- For Release‑PR logic, prefer the local helper script which mirrors CI without remote pushes:

```bash
hack/chart/release-pr.sh <chart> --no-pr
# e.g.,
hack/chart/release-pr.sh acapy --no-pr
```

### Local helper: release-pr.sh (for maintainers)

For convenience when testing releases locally, a helper script mirrors the CI Release‑PR flow without replacing it:

- Script: `hack/chart/release-pr.sh`
- Purpose: Compose the same smaller scripts CI uses to prepare a release branch and open a PR.
- What it does:
  - Detects the last chart tag (`<chart>-<semver>`)
  - Classifies commits scoped to `charts/<chart>` to decide the bump level
  - Computes the next version and updates `Chart.yaml`
  - Regenerates `README.md` and `CHANGELOG.md` deterministically
  - Creates `release/<chart>-v<version>` branch, commits, and optionally opens a PR
- Usage:
  - `hack/chart/release-pr.sh <chart> [--base <branch>] [--no-pr]`
  - Examples: `hack/chart/release-pr.sh acapy`, `hack/chart/release-pr.sh acapy --base main --no-pr`
- Requirements: git, yq, Node (npx); GitHub CLI (`gh`) optional for opening the PR.

Notes:
- CI does not call this script; it calls `hack/release/classify_commits.sh`, `hack/release/next_version.sh`, `hack/release/update_chart_version.sh`, `hack/chart/docs.sh`, and `hack/chart/changelog.sh` directly.
- Do not hand‑edit `CHANGELOG.md` or README in Release PRs; they are generated.

### Notes
- Prefer small, focused PRs.
- Keep `CHANGELOG.md` meaningful (features, fixes, breaking changes).
- Consider adding `OWNERS`/CODEOWNERS for charts you maintain.

By adhering to these rules, you help ensure a smooth, automated release process and make reviewing PRs easier for maintainers. Thank you!
