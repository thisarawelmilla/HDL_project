import serial
import io
import time
from PIL import Image
import numpy as np

IMAGE_PATH = "image.jpg"
IMAGE_SIZE = 10


# create serial connection
ser = serial.Serial()
ser.baudrate = 9600
ser.port = 'COM14'
ser.open()


# create image array
image = Image.open(IMAGE_PATH, mode='r')
image = image.convert(mode='L')
image = np.array(image.resize((IMAGE_SIZE, IMAGE_SIZE)), np.int64)
image = np.array(image)
image = image.flatten()

# send pixels as byte
for i in range(len(image)):
	ser.write(bytes([image[i]]))

# receive filtered image
received_image = []

for i in range(IMAGE_SIZE ** 2):
	pixel_byte = ser.read(1)
	received_image.append(int.from_bytes(pixel_byte, "big"))

# show received image
received_image = np.array(received_image)
received_image = np.resize(received_image, (IMAGE_SIZE, IMAGE_SIZE))
image = Image.fromarray(received_image)
image.show()