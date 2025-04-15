from flask import Flask, request, jsonify
from flask_mysqldb import MySQL # type: ignore
from flask_cors import CORS # type: ignore

app = Flask(__name__)
CORS(app)  # supaya bisa diakses dari Flutter

# Konfigurasi MySQL
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'keuangan_db'

mysql = MySQL(app)

# Get data transaksi
@app.route('/transactions', methods=['GET'])
def get_transactions():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM transactions ORDER BY date DESC")
    rows = cur.fetchall()
    cur.close()

    result = []
    for row in rows:
        result.append({
            'id': row[0],
            'type': row[1],
            'amount': row[2],
            'category': row[3],
            'description': row[4],
            'date': row[5].strftime('%Y-%m-%d')
        })

    return jsonify(result)

# Add data transaksi
@app.route('/transactions', methods=['POST'])
def add_transaction():
    data = request.get_json()
    cur = mysql.connection.cursor()
    cur.execute(
        "INSERT INTO transactions (type, amount, category, description, date) VALUES (%s, %s, %s, %s, %s)",
        (data['type'], data['amount'], data['category'], data['description'], data['date'])
    )
    mysql.connection.commit()
    cur.close()
    return jsonify({'message': 'Transaction added!'}), 201

if __name__ == '__main__':
    app.run(debug=True)
