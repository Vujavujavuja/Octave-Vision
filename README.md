# 🖼️ Custom Gaussian Image Blurring (Octave/MATLAB)

## Project Overview

This project provides a **from-scratch implementation** of a 2D Gaussian blur filter written in Octave/MATLAB script files. The primary goal is to demonstrate the manual construction of a convolution kernel and its application to an image for smoothing/blurring, without relying on built-in functions like `fspecial` or `imgaussfilt`.

The system takes an input image and a specified standard deviation ($\sigma$) to control the degree of blurring.

***

## ⚙️ Key Functions

The implementation is split into three core functions:

### 1. `domaci1v3(s)` (Main Execution)
* **Role:** Loads the image, executes the filtering, and displays the results.
* **Steps:**
    1.  Loads a test image (`testpattern1024.tif`) and converts it to `double` precision.
    2.  Calls `f_linFilt` to generate the Gaussian kernel based on the input standard deviation (`s`).
    3.  Applies the kernel to the image using the built-in 2D convolution function (`conv2(img, gf, 'same')`).
    4.  Displays the **Original Image** and the **Blurred Image** side-by-side using `subplot` and `imshow`.

### 2. `f_linFilt(n, s)` (Kernel Builder)
* **Role:** Constructs the 2D Gaussian convolution kernel (`gf`).
* **Parameters:**
    * `n`: The size of the kernel (e.g., 61x61).
    * `s`: The standard deviation ($\sigma$) of the Gaussian distribution.
* **Process:** Iterates over an $N \times N$ matrix, calculating the Gaussian value for each point based on its distance from the center. Finally, it **normalizes** the kernel by dividing all elements by their sum, ensuring the image's overall brightness remains unchanged.

### 3. `gaus(x, y, s)` (Gaussian Formula)
* **Role:** Calculates a single value of the Gaussian distribution at coordinates $(x, y)$.
* **Formula:** Implements the 2D Gaussian function:
    $$K \cdot e^{-\frac{x^2 + y^2}{2 \sigma^2}}$$
    where $K = \frac{1}{2\pi \sigma^2}$ is the normalization constant before the final kernel normalization.

***

## 🚀 Usage

1.  Ensure the image file specified in the `imread` function (`C:/Users/nvuji/Downloads/testpattern1024.tif`) is correctly located.
2.  Run the main function `domaci1v3` in your Octave or MATLAB environment, passing the desired standard deviation ($\sigma$) as the argument.

```matlab
% Example usage with a standard deviation (sigma) of 5
domaci1v3(5);
