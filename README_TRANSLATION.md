# Caparol Website Translation System

This folder contains a complete translation system for translating the Caparol Bulgaria website from Russian to Uzbek (Latin script) using Yandex Cloud Translate API.

## Quick Start

### 1. Set Up Python Environment

```bash
# Create virtual environment
python3 -m venv .venv

# Activate it
source .venv/bin/activate  # On macOS/Linux
# .venv\Scripts\activate  # On Windows

# Install dependencies
pip install -r requirements.txt
```

### 2. Configure Yandex Cloud API

1. **Copy the sample environment file:**
   ```bash
   cp env.sample .env
   ```

2. **Edit `.env` and add your Yandex Cloud credentials:**
   ```bash
   YANDEX_API_KEY=your_actual_api_key_here
   YANDEX_FOLDER_ID=your_actual_folder_id_here
   ```

3. **Get your credentials from Yandex Cloud:**
   - Follow the detailed instructions in `TRANSLATION_SETUP_GUIDE.md` (Step 1)
   - You need to create a service account and get an API key
   - You also need your folder ID from Yandex Cloud Console

### 3. Customize Glossary (Optional)

Edit `translate_glossary.csv` to add brand names and terms that should NOT be translated:

```csv
source,target,mode
Caparol,Caparol,dt
DANOGIPS,DANOGIPS,dt
YourBrandName,YourBrandName,dt
```

### 4. Run Translation

**For the current website structure:**

```bash
# Basic translation (from project root)
python scripts/translate_ru_to_uz.py \
  --src "/Users/dilmurod/Desktop/projects/www.caparol.bg copy" \
  --dst "/Users/dilmurod/Desktop/projects/www.caparol.bg copy/uz" \
  --cache "/Users/dilmurod/Desktop/projects/www.caparol.bg copy/.cache/ru_uz.json" \
  --glossary "/Users/dilmurod/Desktop/projects/www.caparol.bg copy/translate_glossary.csv"
```

**With clean build (removes existing translations):**

```bash
python scripts/translate_ru_to_uz.py \
  --src "/Users/dilmurod/Desktop/projects/www.caparol.bg copy" \
  --dst "/Users/dilmurod/Desktop/projects/www.caparol.bg copy/uz" \
  --cache "/Users/dilmurod/Desktop/projects/www.caparol.bg copy/.cache/ru_uz.json" \
  --glossary "/Users/dilmurod/Desktop/projects/www.caparol.bg copy/translate_glossary.csv" \
  --clean
```

## Project Structure

```
www.caparol.bg copy/
├── scripts/
│   └── translate_ru_to_uz.py      # Main translation script
├── .cache/
│   └── ru_uz.json                  # Translation cache (auto-generated)
├── uz/                             # Translated Uzbek pages (auto-generated)
│   ├── index.html
│   └── ...
├── requirements.txt                # Python dependencies
├── .env                            # Your API credentials (create this)
├── env.sample                      # Template for .env
├── translate_glossary.csv          # Terms to preserve/not translate
├── TRANSLATION_SETUP_GUIDE.md      # Complete setup guide
└── README_TRANSLATION.md           # This file
```

## What the Script Does

1. **Translates content:** All visible text from Russian to Uzbek (Latin)
2. **Preserves structure:** Keeps all HTML structure, CSS, JavaScript intact
3. **Translates attributes:** title, alt, aria-label, placeholder
4. **Translates meta tags:** description, og:description
5. **Adds language switchers:** Floating buttons on both Russian and Uzbek pages
6. **Adds hreflang tags:** For SEO purposes
7. **Caches translations:** Speeds up subsequent runs
8. **Copies assets:** All images, PDFs, CSS, JS files are copied to the uz/ folder

## Language Switcher

After translation, all pages will have a language switcher button in the bottom-right corner:
- Russian pages: "O'zbekcha" button → links to Uzbek version
- Uzbek pages: "Русский" button → links back to Russian version

## Translation Cache

The system caches all translations in `.cache/ru_uz.json`:
- First run: Translates everything (may take time for large sites)
- Subsequent runs: Only translates new/changed content
- To force re-translation: Delete the cache file or use `--clean`

## Important Notes

### Current Website Language
⚠️ **Important:** This website appears to be in **Bulgarian** (lang="bg"), not Russian!

If you want to translate from Bulgarian to another language, you'll need to modify the script:

1. Open `scripts/translate_ru_to_uz.py`
2. Find line ~87: `'sourceLanguageCode': 'ru',`
3. Change to: `'sourceLanguageCode': 'bg',`
4. Find line ~90: `'targetLanguageCode': 'uz',`
5. Change to your target language code (e.g., 'en' for English, 'ru' for Russian)

### Supported Language Codes
- `bg` - Bulgarian
- `ru` - Russian
- `uz` - Uzbek (Latin)
- `en` - English
- `kk` - Kazakh
- `tr` - Turkish
- And many more (see Yandex Translate documentation)

## Cost Estimate

Yandex Cloud Translate pricing (as of 2025):
- ~$15 per 1 million characters
- This website has ~3,000 HTML files
- Estimated cost: Check Yandex pricing page for current rates

## Troubleshooting

### Error: "YANDEX_API_KEY and YANDEX_FOLDER_ID are required"
- Make sure you created `.env` file (copy from `env.sample`)
- Add your actual credentials from Yandex Cloud

### Error: "401 Unauthorized"
- Check that your API key is correct
- Verify service account has `ai.translate.user` role
- Ensure folder ID matches your Yandex Cloud folder

### Error: "ModuleNotFoundError"
- Make sure virtual environment is activated
- Run: `pip install -r requirements.txt`

### Translation Quality Issues
- Add brand names to `translate_glossary.csv`
- Use `dt` mode for terms that should not be translated

## For More Information

See `TRANSLATION_SETUP_GUIDE.md` for:
- Complete Yandex Cloud setup instructions
- Detailed explanation of all features
- Customization options
- Advanced troubleshooting

## Next Steps

1. ✅ Set up Python environment
2. ✅ Get Yandex Cloud API credentials
3. ✅ Create `.env` file with credentials
4. ✅ Customize glossary if needed
5. ✅ Run translation script
6. ✅ Test language switcher in browser
7. ✅ Deploy to production

Good luck with your translation! 🚀

