# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

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
```bash
# Manual publish to Quarto Pub (requires QUARTO_PUB_AUTH_TOKEN)
quarto publish quarto-pub --no-browser --no-prompt

# Automated publishing via GitHub Actions
git push origin main  # Triggers .github/workflows/publish.yml
```

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
- Requires `QUARTO_PUB_AUTH_TOKEN` repository secret
- Includes caching for faster builds and comprehensive error handling

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
- IELTS Speaking Level requirements (currently Level 7.0)
- SmallTalk2Me assessment platform integration
- QuizGecko knowledge assessment links
- Specific assessment codes for each position type

### Styling Conventions
- `.scenario-card.positive` and `.scenario-card.negative` for culture examples
- Special styling for job position links under `#current-opportunities`
- Consistent callout blocks for important information

## Publishing Notes

- Site automatically rebuilds and publishes when changes are pushed to `main` branch
- Authentication handled via GitHub Actions secrets
- Build cache optimizes render times for frequently updated content
- Live site URL: https://pedodontist.quarto.pub/dental-career-opportunities/
- Publishing workflow includes comprehensive error handling and notification

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