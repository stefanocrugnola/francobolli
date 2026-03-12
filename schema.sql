-- ============================================================
-- Collezione Filatelica Italiana — Schema Supabase
-- ============================================================
-- Eseguire questo script nell'SQL Editor del progetto Supabase:
--   supabase.com → progetto → SQL Editor → New query → incolla → Run
-- ============================================================

create table if not exists stamps (
  id            bigserial       primary key,
  title         text            not null,
  subtitle      text,
  anno          integer,
  valore        text,
  serie         text,
  sassone       text,
  dentellatura  text,
  carta         text,
  colore        text,
  era           text            not null default 'repubblica',
                -- valori: 'antichi-stati' | 'regno' | 'repubblica'
  immagine      text,
  note          text,
  posseduto     boolean         not null default true,
                -- true  = in collezione
                -- false = in mancolista (da acquistare)
  condizione    text,
                -- 'fds' | 'spl' | 'bb'  (usato quando posseduto = true)
  priorita      text,
                -- 'alta' | 'media' | 'bassa'  (usato quando posseduto = false)
  created_at    timestamptz     default now()
);

-- ── Row Level Security ─────────────────────────────────────────
-- Progetto personale: si permette tutto agli utenti anonimi.
-- Se in futuro si vuole restringere, sostituire questa policy
-- con una basata su auth.uid().
alter table stamps enable row level security;

create policy "Accesso completo per uso personale"
  on stamps for all
  using (true)
  with check (true);

-- ── Indici ────────────────────────────────────────────────────
create index if not exists stamps_anno_idx      on stamps(anno);
create index if not exists stamps_era_idx       on stamps(era);
create index if not exists stamps_posseduto_idx on stamps(posseduto);
create index if not exists stamps_serie_idx     on stamps(serie);
create index if not exists stamps_sassone_idx   on stamps(sassone);
