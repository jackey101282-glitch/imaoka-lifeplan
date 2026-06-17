# 今岡家ライフプラン管理アプリ — データモデル&初期データ仕様

作成日: 2026-06-17
担当: 企画事業部 (@planner-product / @planner-content / @planner-pricing 協働)

---

## 1. 家計カテゴリ設計

### 1-1. 固定費カテゴリ

実装キー: `expense_type: "fixed"`

```json
[
  { "id": "fixed_rent",        "label": "住居費",       "icon": "🏠", "sub": ["家賃", "住宅ローン", "管理費", "修繕積立金"] },
  { "id": "fixed_electric",    "label": "電気代",        "icon": "💡", "sub": [] },
  { "id": "fixed_gas",         "label": "ガス代",        "icon": "🔥", "sub": [] },
  { "id": "fixed_water",       "label": "水道代",        "icon": "💧", "sub": [] },
  { "id": "fixed_net",         "label": "インターネット", "icon": "📡", "sub": ["光回線", "Wi-Fiルーターレンタル"] },
  { "id": "fixed_mobile",      "label": "スマホ代",      "icon": "📱", "sub": ["夫", "妻"] },
  { "id": "fixed_nhk",         "label": "NHK受信料",     "icon": "📺", "sub": [] },
  { "id": "fixed_life_ins",    "label": "生命保険",      "icon": "🛡️", "sub": ["夫", "妻", "子供"] },
  { "id": "fixed_med_ins",     "label": "医療保険",      "icon": "🏥", "sub": ["夫", "妻"] },
  { "id": "fixed_cancer_ins",  "label": "がん保険",      "icon": "🔬", "sub": [] },
  { "id": "fixed_car_ins",     "label": "自動車保険",    "icon": "🚗", "sub": [] },
  { "id": "fixed_fire_ins",    "label": "火災・地震保険", "icon": "🏚️", "sub": [] },
  { "id": "fixed_car_loan",    "label": "カーローン",    "icon": "🚙", "sub": [] },
  { "id": "fixed_car_tax",     "label": "車関連(固定)",  "icon": "🅿️", "sub": ["自動車税", "車検積立", "駐車場代"] },
  { "id": "fixed_edu",         "label": "習い事・塾(固定)", "icon": "📚", "sub": ["長男", "長女"] },
  { "id": "fixed_childcare",   "label": "保育園・幼稚園", "icon": "🏫", "sub": [] },
  { "id": "fixed_sub_netflix", "label": "Netflix",      "icon": "🎬", "sub": [] },
  { "id": "fixed_sub_amazon",  "label": "Amazon Prime", "icon": "📦", "sub": [] },
  { "id": "fixed_sub_spotify", "label": "Spotify",      "icon": "🎵", "sub": [] },
  { "id": "fixed_sub_other",   "label": "その他サブスク", "icon": "🔄", "sub": [] },
  { "id": "fixed_loan_other",  "label": "その他ローン",  "icon": "💳", "sub": [] }
]
```

### 1-2. 生活費(変動費)カテゴリ

実装キー: `expense_type: "variable"`

```json
[
  { "id": "var_grocery",      "label": "食費(スーパー)", "icon": "🛒", "sub": [] },
  { "id": "var_dining",       "label": "外食・テイクアウト", "icon": "🍜", "sub": [] },
  { "id": "var_daily",        "label": "日用品",         "icon": "🧴", "sub": ["ドラッグストア", "ホームセンター"] },
  { "id": "var_clothes",      "label": "衣類・クリーニング", "icon": "👗", "sub": [] },
  { "id": "var_medical",      "label": "医療費",         "icon": "💊", "sub": ["通院", "薬", "歯科"] },
  { "id": "var_child",        "label": "子供費",         "icon": "👶", "sub": ["おもちゃ", "絵本", "衣類", "学用品"] },
  { "id": "var_beauty",       "label": "美容・理容",     "icon": "💇", "sub": ["美容院", "化粧品", "散髪"] },
  { "id": "var_transport",    "label": "交通費",         "icon": "🚃", "sub": ["電車", "バス", "タクシー", "高速代", "ガソリン"] },
  { "id": "var_social",       "label": "交際費",         "icon": "🎁", "sub": ["冠婚葬祭", "プレゼント", "飲み会"] },
  { "id": "var_hobby",        "label": "趣味・娯楽",     "icon": "🎮", "sub": [] },
  { "id": "var_books",        "label": "書籍・学習",     "icon": "📖", "sub": [] },
  { "id": "var_travel",       "label": "旅行・レジャー", "icon": "✈️", "sub": [] },
  { "id": "var_home",         "label": "住居メンテ",     "icon": "🔧", "sub": ["修繕", "家電買替", "インテリア"] },
  { "id": "var_pet",          "label": "ペット費",       "icon": "🐾", "sub": [] },
  { "id": "var_misc",         "label": "雑費・使途不明", "icon": "❓", "sub": [] }
]
```

