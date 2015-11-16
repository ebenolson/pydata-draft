# app.py


from flask import Flask
from flask import request, render_template, jsonify
from flask import session
from flask import redirect
from flask.ext.sqlalchemy import SQLAlchemy
from config import BaseConfig


app = Flask(__name__)
app.config.from_object(BaseConfig)
db = SQLAlchemy(app)


from models import *


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/allips')
def allips():
    ips = IP.query.order_by(IP.date_posted.desc()).all()
    return render_template('allips.html', ips=ips)


@app.route('/removeallips')
def removeallips():
    IP.query.delete()
    db.session.commit()
    return redirect('/')


@app.route('/addip', methods=['POST'])
def addip():
    ip = request.form['ip']
    item = IP(ip)
    db.session.add(item)
    db.session.commit()
    return jsonify({'status': 'OK'})


@app.route('/notebook')
def notebook():
    if 'notebookip' not in session:
        try:
            ip = IP.query.filter_by(used=False).limit(1).all()[0]
            session['notebookip'] = ip.ip
            ip.used = True
            db.session.commit()
        except IndexError:
            return render_template('no_notebook.html')
    return render_template('notebook.html', ip=session['notebookip'])


@app.route('/resetip')
def resetip():
    if 'notebookip' in session:
        del session['notebookip']
        db.session.commit()
    return redirect('/')


@app.route('/get')
def get():
    return session['notebookip']


if __name__ == '__main__':
    app.run()
