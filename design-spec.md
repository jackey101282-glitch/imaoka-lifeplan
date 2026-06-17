# 今岡家ライフプラン管理アプリ — UIデザインシステム仕様書

**対象:** エンジニア実装用  
**前提:** モバイルファースト / iOS・Android共通 / 日本語UI  
**担当:** @design-ui(画面仕様) / @design-brand(カラー・トーン)

---

## 1. カラーパレット

### ブランドトーン指針
家族・温かみ・信頼感。メインは落ち着いたテラコッタ系オレンジ + ネイビーのアクセント。過度な鮮やかさを避け、長時間見ても疲れないトーンを基本とする。

### CSS変数定義

```css
:root {
  /* === Primary (テラコッタ/温かみオレンジ) === */
  --color-primary-50:  #FFF4EF;
  --color-primary-100: #FFE4D6;
  --color-primary-200: #FFCAAD;
  --color-primary-300: #FFA880;
  --color-primary-400: #FF8050;
  --color-primary-500: #E86A35;  /* メインブランドカラー */
  --color-primary-600: #C4521F;
  --color-primary-700: #9E3E10;

  /* === Secondary (ネイビー/信頼感) === */
  --color-secondary-50:  #EEF1F8;
  --color-secondary-100: #D5DCEE;
  --color-secondary-200: #A8B7DC;
  --color-secondary-300: #6E89C4;
  --color-secondary-400: #3B5FAB;
  --color-secondary-500: #1E3F8A;  /* メインネイビー */
  --color-secondary-600: #162E66;
  --color-secondary-700: #0E1E44;

  /* === Accent (セージグリーン/達成感) === */
  --color-accent-400: #5DAE8B;
  --color-accent-500: #3D9170;  /* 積立・達成に使用 */
  --color-accent-600: #2B7358;

  /* === Semantic === */
  --color-success: #3D9170;
  --color-warning: #F0A030;
  --color-danger:  #D94F4F;
  --color-info:    #3B5FAB;

  /* ===== ライトモード ===== */
  --color-bg-base:      #FAFAF8;   /* 画面背景 */
  --color-bg-surface:   #FFFFFF;   /* カード背景 */
  --color-bg-muted:     #F2F0ED;   /* 非アクティブ背景 */
  --color-border:       #E4E0DA;
  --color-border-strong:#C8C2B8;

  --color-text-primary:   #1A1714;  /* 本文 */
  --color-text-secondary: #6B6560;  /* サブテキスト */
  --color-text-disabled:  #ADA8A2;
  --color-text-on-primary:#FFFFFF;  /* primaryボタン上のテキスト */
}

/* ===== ダークモード ===== */
@media (prefers-color-scheme: dark) {
  :root {
    --color-bg-base:      #141210;
    --color-bg-surface:   #1E1C1A;
    --color-bg-muted:     #2A2724;
    --color-border:       #3A3632;
    --color-border-strong:#504C48;

    --color-text-primary:   #F0EDE8;
    --color-text-secondary: #A09890;
    --color-text-disabled:  #5C5854;
    --color-text-on-primary:#FFFFFF;

    /* Primary はダークでも同系統を維持(明度調整) */
    --color-primary-500: #F07A48;
    --color-primary-600: #E86A35;

    --color-secondary-300: #8AAAD8;
    --color-secondary-500: #4A72C4;

    --color-accent-500: #52B88E;

    --color-success: #52B88E;
    --color-warning: #F5B040;
    --color-danger:  #E86060;
    --color-info:    #4A72C4;
  }
}
```

---

## 2. タイポグラフィ

