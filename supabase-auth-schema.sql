-- ============================================================
-- 今岡家ライフプラン 本番化スキーマ(メール登録＋カップル分離＋招待)
-- Supabase → SQL Editor → New query に貼って [Run]
-- ============================================================

-- 1) 世帯(カップル)ごとのデータ保管
create table if not exists public.app_state (
  household_id uuid primary key default gen_random_uuid(),
  data        jsonb       not null default '{}'::jsonb,
  invite_code text unique,
  updated_at  timestamptz not null default now()
);

-- 2) 世帯メンバー(誰がどの世帯か)
create table if not exists public.members (
  household_id uuid references public.app_state(household_id) on delete cascade,
  user_id      uuid references auth.users(id) on delete cascade,
  created_at   timestamptz default now(),
  primary key (household_id, user_id)
);

alter table public.app_state enable row level security;
alter table public.members   enable row level security;

-- 3) RLS: 自分が所属する世帯だけ読める/書ける
drop policy if exists members_select_self on public.members;
drop policy if exists members_insert_self on public.members;
create policy members_select_self on public.members for select using (user_id = auth.uid());
create policy members_insert_self on public.members for insert with check (user_id = auth.uid());

drop policy if exists app_state_select on public.app_state;
drop policy if exists app_state_update on public.app_state;
create policy app_state_select on public.app_state for select
  using (household_id in (select household_id from public.members where user_id = auth.uid()));
create policy app_state_update on public.app_state for update
  using (household_id in (select household_id from public.members where user_id = auth.uid()))
  with check (household_id in (select household_id from public.members where user_id = auth.uid()));

-- 4) 世帯の作成/参加(SECURITY DEFINERで安全に実行)
create or replace function public.create_household()
returns uuid language plpgsql security definer set search_path = public as $$
declare hid uuid; code text;
begin
  code := upper(substr(md5(random()::text), 1, 6));
  insert into public.app_state(data, invite_code) values ('{}'::jsonb, code) returning household_id into hid;
  insert into public.members(household_id, user_id) values (hid, auth.uid());
  return hid;
end; $$;

create or replace function public.join_household(p_code text)
returns uuid language plpgsql security definer set search_path = public as $$
declare hid uuid;
begin
  select household_id into hid from public.app_state where invite_code = upper(p_code);
  if hid is null then raise exception 'invalid invite code'; end if;
  insert into public.members(household_id, user_id) values (hid, auth.uid()) on conflict do nothing;
  return hid;
end; $$;

grant execute on function public.create_household()        to authenticated;
grant execute on function public.join_household(text)      to authenticated;

-- 5) リアルタイム同期を有効化
alter publication supabase_realtime add table public.app_state;

-- 完了。アプリ側で「メール登録 → 新規作成 or 招待コードで参加」が動きます。
