{ lib, python3, python3Packages, writeShellApplication }:
let
  pythonWithPyserial = python3.withPackages (ps: [ ps.pyserial ]);
in writeShellApplication {
  name = "sendgcode";
  runtimeInputs = [ pythonWithPyserial ];
  text = ''
#!/usr/bin/env bash
set -euo pipefail
usage(){ echo "usage: sendgcode /dev/ttyUSB0 path/to/file.gcode [--baud 115200]"; exit 1; }
[[ $# -lt 2 ]] && usage
PORT="$1"; FILE="$2"; shift 2
BAUD=115200
if [[ "''${1:-}" == "--baud" ]]; then BAUD="''${2:-}"; shift 2; fi
[[ -r "$FILE" ]] || { echo "cannot read $FILE"; exit 2; }

      "${pythonWithPyserial}/bin/python" - <<'PY' "$PORT" "$BAUD" "$FILE"
import sys, time, queue, threading, serial, os

PORT, BAUD, FILE = sys.argv[1], int(sys.argv[2]), sys.argv[3]
MAX_INFLIGHT=6          # window size
LINE_TIMEOUT=60.0       # per-line hard timeout
KEEPALIVE_EVERY=5.0     # M105 keepalive if quiet

def prep(path):
    with open(path, "r", encoding="utf-8", errors="ignore") as fh:
        for raw in fh:
            s = raw.strip()
            if not s or s.startswith(";"):
                continue
            if ";" in s: s = s.split(";",1)[0].rstrip()
            yield s

ser = serial.Serial(PORT, BAUD, timeout=0.1)
time.sleep(2.0)  # allow board reset

rxq = queue.Queue()
stop = False
def rx():
    buf = b""
    while not stop:
        b = ser.read(2048)
        if not b:
            continue
        buf += b
        while b"\n" in buf:
            ln, buf = buf.split(b"\n", 1)
            rxq.put(ln.decode(errors="ignore").strip())

t = threading.Thread(target=rx, daemon=True); t.start()

def drain_until_ok(deadline, last_rx_ref):
    while time.time() < deadline:
        try:
            m = rxq.get(timeout=0.1)
            last_rx_ref[0] = time.time()
            ml = m.lower()
            if ml.startswith("ok"):
                return True
            if "resend" in ml or "rs n:" in ml:
                # naive resend handler: abort with a clear error
                raise SystemExit("Firmware requested resend. Use a sender with line numbers+checksums.")
            # ignore temps, echoes, waits, and busy
        except queue.Empty:
            pass
    return False

# wake + quiet temp spam
for cmd in ["", "", "M110 N0", "M115", "M155 S0"]:
    ser.write((cmd + "\n").encode())

last_rx = [time.time()]
drain_until_ok(time.time()+3.0, last_rx)  # drain banner if any

lines = list(prep(FILE))
inflight = 0
i = 0
sent_times = []

while i < len(lines) or inflight > 0:
    while i < len(lines) and inflight < MAX_INFLIGHT:
        ser.write((lines[i] + "\n").encode())
        sent_times.append(time.time())
        inflight += 1
        i += 1

    if time.time() - last_rx[0] > KEEPALIVE_EVERY and inflight > 0:
        ser.write(b"M105\n")
        last_rx[0] = time.time()

    if drain_until_ok(time.time()+0.5, last_rx):
        inflight -= 1
        sent_times.pop(0)
    else:
        if inflight > 0 and (time.time() - sent_times[0]) > LINE_TIMEOUT:
            ser.write(b"M105\n")
            if not drain_until_ok(time.time()+5.0, last_rx):
                raise SystemExit("Stalled: no 'ok' within timeout")

# flush motion and release
ser.write(b"M400\n"); drain_until_ok(time.time()+10.0, last_rx)
ser.write(b"M84\n")

stop = True
t.join(timeout=0.2)
ser.close()
PY
  '';
}