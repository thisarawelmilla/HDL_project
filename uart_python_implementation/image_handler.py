from PIL import Image
import numpy as np


def convert_to_binary(img):
	v_func = np.vectorize(lambda num: np.binary_repr(num, width=8))

	return v_func(img)


image = Image.open('image.jpg').convert('L')

image = np.array(image.resize((10, 10)), np.int64)