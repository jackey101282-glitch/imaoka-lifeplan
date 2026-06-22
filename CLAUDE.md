# CLAUDE.md — Mietta（ミエッタ）

夫婦・カップル向けの生活管理アプリ（家計＋カレンダー＋タスク＋共有＋ライフプラン）。
**本体は単一ファイル `index.html`（バニラJS）＋ Supabase ＋ PWA。** 開発者は非エンジニアの社長1名。

## 🚨 最重要：本番の触り方（厳守）
- **本番 `index.html` を直接編集しない。** 必ず `staging/index.html` を編集する。
- 昇格フロー：
  1. `staging/index.html` を編集 → commit & push（デモに反映）
  2. デモ https://mietta.jp/staging/ で検証
  3. `./promote-to-prod.sh`（デモ用加工を本番仕様へ自動逆変換）
  4. `git diff index.html` で差分・staging残骸が無いことを確認
  5. **`sw.js` の `CACHE` バージョンを +1**（これを忘れるとユーザーに更新が届かない）
  6. `git add index.html sw.js && commit && push`
- 本番に出るのは全ユーザー影響＝**最終 push 前に社長へ確認**。
- ビルド確認：`gh api repos/jackey101282-glitch/imaoka-lifeplan/pages/builds/latest --jq .status` が `built`。
- **commit/push はユーザーが頼んだ時だけ。** commitメッセージ末尾に `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`。

## URL
- 本番アプリ: https://mietta.jp/ ／ デモ: https://mietta.jp/staging/ ／ LP: https://mietta.jp/lp/
- リポジトリ: https://github.com/jackey101282-glitch/imaoka-lifeplan（main push で GitHub Pages 自動公開）

## ブランド・デザイン方針
- 正式名 **Mietta（ミエッタ）**。表記 Mietta/ミエッタ どれもOK。
- **UIに絵文字を使わない。** ラインアイコンを `ic(name)` / `renderCatIc(絵文字orアイコン名)` で描画（`_ICONS`＋`EMOJI_ICON`マップ）。
- 和テイスト：テラコッタ(primary)/モスグリーン(secondary)/クリーム背景。ライト固定（ダークは廃止寄り）。

## データ
- Supabase プロジェクト `imfynopqugqiczevrmsl`。全ユーザーデータは `app_state` テーブルの `data`（世帯ごとJSON）＋ `members`。RLSで世帯分離。
- publishable key は公開可（index.html内）。secret key はクライアントに入れない・gitに上げない。
- 端末別設定は localStorage（同期しない）：テーマ/通知/金額目隠し等。

## ドキュメント（詳細はこちら）
- **`引き継ぎ.md`** … セッション横断の最新状況・判断待ち・TODO（まず §0.1 を読む）。
- `staging-workflow.md` … 昇格フローの詳細。
- `運用-リスクとバックアップ.md` … リスク一覧・Supabaseバックアップ/復旧手順。
- `提案-*.md` / `plan-*.md` / `strategy-*.md` … 企画・戦略資料（非公開・ローカル）。

## 確認・検証
- プレビュー検証は `mcp__Claude_Preview__`（`.claude/launch.json` の `lifeplan` = python http.server 4178）。
- 古いタブで反映されない時は ⌘+Shift+R（ハード再読込）。
