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

# Token for Dental Career Opportunities project (pedodontist_02 account)
QUARTO_PUB_AUTH_TOKEN="qpa_WYyxNjGKNDR4OZPHVYCOmvdjv4bVFbeSdLkVl46oQpKFacGnoqgC5WKPAoOU8LzR"

export QUARTO_PUB_AUTH_TOKEN

# Publish without re-rendering (we already rendered above)
quarto publish quarto-pub --no-browser --no-prompt --no-render

echo ""
echo "✅ Publish command completed"
echo "🌐 Live site: https://pedodontist.quarto.pub/dental-career-opportunities/"
echo ""
echo "⏳ CDN may take 30-60 seconds to update. Refresh the site in your browser if changes don't appear immediately."
