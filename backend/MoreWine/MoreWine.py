from flask import Flask, jsonify, request, Response
from database import db_session, init_db
from security import requires_auth
from flask.ext.restful import abort
from models import *
import json

app = Flask(__name__)


@app.teardown_appcontext
def shutdown_session(exception=None):
    db_session.remove()


@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/city/<int:id>/shops', methods=['GET'])
def get_city_shops(id):
    if id:
        return "[{'id': 1, 'name_en':'more cafe'}, {'id':2,'name_en':'magic bar'}]"
    else:
        abort(404)

@app.route('/login', methods=['POST'])
def login():
    return True


@app.route('/create_db', methods=['GET'])
@requires_auth
def init_my_db():
    print 'init database'
    init_db()
    return 'done creating db.'


@app.route('/user', methods=['POST'])
@requires_auth
def add_user():
    user_json = request.json
    if (user_json):
        print(user_json)
        user = User(name=user_json.get("name"), email=user_json.get("email"), password=user_json.get("password"))
        user.hash_password(user.password)
    else:
        user = User('admin', 'admin@localhost')

    try:
        db_session.add(user)
        db_session.commit()
    except Exception as ex:
        print(ex)
    return 'user added: ' + user.name


@app.route('/user', methods=['GET'])
@requires_auth
def query_user():
    User.query.all()
    admin_user = User.query.filter(User.name == 'admin').first()
    if admin_user:
        print 'user name is: ' + admin_user.name

        return jsonify(username=admin_user.name, email=admin_user.email)
    else:
        abort(404)


@app.route('/user/<int:id>', methods=['DELETE'])
@requires_auth
def remove_user():
    if id:
        User.query.all()
        user = User.query.filter(User.id == id).first()
        db_session.delete(user)
        db_session.commit()

    return 'user deleted'

@app.route('/province/<int:id>/cities', methods=['GET'])
@requires_auth
def get_province_cities(id):
    if id:
        # subq = db_session.query(Province_city).filter(Province_city.province_id == id).subquery()
        # cities = db_session.query(City).\
        #     join(subq, City.id == subq.c.city_id).all()
        cities = db_session.query(City).join(Province_city, Province_city.province_id == id).all()
        return jsonify(cities = [city.serialize() for city in cities])
    return 'nothing found'

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True, port=5555)
