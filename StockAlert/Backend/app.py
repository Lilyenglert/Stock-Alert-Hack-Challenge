import json
from flask import Flask, request
from db import db, User, Stock

#import environment variables from the host OS
#from os import environ

app = Flask(__name__)
db_filename = 'stockalert.db'

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///%s' % db_filename
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True

db.init_app(app)
with app.app_context():
    db.create_all()

@app.route('/')
def root():
    return "StockAlert is running!"

#User related functions
@app.route('/api/users/')
def get_users():
    users = User.query.all()
    res = {
        'success': True,
        'data': [user.serialize() for user in users]
    }
    return json.dumps(res), 200

@app.route('/api/users/', methods=['POST'])
def create_user():
    post_body = json.loads(request.data)
    new_user = User(
        username=post_body.get('username', ''),
        password=post_body.get('password', '')
    )
    db.session.add(new_user)
    db.session.commit()
    return json.dumps({'success': True, 'data': new_user.serialize()}), 201

@app.route('/api/user/<int:user_id>/')
def get_user(user_id):
    user = User.query.filter_by(id=user_id).first()
    if user is not None:
        return json.dumps({'success': True, 'data': user.serialize()}), 200
    return json.dumps({'success': False, 'error': 'User not found'}), 404

@app.route('/api/user/<int:user_id>/', methods=['DELETE'])
def delete_user(user_id):
    user = User.query.filter_by(id=user_id).first()
    if user is not None:
        db.session.delete(user)
        db.session.commit()
        return json.dumps({'success': True, 'data': user.serialize()}), 200
    return json.dumps({'success': False, 'error': 'User not found'}), 404

#Stock related functions
@app.route('/api/stocks/')
def get_stocks():
    stocks = Stock.query.all()
    res = {
        'success': True,
        'data': [stock.serialize() for stock in stocks]
    }
    return json.dumps(res), 200

@app.route('/api/stocks/', methods=['POST'])
def create_stock():
    post_body = json.loads(request.data)
    new_stock = Stock(
        ticker=post_body.get('ticker', ''),
        company=post_body.get('company', '')
    )
    db.session.add(new_stock)
    db.session.commit()
    return json.dumps({'success': True, 'data': new_stock.serialize()}), 201

@app.route('/api/stock/<int:stock_id>/')
def get_stock(stock_id):
    stock = Stock.query.filter_by(id=stock_id).first()
    if stock is not None:
        return json.dumps({'success': True, 'data': stock.serialize()}), 200
    return json.dumps({'success': False, 'error': 'Stock not found'}), 404

@app.route('/api/stock/<int:stock_id>/', methods=['DELETE'])
def delete_stock(stock_id):
    stock = Stock.query.filter_by(id=stock_id).first()
    if stock is not None:
        db.session.delete(stock)
        db.session.commit()
        return json.dumps({'success': True, 'data': stock.serialize()}), 200
    return json.dumps({'success': False, 'error': 'Stock not found'}), 404

#Others
@app.route('/api/user/<int:user_id>/add/', methods=['POST'])
def add_stock_to_user(user_id):
    post_body = json.loads(request.data)
    stock_id = post_body.get('stock_id', '')

    user = User.query.filter_by(id=user_id).first()
    stock = Stock.query.filter_by(id=stock_id).first()

    if user is None:
        return json.dumps({'success': False, 'error': 'User not found'}), 404
    
    if stock is None:
        return json.dumps({'success': False, 'error': 'Stock not found'}), 404

    user.stocks.append(stock)
    db.session.add(user)
    db.session.commit()
    return json.dumps({'success': True, 'data': user.serialize()}), 200
    

@app.route('/api/stock/<int:stock_id>/add/', methods=['POST'])
def add_user_to_stock_notification(stock_id):
    post_body = json.loads(request.data)
    user_id = post_body.get('user_id', '')

    user = User.query.filter_by(id=user_id).first()
    stock = Stock.query.filter_by(id=stock_id).first()

    if user is None:
        return json.dumps({'success': False, 'error': 'User not found'}), 404
    
    if stock is None:
        return json.dumps({'success': False, 'error': 'Stock not found'}), 404

    stock.notification_users.append(user)
    db.session.add(stock)
    db.session.commit()
    return json.dumps({'success': True, 'data': stock.serialize()}), 200
    

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
