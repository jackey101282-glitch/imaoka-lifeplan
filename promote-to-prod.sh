#!/usr/bin/env bash
# デモ(staging/index.html) を 本番(index.html) へ昇格する。
# staging はデモ用の加工(バナー/noindex/DEMOタイトル/親パス参照/SW無効)が入っているので、
# 昇格時にそれらを本番仕様へ戻す。アプリのロジック差分だけが本番に反映される。
set -euo pipefail
cd "$(dirname "$0")"
SRC="staging/index.html"
OUT="index.html"

[ -f "$SRC" ] || { echo "ERROR: $SRC が無い"; exit 1; }
cp "$SRC" "$OUT"

# 1. noindex を除去
perl -ni -e 'print unless /<meta name="robots" content="noindex,nofollow" \/>/' "$OUT"
# 2. タイトルを本番へ
perl -pi -e 's/\Q[DEMO] Mietta — ステージング\E/Mietta（ミエッタ）/' "$OUT"
# 3. アセット参照(../)を本番(ルート)へ
perl -pi -e 's{href="\.\./(manifest\.webmanifest|apple-touch-icon\.png|favicon-32\.png|icon-192\.png)"}{href="$1"}g' "$OUT"
perl -pi -e 's{src="\.\./icon-192\.png" alt="Mietta"}{src="icon-192.png" alt="Mietta"}' "$OUT"
# 4. ServiceWorker を本番(登録)へ戻す
perl -0pi -e 's{/\* DEMO: ServiceWorker無効\(本番に干渉しない\) \*/}{if("serviceWorker" in navigator){navigator.serviceWorker.register("sw.js").catch(()=>{});}}' "$OUT"
# 5. デモバナー行を除去
perl -ni -e 'print unless /position:fixed;top:0;left:0;right:0;z-index:9999;background:#C4521F/' "$OUT"
# 6. localStorageデータキーを本番へ
perl -pi -e 's/"imaoka_lifeplan_staging"/"imaoka_lifeplan"/g' "$OUT"
# 7. Supabase認証storageKey(staging専用)を本番(デフォルト)へ戻す
perl -pi -e 's/\{auth:\{persistSession:true,autoRefreshToken:true,storageKey:"sb-mietta-staging-auth"\}\}/{auth:{persistSession:true,autoRefreshToken:true}}/' "$OUT"

echo "✅ 昇格完了: staging/index.html → index.html"
echo "   次: 1) git diff index.html で差分確認  2) 必要なら sw.js のキャッシュ版を+1  3) commit & push"
