# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

**Last Updated**: 2025-10-21
**Version**: 2.1.0

### Recent Changes
- **2.1.0** (2025-10-21): Added Credentials & Publishing section documenting 1Password token retrieval, local deployment script, and troubleshooting. Updated IELTS requirement to Level 8.5.
- **2.0.0** (2025-10-20): Documented 7-step application process, updated clinic timeline, added position-specific training content.
- **1.0.0**: Initial documentation structure.

## Project Overview

This is a Quarto-based static website for dental career opportunities at Dr. Phoebe Tsang's pediatric dental practice. The site serves as a comprehensive job portal featuring multiple position listings with detailed requirements, assessments, and application processes.

## Architecture

### Core Structure
- **Main Portal**: `index.qmd` - Primary career opportunities page with application process
- **Position Pages**: Individual `.qmd` files for each role:
  - `certified_dental_assistant.qmd`
  - `procedural_sedation_nurse.qmd` 
  - `treatment_coordinator.qmd`
- **Supporting Content**: `etiquettes/` directory contains professional standards documentation
- **Styling**: `styles.css` provides custom styling for job listing prominence and scenario cards

### Publishing Architecture
- **Build System**: Quarto CLI renders all `.qmd` files to static HTML
- **Hosting**: Quarto Pub at `https://pedodontist.quarto.pub/dental-career-opportunities/`
- **Automation**: GitHub Actions workflow automatically publishes on push to `main` branch
- **Content Exclusions**: `etiquettes/` directory excluded from rendering via `_quarto.yml`

## Common Commands

### Local Development
```bash
# Install Quarto CLI (if not installed)
# Follow: https://quarto.org/docs/get-started/

# Preview site locally
quarto preview

# Render site (builds to _site/)
quarto render

# Check Quarto setup and configuration
quarto check
```

### Publishing

**Quick Start**:
```bash
# Option 1: Use deployment script (reads credentials from 1Password automatically)
./deploy-local.sh

# Option 2: Manual commands
quarto render
export QUARTO_PUB_AUTH_TOKEN=$(op read "op://Employee/ycy5ki32hkoaqymrnc4w46i6tm/password")
quarto publish quarto-pub --no-browser --no-prompt --no-render

# Option 3: GitHub Actions (automatic on push)
git push origin main  # Triggers .github/workflows/publish.yml
```

See **Credentials & Publishing** section below for token retrieval and environment setup.

### Content Management
```bash
# Add new position (create new .qmd file, update _quarto.yml navbar)
# Follow existing position file structure and include:
# - Position overview and role details
# - Office culture examples (positive/negative scenario cards)
# - Required qualifications and knowledge assessments
# - Employee guidelines appendix

# Update IELTS requirements across all files
grep -r "Level [0-9]" *.qmd  # Find current requirements
```

## Key Configuration Files

### `_quarto.yml`
- Website configuration and navigation structure
- Theme: Cosmo with custom CSS
- **Critical**: Render exclusions prevent internal docs from public site
- Must be updated when adding new position pages to navbar menu

### `_publish.yml` 
- Contains Quarto Pub project ID and URL mapping
- Links to live site configuration

### `.github/workflows/publish.yml`
- Automated publishing pipeline
- Triggers on push to main branch
- Requires `QUARTO_PUB_AUTH_TOKEN` repository secret (see **Credentials & Publishing** section)
- Includes caching and error handling

## Content Standards

### Position Page Structure
Each position page follows a consistent template:
1. About Us section
2. Position Overview with role details
3. Ideal Candidate qualifications
4. Office Culture with scenario examples
5. Required Qualifications (language and knowledge assessments)
6. Compensation and Benefits
7. Employee Guidelines appendix

### Assessment Integration
- IELTS Speaking Level requirements (Level 8.5 — native-level proficiency)
- SmallTalk2Me assessment platform integration
- QuizGecko knowledge assessment links
- Specific assessment codes for each position type

### Styling Conventions
- `.scenario-card.positive` and `.scenario-card.negative` for culture examples
- Special styling for job position links under `#current-opportunities`
- Consistent callout blocks for important information

## Publishing Notes

**Automated** (preferred): Push to `main` branch; GitHub Actions handles rendering and publishing.

