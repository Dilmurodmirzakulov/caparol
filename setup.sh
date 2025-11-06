#!/bin/bash
# Quick setup script for Caparol website translation system

set -e

echo "🚀 Setting up Caparol Website Translation System..."
echo ""

# Check Python version
if ! command -v python3 &> /dev/null; then
    echo "❌ Error: Python 3 is not installed"
    echo "Please install Python 3.9 or higher"
    exit 1
fi

PYTHON_VERSION=$(python3 --version | cut -d' ' -f2 | cut -d'.' -f1,2)
echo "✓ Found Python $PYTHON_VERSION"

# Create virtual environment if it doesn't exist
if [ ! -d ".venv" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv .venv
    echo "✓ Virtual environment created"
else
    echo "✓ Virtual environment already exists"
fi

# Activate virtual environment
echo "🔧 Activating virtual environment..."
source .venv/bin/activate

# Install dependencies
echo "📥 Installing dependencies..."
pip install --upgrade pip > /dev/null 2>&1
pip install -r requirements.txt
echo "✓ Dependencies installed"

# Check if .env exists
if [ ! -f ".env" ]; then
    echo "⚠️  Warning: .env file not found"
    echo "📝 Creating .env from template..."
    cp env.sample .env
    echo "✓ .env file created"
    echo ""
    echo "🔑 IMPORTANT: Edit .env file and add your Yandex Cloud credentials:"
    echo "   - YANDEX_API_KEY"
    echo "   - YANDEX_FOLDER_ID"
    echo ""
    echo "   See TRANSLATION_SETUP_GUIDE.md for instructions"
else
    echo "✓ .env file exists"
fi

# Create cache directory
mkdir -p .cache
echo "✓ Cache directory ready"

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Edit .env file with your Yandex Cloud credentials"
echo "2. (Optional) Edit translate_glossary.csv to add brand names"
echo "3. Run: python scripts/translate_ru_to_uz.py --src . --dst ./uz --clean"
echo ""
echo "For detailed instructions, see README_TRANSLATION.md"
echo ""