### 1-3. 収入種別

実装キー: `income_type`

```json
[
  { "id": "income_salary_h",   "label": "給与(夫)",       "icon": "💼", "timing": "monthly" },
  { "id": "income_salary_w",   "label": "給与(妻)",       "icon": "👜", "timing": "monthly" },
  { "id": "income_bonus_h",    "label": "賞与(夫)",       "icon": "💰", "timing": "seasonal" },
  { "id": "income_bonus_w",    "label": "賞与(妻)",       "icon": "💵", "timing": "seasonal" },
  { "id": "income_side",       "label": "副業・フリーランス", "icon": "💻", "timing": "monthly" },
  { "id": "income_child_allow","label": "児童手当",       "icon": "👧", "timing": "quarterly", "note": "3歳未満1.5万/月、3歳以上1万/月" },
  { "id": "income_invest",     "label": "配当・運用益",   "icon": "📈", "timing": "irregular" },
  { "id": "income_rent",       "label": "不動産収入",     "icon": "🏘️", "timing": "monthly" },
  { "id": "income_gift",       "label": "親族からの支援", "icon": "🎀", "timing": "irregular" },
  { "id": "income_other",      "label": "その他収入",     "icon": "💫", "timing": "irregular" }
]
```

---

## 2. 積立・貯蓄の目標タイプ

```json
[
  {
    "id": "goal_edu",
    "label": "教育資金",
    "icon": "🎓",
    "description": "大学卒業までの教育費総額",
    "benchmark_amount": 10000000,
    "benchmark_note": "私立大学文系4年+塾・習い事含め1人あたり約1,000〜1,500万円が目安。学資保険・ジュニアNISA・児童手当の積立が一般的。",
    "typical_monthly": 20000,
    "priority": "high"
  },
  {
    "id": "goal_housing",
    "label": "住宅購入・リフォーム",
    "icon": "🏡",
    "description": "頭金・諸費用・大規模修繕の準備",
    "benchmark_amount": 5000000,
    "benchmark_note": "物件価格の10〜20%が頭金目安。諸費用は物件価格の3〜7%程度。",
    "typical_monthly": 30000,
    "priority": "high"
  },
  {
    "id": "goal_retirement",
    "label": "老後資金",
    "icon": "🧓",
    "description": "公的年金を補う老後生活費",
    "benchmark_amount": 20000000,
    "benchmark_note": "老後2,000万円問題が基準。iDeCo・NISA・つみたて投資の活用が効果的。",
    "typical_monthly": 30000,
    "priority": "high"
  },
  {
    "id": "goal_emergency",
    "label": "緊急予備資金",
    "icon": "🆘",
    "description": "急な出費・失業に備えるキャッシュ",
    "benchmark_amount": 1800000,
    "benchmark_note": "月の生活費の3〜6ヶ月分が目安。すぐ引き出せる普通預金・MRFで保有。",
    "typical_monthly": 20000,
    "priority": "highest"
  },
  {
    "id": "goal_travel",
    "label": "旅行・家族レジャー",
    "icon": "🏖️",
    "description": "年1〜2回の家族旅行",
    "benchmark_amount": 500000,
    "benchmark_note": "国内旅行は家族4人で15〜30万円/回、海外は50〜100万円/回が目安。",
    "typical_monthly": 10000,
    "priority": "medium"
  },
  {
    "id": "goal_car",
    "label": "車の買替",
    "icon": "🚘",
    "description": "次回の乗り換えに向けた積立",
    "benchmark_amount": 3000000,
    "benchmark_note": "国産コンパクト〜ミニバン200〜400万円。車検・保険含め10年で総額500〜600万円。",
    "typical_monthly": 15000,
    "priority": "medium"
  },
  {
    "id": "goal_home_appliance",
    "label": "家電・家具買替",
    "icon": "🛋️",
    "description": "冷蔵庫・洗濯機・エアコン等の計画的買替",
    "benchmark_amount": 500000,
    "benchmark_note": "主要家電は10年サイクルで総額50〜100万円。年5万円の積立が目安。",
    "typical_monthly": 5000,
    "priority": "low"
  },
  {
    "id": "goal_wish",
    "label": "夢・欲しいもの",
    "icon": "✨",
    "description": "「やりたいことリスト」の実現資金",
    "benchmark_amount": null,
    "benchmark_note": "目標ごとに個別設定。",
    "typical_monthly": null,
    "priority": "low"
  }
]
```

