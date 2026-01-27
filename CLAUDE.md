# CLAUDE.md - AI Assistant Guidelines for Buytools

This document provides context and guidelines for AI assistants working with the Buytools codebase.

## Project Overview

**Buytools** (買工具) is a collection of standalone web-based utility tools for shopping, data processing, and productivity tasks. The project is hosted at `buy.sirii.cf` via GitHub Pages.

**Primary Language:** Traditional Chinese (zh-TW)
**Target Market:** Taiwan (Family Mart, Momo, Shopee, PTT integrations)

## Architecture

This is a **static-site collection of single-page applications**:

- **No build pipeline** - Each tool is a self-contained HTML file
- **No backend server** - All processing happens client-side in the browser
- **CDN dependencies** - External libraries loaded from CDNs (unpkg, cdnjs, jsdelivr)
- **GitHub Pages hosting** - Static file serving via CNAME configuration

## Technology Stack

### Frontend Frameworks
- **Vue.js 3** (via CDN) - Primary UI framework for modern tools
- **Vanilla JavaScript** - For simpler utilities
- **jQuery 3.6.0** - Legacy support in some tools

### UI/Styling
- **Tailwind CSS** - Modern tool styling
- **Bootstrap 5.3.x** - Form-based tools
- **Custom embedded CSS** - Tool-specific styles

### Key Libraries
| Library | Version | Purpose |
|---------|---------|---------|
| Tabulator.js | 5.5.2 | Data table manipulation (CSV Sorter) |
| Signature Pad | 4.0.0 | Digital signatures |
| LZ-String | 1.4.4 | Data compression |
| html2pdf.js | 0.10.1 | PDF generation |
| JsBarcode | - | Barcode generation (CODE39) |

## Project Structure

```
buytools/
├── *.html              # 31 standalone tool files (main application code)
├── 1.md                # Tool index with categorized links (Traditional Chinese)
├── README.md           # Brief project description
├── CNAME               # GitHub Pages domain config (buy.sirii.cf)
├── service-worker.js   # PWA offline support
├── sync_html.sh        # Interactive tool registration script
├── fixcsv.cmd          # Windows CSV BOM fix installer
├── fixcsv.md           # FixCSV installation guide
├── shopee_chkin.user.js # Tampermonkey browser script
├── barcode_files/      # Barcode tool assets (JsBarcode, images, analytics)
├── screenshots/        # Documentation images
└── .html.ignore        # Files excluded from tool index
```

## Tool Categories (from 1.md)

| Category | Chinese Name | Examples |
|----------|--------------|----------|
| Common Tools | 常用工具 | ICON cropper, URLs opener, QR codes |
| Momo Toolbox | momo toolbox | momojson, momocurl, momocron |
| Text Conversion | 文字轉換 | CSV sorter, ChatGPT cleaner, Fetch cleaner |
| Time Management | 時間管理大師 | Countdown timer, Contest timer |
| Property/Income | 房東/賺錢小幫手 | Checkout, Receipt maker, PTT post helper |

## Development Workflow

### Creating a New Tool

1. **Create HTML file** in root directory with descriptive name
2. **Use standard template structure:**
   ```html
   <!DOCTYPE html>
   <html lang="zh-TW">
   <head>
     <meta charset="UTF-8">
     <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <meta name="version" content="X.X.YYYYMMDD">
     <title>Tool Name | 中文名稱</title>
     <!-- CDN dependencies -->
   </head>
   <body>
     <!-- Tool content -->
   </body>
   </html>
   ```
3. **Register in 1.md** using the sync script or manually add to appropriate section

### Tool Registration Script

Run `./sync_html.sh` to interactively register new HTML files:
- Scans for unregistered `.html` files
- Prompts for category selection (numbered sections from 1.md)
- Options: number (add to section), `x` (skip), `xx` (add to ignore list)
- Updates `1.md` automatically

### Files to Ignore

Add filenames to `.html.ignore` (one per line) to exclude from the tool index:
- Test files
- Work-in-progress tools
- Internal utilities

## Code Conventions

### HTML Files
- **Self-contained** - All CSS/JS embedded or via CDN (no local bundling)
- **Bilingual titles** - English | Chinese format in `<title>` tag
- **Version meta tag** - Format: `X.X.YYYYMMDD` (e.g., `2.6.20260108`)
- **UTF-8 encoding** - Always specify `<meta charset="UTF-8">`
- **Responsive** - Include viewport meta tag for mobile support

### JavaScript
- **Vue.js 3 preferred** for interactive tools with state management
- **Vanilla JS** acceptable for simple utilities
- **No module bundlers** - Use CDN imports directly
- **Chinese fonts** - Use Noto Sans TC or Microsoft JhengHei

### CSS
- **Tailwind CSS** for utility-first styling in new tools
- **Bootstrap 5** for form-heavy interfaces
- **Embedded styles** - Keep CSS in `<style>` tags within HTML

## Important Commands

```bash
# Register new tools interactively
./sync_html.sh

# View tool index
cat 1.md

# Check ignored files
cat .html.ignore
```

## Git Practices

### Commit Message Style
- Simple date-based format: `MMDD` (e.g., `0119`)
- Descriptive when adding features: `Add 'Get URL parameter' tool to Buying Tools`

### Branch Structure
- Main branch for production
- Feature branches for development (e.g., `claude/...`)

## Testing

**No formal test framework** - Tools are tested manually in browser.

- Open HTML file directly in browser
- Verify functionality across different inputs
- Check responsive behavior on mobile viewports
- Test with `test.html` as a sandbox

## Deployment

Deployment is automatic via **GitHub Pages**:
1. Push changes to main branch
2. GitHub Pages serves files from root directory
3. Domain: `buy.sirii.cf` (configured in CNAME)

## Key Files Reference

| File | Purpose |
|------|---------|
| `1.md` | **Main tool index** - Update when adding tools |
| `CNAME` | Domain configuration - Do not modify |
| `service-worker.js` | PWA support - Modify for caching changes |
| `sync_html.sh` | Tool registration automation |
| `.html.ignore` | Exclusion list for sync script |

## External Integrations

The codebase integrates with several Taiwan-specific services:
- **Momo Shopping** - JSON/cURL parsing tools
- **Family Mart (FamiPocket)** - E-wallet integration
- **Shopee** - Check-in automation
- **PTT Forums** - Post templating

## AI Assistant Guidelines

When working on this codebase:

1. **Maintain single-file architecture** - Don't split tools into multiple files
2. **Use CDN dependencies** - Don't add npm packages or bundlers
3. **Preserve Chinese language** - Comments and UI text in Traditional Chinese
4. **Update 1.md** when adding new tools (or use sync_html.sh)
5. **Include version meta tag** in new HTML files
6. **Test in browser** - No automated test suite exists
7. **Keep tools focused** - Each HTML file serves one specific purpose
8. **Respect existing patterns** - Match styling/framework choices of similar tools

## Common Tasks

### Adding a new tool
1. Create `toolname.html` with standard template
2. Run `./sync_html.sh` or manually update `1.md`
3. Commit and push

### Updating an existing tool
1. Edit the HTML file directly
2. Update version meta tag: `<meta name="version" content="X.X.YYYYMMDD">`
3. Commit with descriptive message

### Excluding a file from index
1. Add filename to `.html.ignore`
2. Or enter `xx` when prompted by `sync_html.sh`