**Local**: Use `./deploy-local.sh` or manual commands (see **Credentials & Publishing** section).

**Live Site**: https://pedodontist.quarto.pub/dental-career-opportunities/

**Details**: All publishing methods documented in **Credentials & Publishing** section, including token retrieval, three publishing approaches, environment setup, and troubleshooting.

## Internal Documentation Security

**CRITICAL**: All internal development files must be excluded from public site via `_quarto.yml` render exclusions:
- `CLAUDE.md`, `README.md` - Development documentation  
- `project-proposal.qmd` - Internal planning documents
- `docs/` - Development workflows and guides
- `etiquettes/` - Internal professional standards
- Any other non-job-applicant content

**Verification**: After render, only these files should exist in `_site/`:
- `index.html` - Main career portal
- `certified_dental_assistant.html`
- `procedural_sedation_nurse.html`
- `treatment_coordinator.html`
- Supporting assets (CSS, JS, images)

---

## Credentials & Publishing

### Overview
The site publishes to Quarto Pub, which requires authentication. Credentials are stored in 1Password and accessed via `op` CLI.

**Credential Source**: 1Password Employee vault
**Item**: Quarto Pub Phoebe dmd0876@gmail.com (ID: `ycy5ki32hkoaqymrnc4w46i6tm`)

### Token Retrieval

The Quarto Pub token is stored in the 1Password item's notes field (not the password field).

**Token Value** (for reference):
```
qpa_4vx5aKITzOxuB3myIShyVnAyNty7JkVGV0rmpHJHTNs02kzcG0H0zqJjXRddvTCB
```

**To retrieve via 1Password CLI**:
```bash
op read "op://Employee/ycy5ki32hkoaqymrnc4w46i6tm/password"
```

### Publishing Methods

#### Method 1: Local Script (Recommended)
The `deploy-local.sh` script handles rendering and publishing automatically:
```bash
./deploy-local.sh
```

The script:
1. Renders all `.qmd` files locally
2. Retrieves token from 1Password
3. Publishes to Quarto Pub without re-rendering
4. Reports success/failure

#### Method 2: Manual Local Publishing
```bash
# Render all content
quarto render

# Set token from 1Password
export QUARTO_PUB_AUTH_TOKEN=$(op read "op://Employee/ycy5ki32hkoaqymrnc4w46i6tm/password")

# Publish (without re-rendering)
quarto publish quarto-pub --no-browser --no-prompt --no-render
```

#### Method 3: GitHub Actions (Automatic)
- Push changes to `main` branch
- Workflow `.github/workflows/publish.yml` triggers automatically
- Site publishes within 1-2 minutes
- Token stored in GitHub repository secret: `QUARTO_PUB_AUTH_TOKEN`

### Environment Requirements

**Local Publishing**:
- Quarto CLI (v1.7.34+)
- 1Password CLI (`op` command available)
- Authenticated 1Password session

**Verification**:
```bash
# Verify 1Password access
op vault list | grep Employee

# Verify Quarto
quarto --version

# Test token retrieval
op read "op://Employee/ycy5ki32hkoaqymrnc4w46i6tm/password" | head -c 20
```

### CDN & Cache Behavior

After publishing, Quarto Pub's CDN may cache the previous version for 30-60 seconds.

To verify updates without cache:
```bash
# With cache-busting query parameter
curl -s "https://pedodontist.quarto.pub/dental-career-opportunities/treatment_coordinator.html?t=$(date +%s)" | grep "SOFTWARE"
```

### Troubleshooting

| Issue | Resolution |
|-------|-----------|
| `ERROR: Invalid Auth token` | Token in GitHub secret expired. Update `QUARTO_PUB_AUTH_TOKEN` with current value from 1Password notes field. |
| `could not read secret 'op://...'` | 1Password item ID incorrect or vault name wrong. Verify: `op item get ycy5ki32hkoaqymrnc4w46i6tm --vault Employee` |
| Site not updating after publish | Wait 60+ seconds for CDN. Use cache-busting query parameter in URL to bypass cache. |
| Quarto Pub API 500 error | Transient Quarto Pub service issue. Retry publish. Error may display even if publication succeeds. |