---

## 3. 「やりたいこと/行きたい場所/欲しい物」リスト

### 3-1. 分類タイプ

```json
[
  { "id": "wish_travel",    "label": "行きたい場所",  "icon": "🗺️" },
  { "id": "wish_experience","label": "やりたいこと",  "icon": "🌟" },
  { "id": "wish_item",      "label": "欲しい物",      "icon": "🛍️" },
  { "id": "wish_family",    "label": "家族の夢",      "icon": "👨‍👩‍👧‍👦" },
  { "id": "wish_self",      "label": "自己投資",      "icon": "📚" }
]
```

### 3-2. 入力項目スキーマ

```json
{
  "id": "uuid",
  "title": "string",                          // 例: "沖縄に家族旅行"
  "category_id": "wish_travel",               // 上記分類
  "target_amount": 250000,                    // 目標金額(円)。null=未定
  "target_date": "2027-03",                   // 希望時期 YYYY-MM。null=いつか
  "priority": "high | medium | low",          // 優先度
  "assignee": "husband | wife | family | any",// 誰のやりたいこと
  "status": "dream | planning | saving | done",
  "memo": "string",                           // 自由メモ
  "linked_goal_id": "goal_travel",            // 紐づく積立ゴール(任意)
  "created_at": "ISO8601",
  "updated_at": "ISO8601"
}
```

### 3-3. 初期サンプルデータ(今岡家向け)

```json
[
  { "title": "沖縄に家族旅行",          "category_id": "wish_travel",    "target_amount": 300000, "target_date": "2027-08", "priority": "high",   "assignee": "family" },
  { "title": "ディズニーリゾート",       "category_id": "wish_travel",    "target_amount": 80000,  "target_date": "2026-12", "priority": "high",   "assignee": "family" },
  { "title": "ヨーロッパ夫婦旅行",       "category_id": "wish_travel",    "target_amount": 600000, "target_date": null,      "priority": "low",    "assignee": "family" },
  { "title": "子供と登山・キャンプデビュー","category_id": "wish_experience","target_amount": 80000,  "target_date": "2026-09", "priority": "medium", "assignee": "family" },
  { "title": "マイホーム購入",           "category_id": "wish_family",    "target_amount": null,   "target_date": "2029-03", "priority": "high",   "assignee": "family" },
  { "title": "新しい冷蔵庫",            "category_id": "wish_item",      "target_amount": 150000, "target_date": "2027-01", "priority": "medium", "assignee": "family" },
  { "title": "英語学習(オンライン)",      "category_id": "wish_self",      "target_amount": 50000,  "target_date": "2026-07", "priority": "medium", "assignee": "husband" }
]
```

---

## 4. 共有タスク

### 4-1. タスクスキーマ

```json
{
  "id": "uuid",
  "title": "string",
  "category": "insurance | child | admin | finance | home | event | other",
  "assignee": "husband | wife | both",
  "due_date": "YYYY-MM-DD | null",
  "status": "todo | in_progress | done | deferred",
  "priority": "high | medium | low",
  "recurrence": "none | monthly | yearly | custom",
  "memo": "string",
  "created_at": "ISO8601"
}
```

### 4-2. 典型タスク初期データ

