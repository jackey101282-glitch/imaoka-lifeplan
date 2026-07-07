const fs = require("fs");
const src = fs.readFileSync("/Users/yuseiimaoka/今岡家ライフプラン管理/staging/index.html", "utf8");
const ILL = eval("({" + src.match(/const _ILLUS=\{([\s\S]*?)\n\};/)[1] + "})");
const FONT = "'Hiragino Maru Gothic ProN','Hiragino Maru Gothic Pro','Rounded Mplus 1c',-apple-system,sans-serif";
function sticker(key, cx, cy, size) {
  const s = size / 48, tx = cx - size / 2, ty = cy - size / 2;
  return '<g transform="translate(' + tx.toFixed(1) + ',' + ty.toFixed(1) + ') scale(' + s.toFixed(4) + ')">' + (ILL[key] || "") + '</g>';
}
// grid of decoration illustrations (no bars). skip bottom-right (magnifier zone)
const cols = [330, 512, 694];
const rowY = [356, 494, 632, 770];
const keys = ["cart", "cafe", "cake", "plane", "ferris", "scissors", "baby", "gift", "paw", "car"];
const cells = [];
for (const y of rowY) for (const x of cols) cells.push([x, y]);
// magnifier occupies (512,770) and (694,770): drop those two cells
const skip = new Set(["512,770", "694,770"]);
let ki = 0, grid = "";
for (const [x, y] of cells) {
  if (skip.has(x + "," + y)) continue;
  grid += sticker(keys[ki % keys.length], x, y, 108);
  ki++;
}
const svg =
'<svg viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg">' +
'<rect x="0" y="0" width="1024" height="1024" fill="#A7C39B"/>' +
'<rect x="232" y="188" width="560" height="752" rx="44" fill="#FBF6EC" stroke="#5A4A42" stroke-width="14"/>' +
grid +
// magnifier bottom-right
'<circle cx="640" cy="792" r="104" fill="#F6EFE1" fill-opacity="0.4"/>' +
'<text x="640" y="842" font-family="' + FONT + '" font-weight="800" text-anchor="middle" font-size="132" fill="#E0B15E" stroke="#5A4A42" stroke-width="5">¥</text>' +
'<circle cx="640" cy="792" r="104" fill="none" stroke="#5A4A42" stroke-width="17"/>' +
'<line x1="716" y1="868" x2="800" y2="952" stroke="#5A4A42" stroke-width="46" stroke-linecap="round"/>' +
'<line x1="716" y1="868" x2="800" y2="952" stroke="#D98A6A" stroke-width="30" stroke-linecap="round"/>' +
// ribbon
'<rect x="224" y="118" width="576" height="168" rx="30" fill="#5E7D5A" stroke="#42583F" stroke-width="10"/>' +
'<text x="512" y="182" font-family="' + FONT + '" font-weight="600" text-anchor="middle" font-size="50" fill="#FBF6EC" letter-spacing="6">ミエッタ</text>' +
'<text x="512" y="266" font-family="' + FONT + '" font-weight="800" text-anchor="middle" font-size="92" fill="#FBF6EC">Mietta</text>' +
'</svg>';
fs.writeFileSync("appicon-final.svg", svg);
let p = svg.replace(/<svg /, '<svg preserveAspectRatio="xMidYMid meet" ');
const html = '<meta charset=utf-8><style>body{margin:0;background:#2b2b2b;display:flex;gap:34px;align-items:flex-end;padding:40px}.t{overflow:hidden;background:#e9e2d6}.t svg{width:100%;height:100%;display:block}.a{width:230px;height:230px;border-radius:51px}.c{width:60px;height:60px;border-radius:14px}.d{width:120px;height:120px}figure{margin:0;text-align:center;color:#bbb;font-size:11px;font-family:sans-serif}figcaption{margin-top:8px}</style><figure><div class="t a">' + p + '</div><figcaption>大</figcaption></figure><figure><div class="t c">' + p + '</div><figcaption>60px 実寸</figcaption></figure><figure><div class="t d">' + p + '</div><figcaption>マスク前</figcaption></figure>';
fs.writeFileSync("/Users/yuseiimaoka/今岡家ライフプラン管理/_iconone-tmp.html", html);
console.log("ok, illustrations placed:", ki);
