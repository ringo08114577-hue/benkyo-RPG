-- STUDY REALM: cloud save table for Supabase
-- Run this once in Supabase Dashboard > SQL Editor.
-- Never place a service_role key in browser code.

create table if not exists public.game_saves (
  user_id uuid primary key references auth.users (id) on delete cascade,
  save_data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.game_saves enable row level security;

-- Restrict table access to authenticated users; policies below limit each user to their own row.
revoke all on table public.game_saves from anon, authenticated;
grant select, insert, update on table public.game_saves to authenticated;

drop policy if exists "Users can read their own save" on public.game_saves;
create policy "Users can read their own save"
  on public.game_saves
  for select
  to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users can create their own save" on public.game_saves;
create policy "Users can create their own save"
  on public.game_saves
  for insert
  to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update their own save" on public.game_saves;
create policy "Users can update their own save"
  on public.game_saves
  for update
  to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
