from serial import Serial


class SerialCommunication:
    timer = ''
    buffer = b''
    ser = ''

    def __init__(self):
        pass

    def cancel_timer(self):
        try:
            self.timer.cancel()
        except Exception as ex:
            template = "ct: An exception of type {0} occured. Arguments:\n{1!r}"
            message = template.format(type(ex).__name__, ex.args)
            print(message)

    def open_serial(self, COM, Baud, Parity, sBits, dBits, Timeout):
        try:
            self.ser = Serial(port=COM, baudrate=Baud, parity=Parity,
                         stopbits=sBits, bytesize=dBits, timeout=Timeout)
        except Exception as ex:
            template = "op: An exception of type {0} occured. Arguments:\n{1!r}"
            message = template.format(type(ex).__name__, ex.args)
            print(message)

    def send_serial(self, data):
        try:
            if self.ser.is_open:
                s = str(data)
                chars = []
                for c in s:
                    chars.append(ord(c))
                    chars = list(map(int, chars))
                self.ser.write(chars)
                self.ser.flush()
        except Exception as ex:
            template = "ss: An exception of type {0} occured. Arguments:\n{1!r}"
            message = template.format(type(ex).__name__, ex.args)
            print(message)

    def read_serial(self, tmr, period):
        try:
            if self.ser.inWaiting() > 0:
                __stb = self.ser.read(self.ser.inWaiting())
                self.buffer += __stb
        except Exception as ex:
            template = "rs: An exception of type {0} occured. Arguments:\n{1!r}"
            message = template.format(type(ex).__name__, ex.args)
            print(message)
        if not tmr:
            return
        self.timer = threading.Timer(period, self.read_serial, [True, period])
        self.timer.start()
        return


mySer = SerialCommunication()
mySer.open_serial('COM7', 19200, 'N', 1, 8, 0)
data = '010111010001'
mySer.send_serial(data)