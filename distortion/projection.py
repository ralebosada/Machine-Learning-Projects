# Setting up packages in requirements.txt
import setup
setup.install('requirements.txt')


# Importing packages 
import PySimpleGUI as sg
from PIL import Image
import matplotlib.pyplot as plt
import numpy as np
import io
import os

class Projective_Distortion():
    def __init__(self, image):
        # Loading image and converting to gray scale
        self.image = np.array(Image.open(image).convert('L'))


    def selector(self):
        # Getting coordinates for quadrilateral shape
        plt.imshow(self.image)
        coordinate = plt.ginput(4)
        self.coordinate = np.array(coordinate)

    def base_creator(self):
        coordinate = np.transpose(self.coordinate)
        x, y = int(max(coordinate[0])), int(max(coordinate[1]))
        self.base_coordinate = np.array([(0,0), (x,0), (x,y), (0,y)])

    def matrix_A(self):
        
        





