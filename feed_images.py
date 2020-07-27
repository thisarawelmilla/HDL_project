import cv2
import base64
import numpy as np


def create_buffer(img_path, img_shape):
    img = cv2.imread(img_path)
    resized_img = cv2.resize(img, img_shape)
    gray_img = cv2.cvtColor(resized_img, cv2.COLOR_BGR2GRAY)
    
    buf = np.array([])
    for i in gray_img:
        buf = np.concatenate((buf, i), axis=None)

    print (len(buf))
    return buf


def write_hex_img(img_path, buf):
    string = ''
    for i in buf:
        string += str(hex(int(i)))[2:] + ','

    file = open(img_path, 'w')
    file.write(string[:-2])
    file.close()



buf = create_buffer('/home/thisara/Documents/sem 7/Hardware Description Languages/project/toyL.png', (10, 10))
write_hex_img('img.hex', buf)