```css
/* font-family */
--font-family-base: 'Hiragino Sans', 'Hiragino Kaku Gothic ProN',
                    'BIZ UDGothic', 'Noto Sans JP', sans-serif;
--font-family-number: 'DIN Alternate', 'Tabular Lining', 'Noto Sans JP',
                      sans-serif;  /* 金額・数字用: 等幅で見やすく */

/* サイズスケール (rem / 16px base) */
--text-xs:   0.625rem;  /* 10px — 注釈・バッジ */
--text-sm:   0.75rem;   /* 12px — サブラベル */
--text-base: 0.875rem;  /* 14px — 本文 */
--text-md:   1rem;      /* 16px — ボタン・入力欄 */
--text-lg:   1.125rem;  /* 18px — セクション見出し */
--text-xl:   1.375rem;  /* 22px — カード主要数値 */
--text-2xl:  1.75rem;   /* 28px — ダッシュボード大数値 */
--text-3xl:  2.25rem;   /* 36px — ヒーロー金額 */

/* ウェイト */
--font-weight-regular: 400;
--font-weight-medium:  500;
--font-weight-bold:    700;

/* 行間 */
--leading-tight:  1.3;   /* 見出し */
--leading-normal: 1.6;   /* 本文 */
--leading-loose:  1.9;   /* 注釈 */

/* 字間 */
--tracking-tight:  -0.01em;  /* 大サイズ数値 */
--tracking-normal:  0;
--tracking-wide:    0.04em;  /* ラベル・キャプション */
```

---

## 3. スペーシング・角丸・影トークン

```css
/* === Spacing (4px基準グリッド) === */
--space-1:  4px;
--space-2:  8px;
--space-3:  12px;
--space-4:  16px;   /* 基本余白 */
--space-5:  20px;
--space-6:  24px;   /* カード内パディング */
--space-8:  32px;
--space-10: 40px;
--space-12: 48px;
--space-16: 64px;

/* 画面横余白 */
--screen-padding-x: 16px;   /* モバイル標準 */

/* === 角丸 === */
--radius-sm:   6px;   /* チップ・バッジ */
--radius-md:   12px;  /* ボタン・入力欄 */
--radius-lg:   16px;  /* カード */
--radius-xl:   24px;  /* ボトムシート・モーダル上部 */
--radius-full: 9999px;  /* ピル型ボタン・アバター */

/* === 影 === */
--shadow-xs: 0 1px 2px rgba(0,0,0,0.06);
--shadow-sm: 0 2px 8px rgba(0,0,0,0.08);          /* カード通常 */
--shadow-md: 0 4px 16px rgba(0,0,0,0.10);          /* カードホバー/フォーカス */
--shadow-lg: 0 8px 32px rgba(0,0,0,0.14);          /* モーダル */
--shadow-primary: 0 4px 12px rgba(232,106,53,0.30); /* primaryボタン押下 */
```

---

## 4. ボトムタブナビ (5タブ)

| index | ラベル | アイコン(絵文字) | ルート |
|-------|--------|-----------------|--------|
| 0 | ホーム | 🏠 | /dashboard |
| 1 | タスク | ✅ | /tasks |
| 2 | やりたい | ✨ | /wishlist |
| 3 | カレンダー | 📅 | /calendar |
| 4 | 設定 | ⚙️ | /settings |

```
仕様:
- 高さ: 56px + セーフエリア(padding-bottom: env(safe-area-inset-bottom))
- 背景: var(--color-bg-surface)
- 上辺ボーダー: 1px solid var(--color-border)
- アイコンサイズ: 24×24px
- ラベル: var(--text-xs) / var(--font-weight-medium)

アクティブ状態:
  アイコン色: var(--color-primary-500)
  ラベル色:   var(--color-primary-500)
  アイコン下: 2px solid var(--color-primary-500) のアンダーライン OR
              背景: var(--color-primary-50) の円形ハイライト(直径40px)

非アクティブ状態:
  アイコン色: var(--color-text-disabled)
  ラベル色:   var(--color-text-disabled)

バッジ(タスク未完了数など):
  背景: var(--color-danger)
  文字: #FFFFFF / var(--text-xs) / var(--font-weight-bold)
  サイズ: 最小16×16px / border-radius: var(--radius-full)
  位置: アイコン右上 -4px / -4px
```

