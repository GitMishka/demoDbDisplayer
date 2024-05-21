from flask import Flask, render_template
import psycopg2
import os

app = Flask(__name__)

def fetch_posts():
    conn = psycopg2.connect(
        host=os.getenv('PG_HOST'),
        database=os.getenv('PG_DATABASE'),
        user=os.getenv('PG_USER'),
        password=os.getenv('PG_PASSWORD')
    )
    cur = conn.cursor()
    cur.execute("SELECT * FROM watchexchange_posts;")
    posts = cur.fetchall()
    cur.close()
    conn.close()
    return posts

@app.route('/')
def display_posts():
    posts = fetch_posts()
    return render_template('posts.html', posts=posts)

if __name__ == '__main__':
    app.run(debug=True)
