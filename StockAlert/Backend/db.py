from flask_sqlalchemy import SQLAlchemy
import bcrypt
import datetime
import hashlib
import os
import json
import requests
from operator import itemgetter


db = SQLAlchemy()
apikey1 = #REMOVED API KEY
apikey2 = #REMOVED API KEY

user_stocks_association_table = db.Table(
    "user's stocks", db.Model.metadata,
    db.Column('user_id', db.Integer, db.ForeignKey('user.id')),
    db.Column('stock_id', db.Integer, db.ForeignKey('stock.id'))
)

class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)

    #user information
    email = db.Column(db.String, nullable=False, unique=True)
    #password = db.Column(db.String, nullable=False)
    password_digest = db.Column(db.String, nullable=False)
     #Session information
    session_token=db.Column(db.String, nullable=False, unique=True)
    session_expiration=db.Column(db.DateTime, nullable=False)
    update_token= db.Column(db.String,nullable=False, unique=True)

    #stock information
    stocks = db.relationship('Stock', secondary=user_stocks_association_table)

   

    def  __init__(self, **kwargs):
        self.email = kwargs.get('email')
        self.password_digest = bcrypt.hashpw(kwargs.get('password').encode('utf8'),
        bcrypt.gensalt(rounds=13))
        self.renew_session()

    #used to randomly generate session/update tokens   
    def _urlsafe_base_64(self):
      return hashlib.sha1(os.urandom(64)).hexdigest()

    #generate new tokens, and resets expiration time
    def renew_session(self):
       self.session_token = self._urlsafe_base_64()
       self.session_expiration = datetime.datetime.now() + \
                                datetime.timedelta(days=1)
       self.update_token = self._urlsafe_base_64()


    def verify_password (self, password):
      return bcrypt.checkpw(password.encode('utf8'),self.password_digest)

    def verify_session_token(self, session_token):
      return session_token==self.session_token and \
        datetime.datetime.now() < self.session_expiration
      
    def verify_update_token(self, update_token):
      return update_token ==self.update_token


    def serialize(self):
        return {
            'id': self.id,
            'email': self.email,
            'stocks': sorted([stock.serialize() for stock in self.stocks], key=itemgetter("ticker"))
        }

   

class Stock(db.Model):
    __tablename__ = 'stock'
    id = db.Column(db.Integer, primary_key=True)
    ticker = db.Column(db.String, nullable=False)
    company = db.Column(db.String, nullable=False)
    price = db.Column(db.Integer, nullable=True)
    p_change = db.Column(db.Float, nullable=True)

    def __init__(self, **kwargs):
        self.ticker = kwargs.get('ticker')
        self.company = kwargs.get('company')
        self.price = 0.0
        self.p_change = 0.0
        
    def serialize(self):
        return {
            'id': self.id,
            'ticker': self.ticker,
            'company': self.company,
            'price': self.price,
            'p_change': self.p_change
        }

    def update(self):
        apilink = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=" + self.ticker + apikey2
        r = requests.get(apilink)
        content = r.json()
        price = content["Global Quote"]["05. price"]
        p_change = content["Global Quote"]["10. change percent"]

        self.price = float(price[:-1])
        self.p_change = float(p_change[:-1])

        return self.serialize()