#### 保険・お金まわり
```json
[
  { "title": "生命保険の保障額を見直す",         "category": "insurance", "assignee": "both",    "due_date": "2026-09-30", "priority": "high",   "recurrence": "yearly",  "memo": "加入から3年経過。子供の成長に合わせ保障額を更新。" },
  { "title": "火災・地震保険の更新確認",         "category": "insurance", "assignee": "husband", "due_date": "2027-01-31", "priority": "medium", "recurrence": "yearly",  "memo": "次回更新月を確認し、補償内容を比較検討。" },
  { "title": "NISAの年間投資枠を使い切る計画",   "category": "finance",   "assignee": "both",    "due_date": "2026-12-01", "priority": "high",   "recurrence": "yearly",  "memo": "つみたてNISA枠120万/年。月10万設定を確認。" },
  { "title": "iDeCoの掛金額を見直す",           "category": "finance",   "assignee": "husband", "due_date": "2026-08-31", "priority": "medium", "recurrence": "yearly",  "memo": "上限2.3万/月。節税効果を再確認。" },
  { "title": "ふるさと納税の上限額を計算する",   "category": "finance",   "assignee": "wife",    "due_date": "2026-10-31", "priority": "medium", "recurrence": "yearly",  "memo": "年収変動があれば上限シミュレーションを更新。" },
  { "title": "家計の年間収支レビュー",           "category": "finance",   "assignee": "both",    "due_date": "2026-12-31", "priority": "high",   "recurrence": "yearly",  "memo": "翌年の貯蓄目標と積立額を二人で決定。" }
]
```

#### 子供関連
```json
[
  { "title": "保育園・学校の年間行事カレンダー入力", "category": "child", "assignee": "wife",    "due_date": "2026-07-10", "priority": "high",   "recurrence": "yearly",  "memo": "4月配布のプリントをアプリに転記。" },
  { "title": "子供の習い事を比較・検討する",         "category": "child", "assignee": "both",    "due_date": "2026-08-31", "priority": "medium", "recurrence": "none",    "memo": "スイミング・英語・体操の月謝と送迎負荷を整理。" },
  { "title": "学資保険/ジュニアNISAの運用状況確認",  "category": "child", "assignee": "husband", "due_date": "2026-09-30", "priority": "high",   "recurrence": "yearly",  "memo": "目標の教育資金に対する到達率を確認。" },
  { "title": "予防接種スケジュール確認",             "category": "child", "assignee": "wife",    "due_date": "2026-07-31", "priority": "high",   "recurrence": "yearly",  "memo": "かかりつけ医に次回接種時期を確認。" }
]
```

#### 行政・手続き
```json
[
  { "title": "確定申告(医療費控除)",          "category": "admin", "assignee": "husband", "due_date": "2027-03-15", "priority": "high",   "recurrence": "yearly",  "memo": "10万円超の医療費を集計。領収書を保管する。" },
  { "title": "マイナンバーカードの有効期限確認", "category": "admin", "assignee": "both",    "due_date": "2026-09-30", "priority": "medium", "recurrence": "none",    "memo": "5年/10年更新。期限切れに注意。" },
  { "title": "パスポートの有効期限確認",        "category": "admin", "assignee": "both",    "due_date": "2026-08-31", "priority": "medium", "recurrence": "none",    "memo": "海外旅行前に残存6ヶ月以上あるか確認。" },
  { "title": "緊急連絡先・遺言メモの更新",      "category": "admin", "assignee": "both",    "due_date": "2026-12-31", "priority": "low",    "recurrence": "yearly",  "memo": "銀行口座・保険証券・ネットサービスの情報をまとめておく。" }
]
```

#### 住居・車
```json
[
  { "title": "エアコンフィルター清掃",    "category": "home",  "assignee": "husband", "due_date": "2026-07-01", "priority": "medium", "recurrence": "yearly",  "memo": "梅雨明け前に実施。" },
  { "title": "給湯器の点検・交換計画",   "category": "home",  "assignee": "husband", "due_date": "2026-10-31", "priority": "medium", "recurrence": "none",    "memo": "設置10年経過。交換費用15〜25万円を積立。" },
  { "title": "車検の準備",              "category": "home",  "assignee": "husband", "due_date": "2027-02-28", "priority": "high",   "recurrence": "yearly",  "memo": "費用目安8〜15万円。相見積もりを検討。" },
  { "title": "火災報知機の電池交換",    "category": "home",  "assignee": "husband", "due_date": "2026-11-30", "priority": "low",    "recurrence": "yearly",  "memo": "電池寿命は約10年。設置年月を記録。" }
]
```

