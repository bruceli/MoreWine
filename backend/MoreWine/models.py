__author__ = 'bruceli'

from sqlalchemy import Column, ForeignKey, Integer, String
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

    def hash_password(self, password):
        self.password = pwd_context.encrypt(password)

    def verify_password(self, password):
        return pwd_context.verify(password, self.password_hash)

    def __repr__(self):
        return '<User %r>' % (self.name)


class Shop(Base):
    __tablename__ = "shop"
    id = Column(Integer, primary_key=True)
    name_en = Column(String(100), unique=False)
    name_cn = Column(String(100), unique=False)
    address = Column(String(250), unique=False)
    phone = Column(String(100), unique=False)
    wechat_id = Column(String(120), unique=True)
    weibo_id = Column(String(120), unique=True)
    description = Column(String(500), unique=False)
    image_urls = Column(String(1000), unique=False)
    city = Column(String(100), unique=False)
    province = Column(String(200), unique=False)
    location = Column(String(200), unique=False)

    def __init__(self, name_cn, address, phone, description, city, province, location, name_en=None, wechat_id=None, weibo_id=None, image_urls=None):
        self.name_en = name_en
        self.name_cn = name_cn
        self.address = address
        self.phone = phone
        self.wechat_id = wechat_id
        self.weibo_id = weibo_id
        self.description = description
        self.image_urls = image_urls
        self.city = city
        self.province = province
        self.location = location

    def __repr__(self):
        return '<Shop %r>' % (self.name_cn)

class Wine(Base):
    __tablename__ = "wine"
    id = Column(Integer, primary_key=True)
    name_en = Column(String(100), unique=False)
    name_cn = Column(String(100), unique=False)
    description = Column(String(500), unique=False)
    image_urls = Column(String(1000), unique=False)

    def __init__(self, name_cn, description, name_en=None, image_urls =None):
        self.name_cn = name_cn
        self.name_en = name_en
        self.description = description
        self.image_urls = image_urls

    def __repr__(self):
        return '<Wine %r>' % self.name_cn

class Tag(Base):
    __tablename__ = "tag"
    id = Column(Integer, primary_key=True)
    tag = Column(String(20), unique=True)

    def __init__(self, tag):
        self.tag = tag

    def __repr__(self):
        return '<Tag %r>' % self.tag

class Shop_tags(Base):
    __tablename__ = "shop_tags"
    shop_id = Column(Integer, ForeignKey("shop.id"), primary_key=True)
    tag_id = Column(Integer, ForeignKey("tag.id"), primary_key=True)
    user_id = Column(Integer, ForeignKey("user.id"), primary_key=True)

    def __init__(self, shop_id, tag_id, user_id=None):
        self.shop_id = shop_id
        self.tag_id = tag_id
        self.user_id = user_id

    def __repr__(self):
        return '<Shop %r has Tag %r>' % self.shop_id % self.tag_id

class Wine_tags(Base):
    __tablename__ = "wine_tags"
    wine_id = Column(Integer, ForeignKey("wine.id"), primary_key=True)
    tag_id = Column(Integer, ForeignKey("tag.id"), primary_key=True)

    def __init__(self, wine_id, tag_id):
        self.wine_id = wine_id
        self.tag_id = tag_id

    def __repr__(self):
        return '<Wine %r has Tag %r>' % self.wine_id % self.tag_id

class Material(Base):
    __tablename__ = "material"
    id = Column(Integer, primary_key=True)
    name_en = Column(String(100), unique=False)
    name_cn = Column(String(100), unique=False)
    description = Column(String(500), unique=False)
    image_urls = Column(String(1000), unique=False)

    def __init__(self, name_cn, description, name_en=None, image_urls =None):
        self.name_cn = name_cn
        self.name_en = name_en
        self.description = description
        self.image_urls = image_urls

    def __repr__(self):
        return '<Material %r>' % self.name_cn

class Cocktail(Base):
    __tablename__ = "cocktail"
    id = Column(Integer, primary_key=True)
    name_en = Column(String(100), unique=False)
    name_cn = Column(String(100), unique=False)
    description = Column(String(500), unique=False)
    image_urls = Column(String(1000), unique=False)
    material_ids = Column(String(1000), unique=False)

    def __init__(self, name_cn, description, material_ids, name_en=None, image_urls =None):
        self.name_cn = name_cn
        self.name_en = name_en
        self.description = description
        self.image_urls = image_urls
        self.material_ids = material_ids

    def __repr__(self):
        return '<Cocktail %r>' % self.name_cn

class User_fav_shops(Base):
    __tablename__ = "user_fav_shops"
    user_id = Column(Integer, ForeignKey("user.id"), primary_key=True)
    shop_id = Column(Integer, ForeignKey("shop.id"), primary_key=True)

    def __init__(self, user_id, shop_id):
        self.user_id = user_id
        self.shop_id = shop_id

    def __repr__(self):
        return '<User %r favorited Shop %r>' % self.user_id % self.shop_id

class User_fav_wines(Base):
    __tablename__ = "user_fav_wines"
    user_id = Column(Integer, ForeignKey("user.id"), primary_key=True)
    wine_id = Column(Integer, ForeignKey("wine.id"), primary_key=True)
    shop_id = Column(Integer)

    def __init__(self, user_id, wine_id, shop_id=None):
        self.user_id = user_id
        self.wine_id = wine_id
        self.shop_id = shop_id

    def __repr__(self):
        return '<User %r favorited Wine %r>' % self.user_id % self.wine_id