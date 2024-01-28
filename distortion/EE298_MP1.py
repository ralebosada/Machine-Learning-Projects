import subprocess
import sys

def install(package):
    subprocess.check_call([sys.executable, '-m', 'pip', 'install','-r', package])

install("requirements.txt")

import PySimpleGUI as sg
from PIL import Image
from matplotlib import pyplot as plt
import numpy as np
import io
import os
import cv2

file_types = [('JPEG (*.jpg)', '*.jpg'),
              ('PNG (*.png)', '*.png'),
              ('All files (*.*)', '*.*')]

def load_image(image):
    image = Image.open(image).convert('L')
    return np.array(image)

def selector(image_data):
    plt.imshow(image_data)
    coordinate = plt.ginput(4)
    return coordinate

def base_creator(coordinate):
    coordinate = np.array(coordinate)
    coordinate = np.transpose(coordinate)
    x1 = int(min(coordinate[0]))
    x2 = int(max(coordinate[0])) 
    y1 = int(min(coordinate[1]))
    y2 = int(max(coordinate[1])) 
    x2 = (x2 - x1) * 3
    y2 = (y2 - y1) * 3
    base_coordinate = [(x1,y1), (x2,y1), (x2,y2), (x1,y2)]
    return base_coordinate, x2, y2

def setting_A(coordinate,base_coordinate):
    coordinate = np.array(coordinate)
    base_coordinate = np.array(base_coordinate)
    one_matrix = np.ones((4,1))
    coordinate = np.concatenate((coordinate,one_matrix),axis = 1)
    A_matrix = np.zeros((9,9))
    b_matrix = np.zeros((9,1))
    b_matrix[8] = 1 
    j = 0
    for i in range(len(A_matrix) - 1):
        if i == len(A_matrix)-1:
            A_matrix[i,8] = 1
            continue
        if i%2 == 0:
            A_matrix[i,0:3] = -1 * coordinate[j]
            A_matrix[i,6:9] = base_coordinate[j][0] * coordinate[j]
        if i%2 != 0:
            A_matrix[i,3:6] = -1 * coordinate[j]
            A_matrix[i,6:9] = base_coordinate[j][1] * coordinate[j]
            j = j+1

    return A_matrix, b_matrix

def solving_homography(A_matrix, b_matrix):
    s,d,v = np.linalg.svd(A_matrix, full_matrices = True)
    homography = v[-1].reshape(3,3)
    return homography

                
def main():
    layout = [
        [sg.Image(key = '-IMAGE-')],
        [
            sg.Text("Image File"),
            sg.Input(size = (25,1), key = '-FILE-'),
            sg.FileBrowse(file_types = file_types),
            sg.Button("Load Image")
        ]
    ]

    window = sg.Window("Image Viewer", layout)

    while True:
        event, values = window.read()
        if event == "Exit" or event == sg.WIN_CLOSED:
            break
        if event == "Load Image":
            filename = values['-FILE-']
            if os.path.exists(filename):
                image_data = load_image(values['-FILE-'])
                coordinate = selector(image_data)
                base_coordinate, size_x, size_y = base_creator(coordinate)
                A_matrix, b_matrix = setting_A(coordinate, base_coordinate)
                homography = solving_homography(A_matrix,b_matrix)
                print(homography)
                destination_image = np.zeros((size_x,size_y))

                for i in range(1,image_data.shape[1]):
                    for j in range(1,image_data.shape[0]):
                        temp = np.array([j,i,1])
                        new_coordinate = np.matmul(homography,temp)
                        new_x = int(new_coordinate[0])
                        new_y = int(new_coordinate[1])
                        if new_x > size_x:
                            print("Error")
                        destination_image[new_x, new_y] = image_data[j,i]

    window.close()

if __name__ == "__main__":
    main()
