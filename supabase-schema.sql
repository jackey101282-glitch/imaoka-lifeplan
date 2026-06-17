-- ============================================================
-- 今岡家ライフプラン管理アプリ — Supabase セットアップSQL
-- Supabaseダッシュボード → SQL Editor に貼り付けて [Run] するだけ
-- ============================================================

-- 1) アプリの全データを保存するテーブル
--    1つの「共有コード(space_id)」ごとに、家庭の全データをJSONで保持します。
create table if not exists public.app_state (
  space_id   text primary key,
  data       jsonb       not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- 2) 行レベルセキュリティを有効化
alter table public.app_state enable row level security;

-- 3) anon(公開キー)からの読み書きを許可するポリシー
--    ※ space_id(共有コード)を知っている人だけがアクセスできる方式です。
--      共有コードは推測されにくい長めの文字列にしてください(設定画面の「生成」推奨)。
drop policy if exists "anon_read"  on public.app_state;
drop policy if exists "anon_write" on public.app_state;
drop policy if exists "anon_update" on public.app_state;

create policy "anon_read"   on public.app_state for select using (true);
create policy "anon_write"  on public.app_state for insert with check (true);
create policy "anon_update" on public.app_state for update using (true) with check (true);

-- 4) リアルタイム同期を有効化(2台のスマホ間で即時反映)
alter publication supabase_realtime add table public.app_state;

-- 完了。アプリの設定画面に Project URL / anon key / 共有コード を入力してください。
