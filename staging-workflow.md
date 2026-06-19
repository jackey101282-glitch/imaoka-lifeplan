# デモ(ステージング)→本番 運用フロー

最終更新: 2026-06-19 / ユーザー増加に伴い「本番をいきなり触らない」ための仕組み。

## URL
- 本番（実ユーザー）: `https://mietta.jp/`（暫定 `https://jackey101282-glitch.github.io/imaoka-lifeplan/`）
- デモ（テスト用）: `https://mietta.jp/staging/`（暫定 `.../imaoka-lifeplan/staging/`）

## データについて（重要）
- 現状は**本番と同じSupabase**を使用（社長判断: まず手間ゼロで開始）。
- 世帯ごとにデータ分離されるので、**テストは"テスト専用アカウント"でログインして行う**こと。実ユーザーの世帯には影響しない。
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
- `promote-to-prod.sh` は「staging = 本番 + デモ加工」「昇格 = その逆変換」なので、**ロジック差分だけが本番へ反映**される。
- ラウンドトリップ検証済み（加工→逆変換で元の本番と完全一致）。昇格後は必ず `git diff` で確認すること。

## 注意
- 本番 `index.html` を直接編集しないこと（staging と乖離する）。ホットフィックスで直接触った場合は、その変更を `staging/index.html` にも反映して同期を保つ。
- `lp/`（LP）・アイコン・manifest・sw.js はこのフロー外（必要時に直接編集）。
