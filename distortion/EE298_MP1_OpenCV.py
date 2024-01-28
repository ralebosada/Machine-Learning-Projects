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
    return base_coordinate,x2,y2

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
                coordinate = np.array(coordinate)
                base_coordinate = np.array(base_coordinate)
                H, status = cv2.findHomography(coordinate, base_coordinate)
                im_out = cv2.warpPerspective(image_data, H, (size_x,size_y))

                cv2.imshow("Source Image", image_data)
                cv2.imshow("Warped Source Image", im_out)
                
    window.close()

if __name__ == "__main__":
    main()
