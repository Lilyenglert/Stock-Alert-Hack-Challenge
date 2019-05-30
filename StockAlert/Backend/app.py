import json, requests
from flask import Flask, request
from db import db, User, Stock
import users_dao
import re
from twython import Twython


withConsumerKey = #REMOVED API KEY
consumerSecret = #REMOVED API KEY


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
    return "Hi, StockAlert is running!"

def isValidEmail(email):
    apilink =  "https://apilayer.net/api/check?access_key=6db903e2932a33dd319b0f4b5cc7c61e&email=" + email + "&format=1"
    r = requests.get(apilink)
    content = r.json()

    return content["format_valid"]

if isValidEmail("my.email@gmail.com") == True :
 print ("This is a valid email address")
else:
 print ("This is not a valid email address")


def extract_token(request):
    auth_header = request.headers.get('Authorization')
    if auth_header is None:
        return False, json.dumps({'error': 'Missing authorization header.'})

    bearer_token = auth_header.replace('Bearer ', '').strip()
    if not bearer_token:
        return False, json.dumps({'error': 'Invalid authorization header.'}) 

    return True, bearer_token

@app.route('/register/', methods=['POST'])
def register_account():
    post_body = json.loads(request.data)
    email = post_body.get('email')
    password = post_body.get('password')


    if email is None or password is None:
        return json.dumps({'success': False, 'error': 'Invalid email or password'})

    if not(isValidEmail(email)) :
        return json.dumps({'success': False, 'error': 'Wrong email format'})
    
    created, user = users_dao.create_user(email, password)

    if not created:
        return json.dumps({'success': False, 'error': 'User already exists'})

    return json.dumps({
        'success': True,
        'user': user.serialize(),
        'session_token': user.session_token,
        'session_expiration': str(user.session_expiration),
        'update_token': user.update_token
    })

@app.route('/login/', methods=['POST'])
def login():
    post_body = json.loads(request.data)
    email = post_body.get('email')
    password = post_body.get('password')

    if email is None or password is None:
        return json.dumps({'success': False, 'error': 'Invalid email or password'}), 400

    check= users_dao.get_user_by_email(email)
    if check is None :
        if not(isValidEmail(email)) :
            return json.dumps({'success': False, 'error': 'Wrong email format'}), 400
        
        created, user = users_dao.create_user(email, password)

        if not created:
            return json.dumps({'success': False, 'error': 'User already exists'}), 409

        return json.dumps({
            'success': True,
            'user': [user.serialize()],
        }), 201

    else: 
        success, user = users_dao.verify_credentials(email, password)

        if not success:
            return json.dumps({'success': False, 'error': 'Incorrect email or password'}), 400
        
        return json.dumps({
            'success': True,
            'user': [user.serialize()],
        }), 200


@app.route('/session/', methods=['POST'])
def update_session():
    success, update_token = extract_token(request)

    if not success:
        return update_token 

    try:
        user = users_dao.renew_session(update_token)
    except:
        return json.dumps({'success': True, 'error': 'Invalid update token'})

    return json.dumps({
        'success': True,
        'user': user.serialize(),
        'session_token': user.session_token,
        'session_expiration': str(user.session_expiration),
        'update_token': user.update_token
    })

@app.route('/secret/', methods=['GET'])
def secret_message():
    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)
    if not user or not user.verify_session_token(session_token):
        return json.dumps({'success': False, 'error': 'Invalid session token'})

    return json.dumps({'success': True, 'message': 'Logged in as ' + user.email })
    
#User related functions
@app.route('/home/user/<int:user_id>/')
def user_homepage(user_id):
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return json.dumps({'success': False, 'error': 'User not found'}), 404
    
    stocks = [stock.update() for stock in user.stocks]
    return json.dumps({'success': True, 'stocks': stocks})

@app.route('/api/users/')
def get_users():
    users = User.query.all()
    res = {
        'success': True,
        'data': [user.serialize() for user in users]
    }
    return json.dumps(res), 200
