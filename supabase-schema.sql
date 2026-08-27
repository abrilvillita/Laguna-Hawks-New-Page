-- Laguna Hawks Team Hub
-- Run only in the new Laguna Hawks Supabase project.
create table public.team_members (
  user_id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null,
  role text not null default 'member' check (role in ('admin','editor','member')),
  created_at timestamptz not null default now()
);
create table public.project_items (
  id bigint generated always as identity primary key,
  kind text not null check (kind in ('task','material','milestone','update')),
  title text not null check (char_length(title) between 2 and 120),
  detail text not null default '',
  status text not null default 'pending' check (status in ('pending','in_progress','blocked','done')),
  progress smallint not null default 0 check (progress between 0 and 100),
  quantity numeric,
  owner_id uuid references auth.users(id) on delete set null,
  created_by uuid not null default auth.uid() references auth.users(id),
  updated_by uuid not null default auth.uid() references auth.users(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
alter table public.team_members enable row level security;
alter table public.project_items enable row level security;
revoke all on public.team_members, public.project_items from anon;
grant select on public.team_members to authenticated;
grant select, insert, update, delete on public.project_items to authenticated;
grant usage, select on all sequences in schema public to authenticated;
create policy "members read team" on public.team_members for select to authenticated
using (exists (select 1 from public.team_members me where me.user_id=(select auth.uid())));
create policy "members read items" on public.project_items for select to authenticated
using (exists (select 1 from public.team_members me where me.user_id=(select auth.uid())));
create policy "editors create items" on public.project_items for insert to authenticated
with check (exists (select 1 from public.team_members me where me.user_id=(select auth.uid()) and me.role in ('admin','editor')) and created_by=(select auth.uid()) and updated_by=(select auth.uid()));
create policy "editors update items" on public.project_items for update to authenticated
using (exists (select 1 from public.team_members me where me.user_id=(select auth.uid()) and me.role in ('admin','editor')))
with check (exists (select 1 from public.team_members me where me.user_id=(select auth.uid()) and me.role in ('admin','editor')) and updated_by=(select auth.uid()));
create policy "admins delete items" on public.project_items for delete to authenticated
using (exists (select 1 from public.team_members me where me.user_id=(select auth.uid()) and me.role='admin'));
alter publication supabase_realtime add table public.project_items;