---

## 5. 月次ダッシュボード 主要指標

### 5-1. 指標一覧と計算式

```
【指標1】当月手取り収入合計
  = Σ income (当月, 全収入種別)
  表示: 円、前月比±%

【指標2】当月支出合計
  = Σ fixed_expenses + Σ variable_expenses (当月)
  表示: 円、前月比±%、予算に対する達成率バー

【指標3】当月収支(黒字 or 赤字)
  = 手取り収入合計 − 支出合計
  表示: 円、黒字=青、赤字=赤でハイライト

【指標4】貯蓄率
  = (手取り収入合計 − 支出合計) / 手取り収入合計 × 100
  目標: 20%以上(日本の共働き子育て世帯の黄金目標)
  表示: %、ゲージグラフ (赤<10% / 黄10〜20% / 緑20%以上)

【指標5】固定費率
  = 固定費合計 / 手取り収入合計 × 100
  目標: 50%以下
  表示: %

【指標6】積立実行額(当月)
  = Σ 各ゴールへの積立入金額 (当月)
  表示: 円、目標積立額に対する達成率

【指標7】ゴール別進捗(上位3件)
  = 各ゴール: 累計積立額 / 目標額 × 100
  表示: 進捗バー + 達成予定月

【指標8】今月の積立可能額(予測)
  = 手取り収入合計 − (固定費合計 + 変動費予算合計)
  表示: 円。「このうち○○円をNISAへ」等のサジェスト付き

【指標9】やりたいことリスト 最短達成まで
  = MIN( target_amount − 現在の紐づき積立残高 ) を達成優先度順に表示
  表示: 上位1〜3件のタイトルと残り必要額

【指標10】未完了タスク数
  = COUNT(tasks WHERE status IN ('todo','in_progress') AND due_date <= 今月末+30日)
  表示: 件数バッジ。期限切れは赤表示
```

### 5-2. カード配置案(UI参考)

```
┌────────────────────────────────────────┐
│  6月の家計サマリー           2026/06  │
├──────────┬──────────┬──────────────────┤
│ 収入合計  │ 支出合計  │  収支(黒字/赤字) │
│  ¥420,000 │  ¥310,000 │    +¥110,000     │
├──────────┴──────────┴──────────────────┤
│ 貯蓄率  26.2%  ██████████░░░░  目標20% │
├─────────────────────────────────────────┤
│ ゴール進捗                             │
│ 🎓 教育資金   ████░░░░  41% ¥410万済  │
│ 🆘 緊急予備   ██████░░  63% ¥113万済  │
│ 🏡 住宅購入   ██░░░░░░  22%  ¥110万済 │
├─────────────────────────────────────────┤
│ やりたいこと 次のゴール               │
│ 🏖️ 沖縄旅行 あと¥18万 (8ヶ月後)      │
├─────────────────────────────────────────┤
│ 未完了タスク  3件  (期限近: 保険見直し) │
└─────────────────────────────────────────┘
```

---

## 付録: データ型まとめ(実装者向け早見表)

| テーブル/コレクション | 主キー | 主な外部キー | 備考 |
|---|---|---|---|
| `income_records` | uuid | `income_type_id` | 月次または不定期 |
| `expense_records` | uuid | `category_id`, `expense_type` | fixed/variable フラグ必須 |
| `saving_goals` | uuid | - | target_amount, current_amount |
| `saving_transactions` | uuid | `goal_id` | 入金/引出の履歴 |
| `wish_list_items` | uuid | `category_id`, `linked_goal_id` | ステータス管理 |
| `tasks` | uuid | - | assignee, recurrence |
| `monthly_budgets` | uuid | `category_id`, year, month | 予算設定 |

---

_仕様バージョン: v1.0 / 次回レビュー: 初期リリース後30日_