---

## 5. コンポーネント仕様

### 5-1. カード (Card)

```
background:    var(--color-bg-surface)
border-radius: var(--radius-lg)               /* 16px */
padding:       var(--space-6)                  /* 24px */
box-shadow:    var(--shadow-sm)
border:        1px solid var(--color-border)   /* ライトモードのみ */

ホバー/タップ時:
  box-shadow:  var(--shadow-md)
  transform:   translateY(-1px)
  transition:  all 150ms ease-out

カード見出し:
  font-size:   var(--text-base)               /* 14px */
  font-weight: var(--font-weight-bold)
  color:       var(--color-text-secondary)
  text-transform: なし
  margin-bottom: var(--space-3)

カード主要数値:
  font-family: var(--font-family-number)
  font-size:   var(--text-xl) 〜 var(--text-2xl)
  font-weight: var(--font-weight-bold)
  color:       var(--color-text-primary)
```

### 5-2. ボタン

```
/* Primary ボタン */
background:    var(--color-primary-500)
color:         var(--color-text-on-primary)
border-radius: var(--radius-md)               /* 12px */
padding:       12px 24px
font-size:     var(--text-md)                 /* 16px */
font-weight:   var(--font-weight-bold)
min-height:    48px                           /* タップ領域確保 */
box-shadow:    var(--shadow-primary)
border:        none

押下時:
  background: var(--color-primary-600)
  transform:  scale(0.98)
  box-shadow: none

/* Secondary ボタン */
background:    transparent
color:         var(--color-primary-500)
border:        1.5px solid var(--color-primary-500)
(その他は Primary と同値)

/* Danger ボタン */
background:    var(--color-danger)
(その他は Primary と同値)

/* テキストボタン / リンク */
background:    transparent
color:         var(--color-secondary-500)
border:        none
padding:       8px 12px
font-weight:   var(--font-weight-medium)
underline:     none (ホバー時のみ表示)

/* ボタン全共通 */
transition:    all 120ms ease-out
cursor:        pointer
disabled 状態:
  opacity: 0.40
  pointer-events: none
```

### 5-3. 入力欄 (Input / Textarea)

```
background:    var(--color-bg-muted)
border:        1.5px solid var(--color-border)
border-radius: var(--radius-md)               /* 12px */
padding:       12px 16px
font-size:     var(--text-md)                 /* 16px */
font-family:   var(--font-family-base)
color:         var(--color-text-primary)
min-height:    48px                           /* タップ領域 */
width:         100%

フォーカス時:
  border-color: var(--color-primary-500)
  background:   var(--color-bg-surface)
  box-shadow:   0 0 0 3px rgba(232,106,53,0.15)
  outline:      none

エラー時:
  border-color: var(--color-danger)
  box-shadow:   0 0 0 3px rgba(217,79,79,0.15)

プレースホルダー:
  color: var(--color-text-disabled)

ラベル:
  font-size:   var(--text-sm)                 /* 12px */
  font-weight: var(--font-weight-medium)
  color:       var(--color-text-secondary)
  margin-bottom: var(--space-1)

エラーメッセージ:
  font-size:   var(--text-sm)
  color:       var(--color-danger)
  margin-top:  var(--space-1)

金額入力専用:
  font-family: var(--font-family-number)
  text-align:  right
  font-size:   var(--text-xl)
  font-weight: var(--font-weight-bold)
```

### 5-4. プログレスバー

