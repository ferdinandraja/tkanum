import cv2
import numpy as np
from tabulate import tabulate

# Load the image
img = cv2.imread('image_data_scraping.png')

# Check if the image is loaded correctly
if img is None:
    print("Error: Image could not be loaded. Please check the file path.")
    exit()

# Convert the image to grayscale
gray_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

# Threshold the image to get binary image
_, binary_img = cv2.threshold(gray_img, 128, 255, cv2.THRESH_BINARY)

# Find contours of the areas
contours, _ = cv2.findContours(binary_img, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

# Define pixel to meter conversion factor and y values
px_to_m = 2.5
y_values = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45]

# Initialize data list
data = [['t', 'xt', 'yt']]

# Function to compute x real world coordinates
def compute_x_real(y_px, x_px):
    xr = 317  # Base xr value from given data table, this should be dynamic or calculated if varying
    return (px_to_m / xr) * x_px

# Process each contour to extract data points
for idx, contour in enumerate(contours):
    # Calculate moments for each contour to find centroids
    M = cv2.moments(contour)
    if M['m00'] != 0:
        x_px = int(M['m10']/M['m00'])
        y_px = int(M['m01']/M['m00'])
        x_real = compute_x_real(y_px, x_px)
        y_real = y_values[idx % len(y_values)]  # This assumes contours are sorted in a specific order
        data.append([idx * 60, x_real, y_real])  # Assuming frames based on idx, adjust as necessary

# Print data table
print(tabulate(data, headers='firstrow'))
