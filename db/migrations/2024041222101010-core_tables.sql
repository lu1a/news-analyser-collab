
-- +migrate Up
CREATE TABLE IF NOT EXISTS article (
    article_id SERIAL PRIMARY KEY,
    imported_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    title TEXT,
    published_at TIMESTAMPTZ,
    body TEXT,
    tsvector_content_desc TSVECTOR GENERATED ALWAYS AS (to_tsvector('english', coalesce(title, '') || ' ' || coalesce(body, ''))) STORED,
    tags TEXT ARRAY NOT NULL DEFAULT '{}'
);
CREATE INDEX article_tags_idx ON article USING gin (tags);
CREATE INDEX article_textsearch_idx ON article USING GIN (tsvector_content_desc);
CREATE TABLE IF NOT EXISTS case (
    case_id SERIAL PRIMARY KEY,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    md_content TEXT,
    published_at TIMESTAMPTZ -- our staff published this case on our site
);
CREATE TABLE IF NOT EXISTS account_case_map (
  account_id INTEGER REFERENCES account(account_id),
  case_id INTEGER REFERENCES case(case_id),
  PRIMARY KEY (account_id, case_id)
);

-- +migrate Down
DROP TABLE IF EXISTS account_case_map;
DROP TABLE IF EXISTS case;
DROP INDEX IF EXISTS article_textsearch_idx;
DROP INDEX IF EXISTS article_tags_idx;
DROP TABLE IF EXISTS article;
