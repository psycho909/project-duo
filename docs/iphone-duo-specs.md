# iPhone Duo 尺寸查證（2026-11-02）

iPhone Duo 於 2026-09-09 發表。Apple 只公布像素與 ppi，**沒有公布 point（CSS px）尺寸**。下表的 point 都是推算或模擬器數據。

## Apple 官方規格

| | 尺寸 | 解析度 | ppi |
|---|---|---|---|
| 外螢幕 | 5.4 吋 | 1398 × 2034 | 460 |
| 內螢幕 | 7.6 吋（摺疊） | 1878 × 2670 | 430 |

來源：[Apple iPhone Duo 技術規格](https://www.apple.com/iphone-duo/specs/)

## 換算成 point（CSS px）

| | 規範附錄 | 推算／模擬器 | 依據 | 可信度 |
|---|---|---|---|---|
| 外螢幕 | 466 × 678 | **466 × 678** | 1398 ÷ 3 = 466、2034 ÷ 3 = 678，剛好整除 | 高（與官方像素一致） |
| 內螢幕 | 626 × 890 | **669 × 951** | Xcode 27.1 beta 模擬器的 iPhone Duo 設定檔 | 中（尚未在實機確認） |

**為什麼內螢幕不是 626 × 890**

- 626 × 890 是把像素直接除以 3 得到的，但兩片螢幕的 ppi 不同。
- 外螢幕 460 ppi ÷ 3 ≈ 每吋 153 pt。內螢幕要維持相同的實體大小，縮放比必須是 430 ÷ 153 ≈ 2.807，不是 3。
- 1878 ÷ 2.807 ≈ 669、2670 ÷ 2.807 ≈ 951，和模擬器回報的 669 × 951 吻合。
- 如果真的是 626 寬，內螢幕上的字和按鈕會比外螢幕大約 7%，不符合 Apple 一貫的做法。

## 對網頁的影響

- **這些是整片螢幕的 point，不是 Safari 的可視區域。** 寬度直向時大致等於 `innerWidth`；高度還要扣掉狀態列和 Safari 工具列，實際可用高度會更小。
- **內螢幕**
  - 直向：669 寬，落在 481–768。以 720 畫板計算是 0.93 倍。附錄的 626 寬算出來是 0.87 倍。
  - 橫向：951 × 669，落在 ≥ 769，高度足夠，不算矮畫面。
- **外螢幕**
  - 直向：466 寬，落在 ≤ 480。純 vw 是 1.24 倍，建議版規範會在 1.17 倍封頂。
  - 橫向：678 × 466。扣掉 Safari 工具列後，高度應該會低於 460，算矮畫面，但要實機確認。
- **其他（第三方資料，未經證實）**
  - 內螢幕摺痕在模擬器中約 40pt 寬。
  - 內螢幕的安全區域左右不對稱。
  - 分割畫面每個 App 約 445–470 寬，落在 ≤ 480。
- **Apple 官方建議**：外螢幕是 compact width、內螢幕是 regular width。Apple 建議依視窗或場景大小排版，不要寫死裝置尺寸。這和網頁用斷點、不判斷機型的做法一致。
- **可能沿用 iPad 的桌面版 Safari**：內螢幕若和 iPad 一樣，Safari 預設送出 Mac 的 UA，用 UA 判斷 iPhone 會失效，要改用寬度判斷。這點需要實機確認。

## 實機量測要確認的

用 https://project-duo.netlify.app/ 量下列狀態，並把「完整偵測數據」貼回來：

1. 外螢幕直向、橫向的 `innerWidth × innerHeight` 與 `100svh／100lvh`。
2. 內螢幕直向、橫向（確認是 669 × 951 還是 626 × 890）。
3. 內螢幕分割畫面、Slide Over（浮動視窗）。
4. 「瀏覽器」欄位：內螢幕顯示的是 Safari iOS 還是 Mac。
5. 安全區域四邊的數值，以及網址列在上方或下方時的差異。

## 來源

官方：

- [Apple iPhone Duo 技術規格](https://www.apple.com/iphone-duo/specs/)
- [Apple Newsroom：Apple unveils iPhone Duo](https://www.apple.com/newsroom/2026/09/apple-unveils-iphone-duo/)
- [Apple Developer：Designing for iPhone Duo](https://developer.apple.com/design/human-interface-guidelines/designing-for-iphone-duo)
- [Apple Developer：Preparing your app for iPhone Duo](https://developer.apple.com/documentation/technologyoverviews/preparing-your-app-for-iphone-duo)

第三方：

- [FoldHunt：iPhone Duo screen sizes](https://foldhunt.com/guides/iphone-duo-screen-sizes/)：669 × 951、安全區域、摺痕寬
- [Marker.io：Test website on iPhone Duo](https://marker.io/blog/test-website-on-iphone-duo)：466 × 678、890 × 626（除以 3 的估算）
