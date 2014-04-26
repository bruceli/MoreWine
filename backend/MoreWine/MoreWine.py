from flask import Flask
from database import db_session
from database import init_db
from models import User
from flask import jsonify
from flask import request
from security import requires_auth
from flask.ext.restful import abort

app = Flask(__name__)


@app.teardown_appcontext
def shutdown_session(exception=None):
    db_session.remove()


@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/city/<int:city_id>/shops', methods=['GET'])
def get_city_shops(city_id):
    if city_id:
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


# You can insert entries into the database like this:
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


# Querying is simple as well:
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
    # return admin_user.getName()


@app.route('/user', methods=['DELETE'])
@requires_auth
def remove_user():
    User.query.all()
    admin_user = User.query.filter(User.name == 'admin').first()
    db_session.delete(admin_user)
    db_session.commit()

    return 'deleted'


if __name__ == '__main__':
    app.run(debug=True, port=5000)
