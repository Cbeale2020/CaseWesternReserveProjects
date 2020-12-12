import datetime as dt
from dateutil.relativedelta import relativedelta
import numpy as np
import pandas as pd

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func

from flask import Flask, jsonify
from flask import Flask
# Create engine
engine = create_engine("sqlite:///Resources/hawaii.sqlite")
# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save references to each table
Measurement = Base.classes.measurement
Station = Base.classes.station
# Create Session
session = Session(engine) 
# Create Flask
app = Flask(__name__)

# Home page Route
@app.route("/")
def home():
    return ("/api/v1.0/precipitation<br/>"
            "/api/v1.0/stations<br/>"
            "/api/v1.0/tobs<br/>"
            "/api/v1.0/2017-01-01<br/>")

# Precip page Route
@app.route("/api/v1.0/precipitation")
def precipitation():
    date_precips = session.query(Measurement.date, Measurement.prcp).\
    filter(Measurement.date <= '2017-08-23').\
        filter(Measurement.date >= '2016-08-23').all()
    dict = list(np.ravel(date_precips))
    return jsonify(dict)
# Station page Route
@app.route("/api/v1.0/stations")
def stations():
    active_stations = (session.query(Measurement.station, func.count(Measurement.station)).group_by(Measurement.station).order_by(func.count(Measurement.station).desc()).all())
    dict_station = list(np.ravel(active_stations))
    return jsonify(dict_station)
# Observation page Route
@app.route("/api/v1.0/tobs")
def observations():
    top_station = 'USC00519281'
    date_obs = session.query(Measurement.date, Measurement.tobs).filter(Measurement.station == top_station).\
    filter(Measurement.date <= '2017-08-23').\
        filter(Measurement.date >= '2016-08-23').all()
    dict_obs = list(np.ravel(date_obs))
    return jsonify(dict_obs)

if __name__ == "__main__":
    app.run(debug=True)

