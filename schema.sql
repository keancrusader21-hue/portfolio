-- Run this in Supabase > SQL Editor
create table projects (
  id bigint generated always as identity primary key,
  title text not null,
  category text not null check (category in ('recap','mlbb','short')),
  video_url text not null,
  thumb_url text,
  duration text,
  created_at timestamptz default now()
);

alter table projects enable row level security;

-- Kahit sino pwedeng makakita ng projects
create policy "public read" on projects for select using (true);

-- Ikaw lang ang pwedeng mag-add/edit/delete (palitan ang email!)
create policy "admin write" on projects for all to authenticated
  using (auth.jwt() ->> 'email' = 'keancrusader21@gmail.com.com')
  with check (auth.jwt() ->> 'email' = 'keancrusader21@gmail.com');
