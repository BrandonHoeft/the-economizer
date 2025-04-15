import psycopg2

# Verify the database connection by running a simple script to
# connect to PostgreSQL and check if the vector extension is available:
conn = psycopg2.connect("postgresql://economizer:economizer@economizer-db:5432/economizer")
cursor = conn.cursor()
cursor.execute("SELECT * FROM pg_extension")
extensions = cursor.fetchall()
print("Available extensions:", extensions)
cursor.close()
conn.close()