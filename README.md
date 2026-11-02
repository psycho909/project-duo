# 摺疊機版面偵測

即時量測網頁尺寸、螢幕分區數與摺疊狀態，判斷 Galaxy Z Fold8／iPhone Duo 目前該套用哪一種版型：

- **A. 窄版單視窗**：外螢幕、內螢幕分割視窗、浮動視窗
- **B. 寬版連續畫面**：內螢幕展開，網頁佔滿整片
- **C. 跨摺痕分區（左右）**：瀏覽器回報兩個 viewport segment
- **D. 半摺上下分區**：筆電／桌上模式

## 使用

直接開啟 `index.html`，或部署到 GitHub Pages 後用手機開網址。要量到完整的螢幕與摺痕數據，請直接開啟頁面，不要嵌在其他網頁的 iframe 裡。

頁面內的「模擬其他裝置」可在桌機預覽各種狀態；裝置尺寸是估計值，拿到實機數據後修改 `index.html` 裡的 `PRESETS`。

## 檔案

- `index.html`：完整頁面
- `artifact/foldable-inspector.html`：發布到 Claude Artifact 用的版本（不含 `<html>`／`<head>` 外框）
- `docs/`：版型參考圖