```
/* トラック(背景) */
background:    var(--color-bg-muted)
border-radius: var(--radius-full)
height:        8px                            /* 標準 */
overflow:      hidden

/* フィル */
border-radius: var(--radius-full)
transition:    width 600ms cubic-bezier(0.4, 0, 0.2, 1)

/* カラーバリエーション */
積立進捗(グリーン): background: var(--color-accent-500)
支出率(オレンジ):   background: var(--color-primary-500)
危険域(レッド):     background: var(--color-danger)
  ※ 支出率が90%超えたら自動でdangerに切替

/* 太いバリアント (ダッシュボード用) */
height: 12px

/* 値ラベル */
右端に: "¥XXX,XXX / ¥XXX,XXX" または "XX%"
font-family: var(--font-family-number)
font-size:   var(--text-sm)
color:       var(--color-text-secondary)
```

### 5-5. チップ (Chip / タグ)

```
/* 基本 */
display:       inline-flex
align-items:   center
gap:           var(--space-1)
border-radius: var(--radius-sm)               /* 6px */
padding:       4px 10px
font-size:     var(--text-sm)                 /* 12px */
font-weight:   var(--font-weight-medium)
white-space:   nowrap

/* カラーバリアント */
カテゴリ(固定費):  bg: #EEF1F8 / color: var(--color-secondary-500)
カテゴリ(生活費):  bg: #FFF4EF / color: var(--color-primary-600)
達成済み:          bg: #E8F5EF / color: var(--color-accent-600)
期限切れ:          bg: #FDECEC / color: var(--color-danger)
未着手:            bg: var(--color-bg-muted) / color: var(--color-text-secondary)

担当者チップ (夫/妻):
  border-radius: var(--radius-full)
  padding:       4px 12px
  夫: bg: #EEF1F8 / color: var(--color-secondary-500)
  妻: bg: #FFF4EF / color: var(--color-primary-600)
```

---

## 6. ダッシュボード画面レイアウト

```
画面幅: 375px 基準(iPhone SE相当)。padding-x: var(--screen-padding-x) = 16px

┌─────────────────────────────────┐
│  ステータスバー                  │
├─────────────────────────────────┤
│  [ヘッダー]                      │  高さ: 56px
│  「6月の家計」          🔔(通知) │  font-size: var(--text-lg) / bold
├─────────────────────────────────┤
│  [A] 収入サマリーカード          │  margin-top: 16px
│  ┌───────────────────────────┐  │
│  │  今月の収入                 │  │  ラベル: text-sm / secondary
│  │  ¥ 450,000                  │  │  数値: text-3xl / bold / primary
│  │  夫 ¥320,000 / 妻 ¥130,000  │  │  内訳: text-sm / secondary
│  └───────────────────────────┘  │
├─────────────────────────────────┤
│  [B] 支出内訳カード              │  margin-top: 12px
│  ┌───────────────────────────┐  │
│  │  支出合計     ¥ 298,000    │  │  数値: text-2xl / bold
│  │  ────────────────────────  │  │
│  │  固定費       ¥ 180,000    │  │  行: text-base / primary
│  │  [プログレスバー 40%]       │  │  height: 8px / primary-500
│  │                             │  │
│  │  生活費       ¥ 118,000    │  │
│  │  [プログレスバー 26%]       │  │  height: 8px / primary-300
│  │                             │  │
│  │  収入比  66.2%              │  │  text-sm / 警戒域なら danger
│  └───────────────────────────┘  │
├─────────────────────────────────┤
│  [C] 積立可能額カード (強調)     │  margin-top: 12px
│  ┌───────────────────────────┐  │
│  │  背景: primary-50          │  │  ← ライトモード時
│  │  ✨ 今月の積立可能額        │  │
│  │  ¥ 152,000                  │  │  text-3xl / bold / accent-500
│  │  [プログレスバー 目標比68%] │  │  height: 12px / accent-500
│  │  目標: ¥220,000 まで¥68,000 │  │  text-sm / secondary
│  └───────────────────────────┘  │
├─────────────────────────────────┤
│  [D] 今月のタスク(ショート)      │  margin-top: 20px
│  セクション見出し: text-lg/bold  │
│  ┌───────────────────────────┐  │
│  │  ✅ 保険の見直し  📅6/30  │  │  未完了タスク最大3件
│  │     担当: [妻チップ]        │  │
│  │  ✅ 車検の予約   📅6/25  │  │
│  │     担当: [夫チップ]        │  │
│  │           → もっと見る      │  │  text-sm / secondary / right
│  └───────────────────────────┘  │
├─────────────────────────────────┤
│  [E] やりたいリスト(ショート)    │  margin-top: 20px
│  ┌───────────────────────────┐  │
│  │  ✨ 沖縄旅行    🗓 2026/9 │  │  最大2件
│  │     [プログレスバー 45%]    │  │
│  │  ✨ 新しい冷蔵庫           │  │
│  │     [プログレスバー 20%]    │  │
│  │           → もっと見る      │  │
│  └───────────────────────────┘  │
│                                   │
│  [最下部余白: 80px]               │  ← ボトムナビ分
├─────────────────────────────────┤
│  [ボトムタブナビ]                 │  height: 56px + safeArea
│  🏠ホーム  ✅タスク  ✨やりたい  │
│          📅カレンダー  ⚙️設定    │
└─────────────────────────────────┘

計算ロジック表示ルール:
  積立可能額 = 収入合計 - 固定費 - 生活費
  支出率が85%超 → 収入サマリーカードの数値を danger カラーに
  支出率が70%未満 → accent-500 (グリーン) で「余裕あり」バッジ表示
```

