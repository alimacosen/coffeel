import os

CSRF_ENABLED = True

MAX_CONTENT_LENGTH = 10 * 1024 * 1024

basedir = os.path.abspath(os.path.dirname(__file__))

UPLOAD_PATH = os.path.join(basedir, 'app/static/images/goods')

SQLALCHEMY_TRACK_MODIFICATIONS = True
