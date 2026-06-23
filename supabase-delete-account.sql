-- ============================================================
-- Mietta: アカウント削除 RPC（App Store Guideline 5.1.1(v) 対応）
-- ------------------------------------------------------------
-- アプリの「アカウントを削除」ボタンから呼ばれる関数。
-- ログイン中の本人(auth.uid())について：
--   1. 所属する各スペース(世帯)から自分のメンバー行を削除
--   2. そのスペースに他のメンバーが居なければ、スペースのデータ(app_state)も削除
--   3. 認証ユーザー本体(auth.users)を削除
-- SECURITY DEFINER で実行（auth.users を消すため）。
--
-- ▼ デプロイ手順（社長と一緒に・5分）
--   1. https://supabase.com → プロジェクト imfynopqugqiczevrmsl を開く
--   2. 左メニュー「SQL Editor」→「New query」
--   3. 下のSQLを全部貼り付けて「Run」
--   4. エラーが出たら、その文面を Claude に貼る（テーブル名/列名を調整します）
--
-- ※ 想定スキーマ：members(household_id, user_id) / app_state(household_id)
--   （CLAUDE.md 記載：全データは app_state(世帯JSON)＋members、RLSで世帯分離）
--   households テーブルが別にある場合は、コメントの行を有効化してください。
-- ============================================================

create or replace function public.delete_account()
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_hh  uuid;
begin
  if v_uid is null then
    raise exception 'not authenticated';
  end if;

  -- 自分が所属する世帯ごとに処理
  for v_hh in select household_id from members where user_id = v_uid loop
    -- 自分のメンバー行を削除
    delete from members where household_id = v_hh and user_id = v_uid;

    -- その世帯に他メンバーが残っていなければ、世帯データも削除
    if not exists (select 1 from members where household_id = v_hh) then
      delete from app_state where household_id = v_hh;
      -- households テーブルがある場合は次行を有効化:
      -- delete from households where id = v_hh;
    end if;
  end loop;

  -- 認証ユーザー本体を削除（これでアカウント自体が消える）
  delete from auth.users where id = v_uid;
end;
$$;

-- 実行権限：ログイン済みユーザーのみ
revoke all on function public.delete_account() from public;
grant execute on function public.delete_account() to authenticated;

-- ============================================================
-- 確認用（任意）：関数が作成されたか
--   select proname from pg_proc where proname = 'delete_account';
-- ============================================================
