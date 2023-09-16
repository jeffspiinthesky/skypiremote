from pyskyq import remote, REMOTECOMMANDS as RCMD
from flask import Flask, flash, redirect, render_template, request, session, jsonify
import os
import time

box = os.environ["SKYQ"]

# Configure application
app = Flask(__name__, static_url_path='/static')

@app.route("/", methods=["GET", "POST"])
def remote_command():
    if request.method == "POST":
        # Get Remote code & send to Sky Box
        code = request.form.get("pressedButton")
        print(f"Code: {code}")
        remote.press_remote(box, int(code))
        return jsonify(code=code)
    else:
        return render_template("remote.html", RCMD=RCMD)

@app.route("/channels", methods=["GET", "POST"])
def channels_command():
    if request.method == "POST":
        # Get Remote code & send to Sky Box
        codestr = request.form.get("pressedButton")
        codes=codestr.split(',')
        remote.press_remote(box, 241)
        time.sleep(1)
        remote.press_remote(box, 2)
        time.sleep(1)
        for code in codes:
            remote.press_remote(box, int(code))
            time.sleep(1)
        return jsonify(code=code)
    else:
        return render_template("channels.html", RCMD=RCMD)
