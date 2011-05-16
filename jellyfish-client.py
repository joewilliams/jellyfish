import websocket
import yaml
import daemon
from subprocess import call

conf = yaml.load(file("/etc/jellyfish.yml", "r"))

def on_message(ws, message):
    call(conf["command"].split())

def on_error(ws, error):
    print error

def on_close(ws):
    print "### closed ###"

def on_open(ws):
    ws.send("open")

with daemon.DaemonContext():
    websocket.enableTrace(False)
    ws = websocket.WebSocketApp(("ws://" +
                                 conf["endpoint"] + "/" +
                                 conf["id"]),
                                on_message = on_message,
                                on_error = on_error,
                                on_close = on_close)
    ws.on_open = on_open
    ws.run_forever()
