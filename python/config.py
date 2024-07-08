from app import app
from pymysql import connect,cursors


def get_db_connection():
    return connect(
        host=app.config['MYSQL_HOST'],
        user=app.config['MYSQL_USER'],
        password=app.config['MYSQL_PASSWORD'],
        database=app.config['MYSQL_DB'],
        cursorclass=cursors.DictCursor
    )