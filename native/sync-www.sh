#!/bin/bash
# ============================================================
# Mietta ネイティブ用: 本番Web素材を native/www へ同期する
# 使い方: native/ で  ./sync-www.sh
#   1. 本番の index.html / manifest / アイコンを www/ にコピー
#   2. ネイティブ版ではServiceWorkerを無効化(古いキャッシュ表示を防ぐ)
#   3. iOSプロジェクトに反映(cap copy)
# ※ index.html を更新したら、これを実行 → Xcodeで再ビルド
# ============================================================
set -e
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "→ 本番素材を native/www/ へコピー..."
cp index.html manifest.webmanifest sw.js \
   apple-touch-icon.png favicon-32.png icon-192.png icon-512.png \
   native/www/

echo "→ 画像アセット(assets/)を native/www/ へ同期..."
rm -rf native/www/assets
cp -R assets native/www/

echo "→ ネイティブ版のServiceWorker登録を無効化..."
/usr/bin/sed -i '' \
  's#if("serviceWorker" in navigator){navigator.serviceWorker.register("sw.js").catch(()=>{});}#/* ServiceWorker disabled in native build */#' \
  native/www/index.html

echo "→ Capacitorに反映..."
cd native
if [ -d ios ]; then
  export PATH="/opt/homebrew/bin:$PATH"; export LANG=en_US.UTF-8
  npx cap copy ios
else
  echo "  (iOSプラットフォーム未追加。Xcode導入後に 'npx cap add ios' を実行)"
fi
echo "✓ 同期完了"
