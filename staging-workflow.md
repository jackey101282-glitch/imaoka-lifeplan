# デモ(ステージング)→本番 運用フロー

最終更新: 2026-06-19 / ユーザー増加に伴い「本番をいきなり触らない」ための仕組み。

## URL
- 本番（実ユーザー）: `https://mietta.jp/`（暫定 `https://jackey101282-glitch.github.io/imaoka-lifeplan/`）
- デモ（テスト用）: `https://mietta.jp/staging/`（暫定 `.../imaoka-lifeplan/staging/`）

## データについて（重要）
- 現状は**本番と同じSupabase**を使用（社長判断: まず手間ゼロで開始）。
- ただしデモは**ログインセッションとローカルデータを本番と分離**している（同一オリジン問題の対策）:
  - Supabase認証 `storageKey="sb-mietta-staging-auth"`（本番セッションと別。デモは独立ログイン）
  - アプリデータ `localStorage["imaoka_lifeplan_staging"]`（本番キャッシュと別）
  - → デモを開くと**ログアウト状態**。テスト専用アカウントでログインして使う。本番アカウント/データには触れない。
- 世帯ごとにデータ分離されるので、テストアカウントは実ユーザーの世帯に影響しない。
- ⚠️ データ構造を変える改修をする時は、別Supabaseプロジェクトでの完全隔離に切替を検討（手順は別途）。

## デモの作り（本番との差分）
`staging/index.html` は本番 `index.html` のコピー＋デモ用加工のみ：
- 上部に「🧪 デモ環境」バナー / タイトル `[DEMO]` / `noindex`
- アセットは親フォルダ参照（`../icon-192.png` 等。重複を持たない）
- ServiceWorker 無効（キャッシュ事故防止・本番SWに干渉しない）
- **アプリのロジックは本番と同一**。

## 開発→検証→本番 の流れ
1. 新機能・修正は **`staging/index.html` を編集**（本番 index.html は直接触らない）。
2. commit & push → デモ `.../staging/` に反映。
3. スマホ/PCで**デモを検証**（テスト用アカウントで）。
4. OKなら**昇格**:
   ```bash
   ./promote-to-prod.sh        # staging/index.html → index.html（デモ加工を本番仕様へ自動変換）
   git diff index.html         # 差分確認
   # 必要なら sw.js のキャッシュ版を +1（ユーザーに更新を届ける）
   git add index.html sw.js && git commit -m "本番反映: ..." && git push
   ```
5. NGならデモのまま修正して2へ。

## 安全保証
- `promote-to-prod.sh` は「staging = 本番 + デモ加工(バナー/noindex/title/親パス/SW無効/staging用ストレージキー)」「昇格 = その逆変換」なので、**アプリのロジック差分だけが本番へ反映**される。
- 昇格後は必ず `git diff index.html` で確認。本番に staging 残骸(imaoka_lifeplan_staging / sb-mietta-staging-auth / デモバナー / noindex / ../アセット)が無いこと、SW登録が戻っていることをチェック。

## 注意
- 本番 `index.html` を直接編集しないこと（staging と乖離する）。ホットフィックスで直接触った場合は、その変更を `staging/index.html` にも反映して同期を保つ。
- `lp/`（LP）・アイコン・manifest・sw.js はこのフロー外（必要時に直接編集）。
