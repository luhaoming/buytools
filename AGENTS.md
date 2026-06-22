# AGENTS.md

Buytools（買工具）的 AI 編碼代理指引。完整專案脈絡另見 [CLAUDE.md](CLAUDE.md)。

## Project overview

**Buytools** 是一組獨立的網頁實用工具，涵蓋購物、資料處理與生產力任務，部署於 GitHub Pages（`buy.sirii.cf`）。

- **主要語言：** 繁體中文（zh-TW）
- **目標市場：** 台灣（全家、Momo、蝦皮、PTT 等整合）
- **架構：** 靜態單頁應用集合，每個工具為根目錄下一個自包含 HTML 檔案

## Dev environment tips

- **無建置流程** — 不要新增 npm 套件、模組打包器或拆分為多檔案架構
- **無後端伺服器** — 所有處理在瀏覽器端完成
- **CDN 依賴** — 外部函式庫從 CDN 載入（unpkg、cdnjs、jsdelivr）
- **互動工具** — 優先使用 Vue.js 3（CDN）；簡單工具可用 Vanilla JS；舊版工具可能使用 jQuery 3.6.0
- **樣式** — 新工具用 Tailwind CSS；表單介面用 Bootstrap 5.3.x
- **中文字型** — Noto Sans TC 或 Microsoft JhengHei
- **新增工具後** — 執行 `./sync_html.sh` 或手動更新 `1.md` 註冊至工具索引
- **排除索引** — 將檔名加入 `.html.ignore`，或在 `sync_html.sh` 提示時輸入 `xx`

## Code style guidelines

### HTML

- 自包含：CSS/JS 內嵌或透過 CDN
- `<title>` 格式：`Tool Name | 中文名稱`
- 版本 meta 標籤：`X.X.YYYYMMDD`（例：`2.6.20260108`）
- 必須有 `<meta charset="UTF-8">` 與 viewport meta 標籤
- `lang="zh-TW"`

### 新工具範本

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

### 一般原則

- 註解與 UI 文字使用繁體中文
- 每個 HTML 檔案只服務一個用途
- 樣式與框架選擇應與類似工具一致
- 修改既有工具時更新版本 meta 標籤

## Testing instructions

**無正式測試框架** — 變更後以瀏覽器手動驗證：

```bash
# 直接在瀏覽器開啟目標 HTML 檔案，例如：
# csvsorter.html
```

- 驗證不同輸入下的功能
- 檢查行動裝置 viewport 的響應式行為
- 可用 `test.html` 作為沙盒

## Git & PR instructions

- **提交訊息：** 簡短日期格式 `MMDD`（例：`0119`）；新增功能時可寫：`Add 'Get URL parameter' tool to Buying Tools`
- **分支：** `main` 為正式環境；功能開發用 feature branch（例：`claude/...`）
- **僅在使用者明確要求時才建立 commit 或 push**
- 新增工具：建立 HTML → 更新 `1.md` → 提交

## Deployment

透過 GitHub Pages 自動部署：

1. 推送至 `main` 分支
2. GitHub Pages 從根目錄提供靜態檔案
3. 網域：`buy.sirii.cf`（`CNAME` 設定，勿修改）

## Security considerations

- 所有資料處理在客戶端進行，勿引入需要後端或 API 金鑰的架構
- 勿修改 `CNAME`
- 修改台灣在地整合工具（Momo、全家、蝦皮、PTT）時，留意既有行為與使用者資料流向

## Key files

| 檔案 | 用途 |
|------|------|
| `1.md` | 工具索引 — 新增工具時須更新 |
| `sync_html.sh` | 互動式工具註冊腳本 |
| `.html.ignore` | 排除於工具索引外的檔案清單 |
| `service-worker.js` | PWA 離線支援 |
| `CLAUDE.md` | 完整專案文件（架構、函式庫、分類等） |
