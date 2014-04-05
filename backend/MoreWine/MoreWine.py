from flask import Flask
from database import db_session
from database import init_db
from models import User
from flask import jsonify
from flask import request
from flask import json

app = Flask(__name__)


@app.teardown_appcontext
def shutdown_session(exception=None):
    db_session.remove()


@app.route('/')
def hello_world():
    return 'Hello World!'


@app.route('/login', methods=['POST'])
def login():
    return True


@app.route('/create_db', methods=['GET'])
def init_my_db():
    print 'init database'
    init_db()
    return 'done creating db.'


# You can insert entries into the database like this:
@app.route('/user', methods=['POST'])
def add_user():
    user_json = request.json
    if (json):
        print(user_json)
        user = jsonify(user_json)
    else:
        user = User('admin', 'admin@localhost')

    db_session.add(user)
    db_session.commit()

    return 'user added: ' + user.getName()


# Querying is simple as well:
@app.route('/user', methods=['GET'])
def query_user():
    User.query.all()
    admin_user = User.query.filter(User.name == 'admin').first()
    print 'user name is: ' + admin_user.getName()

    return jsonify(username=admin_user.getName(), email=admin_user.email)
    # return admin_user.getName()


@app.route('/user', methods=['DELETE'])
def remove_user():
    User.query.all()
    admin_user = User.query.filter(User.name == 'admin').first()
    db_session.delete(admin_user)
    db_session.commit()

    return 'deleted'


if __name__ == '__main__':
    app.run()
