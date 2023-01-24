from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager

app = Flask(__name__, instance_relative_config=True, static_url_path='')
app.config.from_object('config')  # 文件载入配置
app.config.from_pyfile('config.py')  # instance文件载入配置

db = SQLAlchemy(app)

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'users.login'
login_manager.login_message = "请先登录再访问:-)"

from app import views, models