#
@app.route('/api/users/', methods=['POST'])
def create_user():
    post_body = json.loads(request.data)
    new_user = User(
        email=post_body.get('email', ''),
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


@app.route('/api/stock/<int:user_id>/delete/', methods=['DELETE'])
def delete_stock_for_user(user_id):
    post_body = json.loads(request.data)
    ticker = post_body.get('ticker', '')

    user = User.query.filter_by(id=user_id).first()
    stock = Stock.query.filter_by(ticker=ticker).first()

    if user is None:
        return json.dumps({'success': False, 'error': 'User not found'}), 404

    if stock is None:
        return json.dumps({'success': False, 'error': 'Stock not found'}), 404

    if stock is not None:
        db.session.delete(stock)
        db.session.commit()
        return json.dumps({'success': True, 'data': stock.serialize()}), 200

    


@app.route('/api/stock/<string:stock_ticker>/')
def get_stock_by_ticker(stock_ticker):
    stock = Stock.query.filter_by(ticker=stock_ticker).first()
    if stock is not None:
        return json.dumps({'success': True, 'data': stock.serialize()}), 200
    return json.dumps({'success': False, 'error': 'Stock not found'}), 404

#Others
@app.route('/api/user/<int:user_id>/add/', methods=['POST'])
def add_stock_to_user(user_id):
    post_body = json.loads(request.data)
    ticker = post_body.get('ticker', '')

    user = User.query.filter_by(id=user_id).first()
    stock = Stock.query.filter_by(ticker=ticker).first()

    if user is None:
        return json.dumps({'success': False, 'error': 'User not found'}), 404

    if stock is None:
        apilink = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=" + ticker + "&apikey=#REMOVED API KEY"
        r = requests.get(apilink)
        content = r.json()
        company = content["bestMatches"][0]
        company_name = company["2. name"]
        ticker = company["1. symbol"]
        
        stock = Stock(
            ticker=ticker,
            company=company_name,
        )
        db.session.add(stock)
        db.session.commit()

    x = stock.update()

    user.stocks.append(stock)
    db.session.add(user)
    db.session.commit()
    return json.dumps({'success': True, 'data': [user.serialize()]}), 200
        

#AlphaVantage API related functions
#Updates the stock information
@app.route('/api/stock/update/<string:ticker>/')
def updatestock(ticker):
    stock = Stock.query.filter_by(ticker=ticker).first()
    if stock is None:
        return json.dumps({'success': False, 'error': 'Stock not found'}), 404

    stock = stock.update()
    db.session.commit()
    return json.dumps({'success': True, 'data': stock}), 200

#Search bar
@app.route('/search/<string:search_str>/')
def searching_stocks(search_str):
    apilink = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=" + search_str + "&apikey=#REMOVED API KEY"
    r = requests.get(apilink)
    content = r.json()

    names = [stock["2. name"] for stock in content["bestMatches"]]
    tickers = [stock["1. symbol"] for stock in content["bestMatches"]]

    return json.dumps({'success': True, 'data': {"names": names, "tickers": tickers}}), 200


#Twitter
def get_a_tweet(ticker):
    python_tweets = Twython(withConsumerKey, consumerSecret)
    query = {
        'q': "#$" + ticker,
        'result_type': 'popular',
        'count': 5,
        'lang': 'en'
    }

    results = []

    for status in python_tweets.search(**query)['statuses']:
        new_tweet = {
            'user': status['user']['screen_name'],
            'text': status['text']
        }
        results.append(new_tweet)

    return results
            

@app.route('/api/user/<int:user_id>/tweets/')
def get_tweets(user_id):
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return json.dumps({'success': False, 'error': 'User not found'}), 404
    
    result = []
    for stock in user.stocks:
        result = result + get_a_tweet(stock.ticker)

    return json.dumps({'success':True, 'data': result}), 200


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
