#!/bin/bash

# Local deployment script for dental-career-opportunities
# This script renders and publishes the site to Quarto Pub from your local machine

set -e

echo "🔄 Building site locally..."
quarto render

echo "✅ Site rendered successfully to _site/"
echo ""
echo "📡 Publishing to Quarto Pub..."
echo "(Note: Publishing will run silently. Check Quarto Pub in ~30 seconds to verify updates)"
echo ""

# Get token from 1Password
QUARTO_PUB_AUTH_TOKEN=$(op read "op://Employee/ycy5ki32hkoaqymrnc4w46i6tm/password" 2>/dev/null) || {
    # Fallback to direct token if 1Password fails
    QUARTO_PUB_AUTH_TOKEN="qpa_4vx5aKITzOxuB3myIShyVnAyNty7JkVGV0rmpHJHTNs02kzcG0H0zqJjXRddvTCB"
}

export QUARTO_PUB_AUTH_TOKEN

# Publish without re-rendering (we already rendered above)
quarto publish quarto-pub --no-browser --no-prompt --no-render

echo ""
echo "✅ Publish command completed"
echo "🌐 Live site: https://pedodontist.quarto.pub/dental-career-opportunities/"
echo ""
echo "⏳ CDN may take 30-60 seconds to update. Refresh the site in your browser if changes don't appear immediately."
