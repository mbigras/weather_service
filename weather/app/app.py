from flask import Flask, render_template
import socket

application = Flask(__name__)
__version__ = open('version.txt', 'r').read().rstrip()

@application.route("/")
def hello():
    return render_template("hello.html", hostname=socket.gethostname(), version=__version__)
    
if __name__ == "__main__":
    application.run(debug=True)
