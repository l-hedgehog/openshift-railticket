# -*- coding: utf-8 -*-

from bottle import route, default_app, request, response, template, TEMPLATE_PATH
import os, sqlite3

TEMPLATE_PATH.append(os.path.join(os.environ['OPENSHIFT_HOMEDIR'], 'runtime/repo/wsgi/views/'))
c = sqlite3.connect(os.path.join(os.getenv('OPENSHIFT_DATA_DIR'), 'tnd.db'))

@route('/info')
def info():
    station_name = request.query.sn or None
    if station_name:
        tnd = c.execute('SELECT t.time, d.division FROM tnd AS t INNER JOIN division AS d ON t.division = d.id WHERE t.station=?', (station_name,)).fetchone()
    if tnd:
        return dict(zip(('t', 'd'), tnd))
    else:
        return {}

@route('/manifest.webapp')
def manifest():
    response.set_header('Content-Type', 'application/x-web-app-manifest+json')
    return template('manifest')

@route('/')
def index():
    return template('index')

application=default_app()
