-- Enable the pg_vector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- Create tables
CREATE TABLE IF NOT EXISTS articles (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    url TEXT NOT NULL,
    publication_date DATE NOT NULL,
    issue_id TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Embeddings table
CREATE TABLE IF NOT EXISTS embeddings (
    id SERIAL PRIMARY KEY,
    article_id INTEGER REFERENCES articles(id),
    embedding vector(384),  -- Dimension for all-MiniLM-L6-v2
    chunk_text TEXT NOT NULL,  -- The text chunk that was embedded
    chunk_index INTEGER NOT NULL,  -- Index of chunk within article
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create index for vector similarity search
CREATE INDEX ON embeddings USING ivfflat (embedding vector_cosine_ops);