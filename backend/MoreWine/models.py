__author__ = 'bruceli'

from sqlalchemy import Column, Integer, String
from database import Base
from passlib.apps import custom_app_context as pwd_context

class User(Base):
    __tablename__ = 'user'
    id = Column(Integer, primary_key=True)
    name = Column(String(50), unique=True)
    gender = Column(String(10), unique=False)
    bday = Column(String(20), unique=False)
    email = Column(String(120), unique=True)
    wechat_id = Column(String(120), unique=True)
    weibo_id = Column(String(120), unique=True)
    password = Column(String(150), unique=False)

    def __init__(self, name, email, gender=None, bday=None, wechat_id=None, weibo_id=None, password=None):
        self.name = name
        self.email = email
        self.gender = gender
        self.bday = bday
        self.wechat_id = wechat_id
        self.weibo_id = weibo_id
        self.password = password

    def get_name(self):
        return self.name

    def get_email(self):
        return self.email

    def set_name(self, name):
        self.name = name

    def set_email(self, email):
        self.email = email

    def set_gender(self, gender):
        self.gender = gender

    def get_gender(self):
        return self.gender

    def set_bday(self, bday):
        self.bday = bday

    def get_bday(self):
        return self.bday

    def set_wechat_id(self, wechat_id):
        self.wechat_id = wechat_id

    def get_wechat_id(self):
        return self.wechat_id

    def set_weibo_id(self, weibo_id):
        self.weibo_id = weibo_id

    def get_weibo_id(self):
        return self.weibo_id

    def setPassword(self, password):
        self.hash_password(password)

    def getPassword(self):
        return self.password

    def hash_password(self, password):
        self.password = pwd_context.encrypt(password)

    def verify_password(self, password):
        return pwd_context.verify(password, self.password_hash)

    def __repr__(self):
        return '<User %r>' % (self.name)
