# models.py


import datetime
from app import db


class IP(db.Model):

    __tablename__ = 'nbinstances'

    id = db.Column(db.Integer, primary_key=True)
    ip = db.Column(db.String, nullable=False)
    used = db.Column(db.Boolean, nullable=False)
    date_posted = db.Column(db.DateTime, nullable=False)

    def __init__(self, ip):
        self.ip = ip
        self.used = False
        self.date_posted = datetime.datetime.now()
