from PIL import Image
import numpy as np
np.set_printoptions(formatter={'int': hex})


def gaussian_blur(array):
    kernal = np.array([
        [1, 2, 1],
        [2, 4, 2],
        [1, 2, 1]
    ], dtype=np.float64)

    kernal = kernal / np.sum(kernal)

    output = np.copy(array)

    for i in range(1, array.shape[0] - 1):

        for j in range(1, array.shape[1] - 1):

            window = array[i - 1: i + 2, j - 1: j + 2]

            out = np.sum(window * kernal)

            output[i, j] = out

    return np.array(output, dtype=np.int64)


# image = Image.open('image.jpg').convert('L')

# image = np.array(image.resize((10, 10)), np.int64)


hex_array = [0x6e, 0x89, 0x9e, 0x94, 0xa5, 0x89, 0x89, 0xbb, 0xc0, 0xc2,
             0x81, 0x88, 0x9b, 0x9b, 0x9d, 0x87, 0xbb, 0x54, 0xc2, 0xc0,
             0x81, 0x8c, 0x9b, 0x9a, 0x9a, 0xb5, 0xa4, 0x7f, 0x3c, 0xbf,
             0xa4, 0x72, 0x71, 0x7d, 0x88, 0x64, 0xc3, 0xcb, 0x75, 0xc3,
             0xb5, 0x4b, 0x61, 0x74, 0x8f, 0x31, 0x2c, 0xe6, 0x6f, 0x74,
             0x94, 0x94, 0x4b, 0x69, 0x84, 0x2b, 0x27, 0x26, 0x74, 0x85,
             0x5f, 0xa7, 0x43, 0x53, 0x62, 0x25, 0x20, 0xb0, 0x57, 0x49,
             0x59, 0x57, 0xb3, 0x99, 0x74, 0x77, 0x7f, 0x27, 0x69, 0x49,
             0xbc, 0xa3, 0x92, 0x66, 0x5c, 0x62, 0x5b, 0x44, 0x29, 0x3d,
             0x48, 0xa3, 0xa1, 0xa6, 0x2f, 0x93, 0x3e, 0x1a, 0x25, 0x2]


image = np.array(hex_array, dtype=np.int64).reshape((10, 10))

print(image)

print("\n\n")

blured_image = gaussian_blur(image)

print(blured_image)