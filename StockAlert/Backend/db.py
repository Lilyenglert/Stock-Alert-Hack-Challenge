from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

user_stocks_association_table = db.Table(
    "user's stocks", db.Model.metadata,
    db.Column('user_id', db.Integer, db.ForeignKey('user.id')),
    db.Column('stock_id', db.Integer, db.ForeignKey('stock.id'))
)

notification_association_table = db.Table(
    'notification', db.Model.metadata,
    db.Column('user_id', db.Integer, db.ForeignKey('user.id')),
    db.Column('stock_id', db.Integer, db.ForeignKey('stock.id'))
)

class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, nullable=False)
    password = db.Column(db.String, nullable=False)
    stocks = db.relationship('Stock', secondary=user_stocks_association_table)

    def  __init__(self, **kwargs):
        self.username = kwargs.get('username', '')
        self.password = kwargs.get('password', '')

    def serialize(self):
        return {
            'id': self.id,
            'username': self.username,
            'password': self.password,
            'stocks': [stock.serialize() for stock in self.stocks]
        }

class Stock(db.Model):
    __tablename__ = 'stock'
    id = db.Column(db.Integer, primary_key=True)
    ticker = db.Column(db.String, nullable=False)
    company = db.Column(db.String, nullable=False)
    price = db.Column(db.Integer, nullable=True)
    p_change = db.Column(db.String, nullable=True)
    notification_users = db.relationship('User', secondary=notification_association_table)

    def __init__(self, **kwargs):
        self.ticker = kwargs.get('ticker')
        self.company = kwargs.get('company')
        self.price = kwargs.get('price')
        self.p_change = kwargs.get('pchange')
        
    def serialize(self):
        return {
            'id': self.id,
            'ticker': self.ticker,
            'company': self.company,
            'price': self.price,
            'p_change': self.p_change,
            'notification users': [user.serialize() for user in self.notification_users]
        }



