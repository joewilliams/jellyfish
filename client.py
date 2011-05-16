import websocket
import yaml
from subprocess import call

def on_message(ws, message):
    call(["uptime"])

def on_error(ws, error):
    print error

def on_close(ws):
    print "### closed ###"

def on_open(ws):
    ws.send("open")

def conf:
    yaml.load(file("/etc/jellyfish.yml", "r"))

if __name__ == "__main__":
    websocket.enableTrace(False)
    ws = websocket.WebSocketApp("ws://localhost:8080/deploy/" + uuid,
                                on_message = on_message,
                                on_error = on_error,
                                on_close = on_close)
    ws.on_open = on_open
    ws.run_forever()