---

## 7. その他画面メモ

### タスク一覧 (/tasks)
```
- フィルターチップ横並び: 全件 / 今週 / 夫担当 / 妻担当
- タスクカード: チェックボックス(左) + タイトル + 担当チップ + 期限日
- チェック済みは opacity:0.5 + line-through
- FAB(追加ボタン): 右下固定 / background: primary-500 / size: 56×56px / radius: full
```

### やりたいリスト (/wishlist)
```
- カード内: タイトル / 目標金額 / 達成期限 / プログレスバー(進捗%)
- カテゴリチップ: 旅行 / 買い物 / 体験 など
- ソート: 期限近い順 / 進捗高い順
```

### カレンダー (/calendar)
```
- 月表示デフォルト
- 日付ドット: 支払い→danger / タスク期限→primary / 予定→secondary
- 日付タップ → 下部ドロワー(ボトムシート)でその日の詳細一覧
- ボトムシート: border-radius: var(--radius-xl) 24px (上辺のみ)
```

### 設定 (/settings)
```
- リストセル: padding: 16px / border-bottom: 1px solid var(--color-border)
- セクション背景: var(--color-bg-muted)
- セクションヘッダー: text-xs / tracking-wide / text-secondary / uppercase不要
- クラウド同期状態: 同期済み→accent(グリーン)アイコン / 未同期→warning
```

---

## 8. アニメーション・インタラクション

```css
/* 基本トランジション */
--transition-fast:   120ms ease-out;   /* ボタン押下 */
--transition-base:   200ms ease-out;   /* フェード・スライド */
--transition-slow:   350ms ease-out;   /* モーダル展開 */
--transition-spring: 400ms cubic-bezier(0.34, 1.56, 0.64, 1); /* 数値カウント */

/* ページ遷移 */
タブ切替:   フェード (opacity 0→1, 200ms)
詳細画面:   下からスライドイン (translateY 24px→0, 300ms)
モーダル:   下からスライドイン (ボトムシートと同様)

/* スケルトンローディング */
background: linear-gradient(90deg,
  var(--color-bg-muted) 25%,
  var(--color-border) 50%,
  var(--color-bg-muted) 75%);
background-size: 200% 100%;
animation: skeleton-shimmer 1.4s infinite;

/* 金額カウントアップ (ダッシュボード初回表示時) */
duration: 600ms / easing: var(--transition-spring)
```

---

*仕様バージョン: v1.0 / 作成日: 2026-06-17*  
*次フェーズ: エンジニアレビュー後、@design-illust にオンボーディング図解を依頼予定*
