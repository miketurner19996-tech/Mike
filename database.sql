create table if not exists public.leads (
 id uuid primary key default gen_random_uuid(),
 created_at timestamptz not null default now(),
 name text not null,
 phone text not null,
 email text,
 area text not null,
 services text[] default '{}',
 details text,
 preferred_contact text,
 status text not null default 'new' check (status in ('new','contacted','quoted','won','lost'))
);

alter table public.leads enable row level security;

create policy "public can create leads"
on public.leads for insert
to anon
with check (true);

create policy "authenticated users can read leads"
on public.leads for select
to authenticated
using (true);

create policy "authenticated users can update leads"
on public.leads for update
to authenticated
using (true)
with check (true);
