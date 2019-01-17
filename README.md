# L2-Ellipse-Fitting

 Part a)
 
 This file contains a demo of the paper: Robust Ellipse Detection With Gaussian Mixture Models
 It detect one ellipse from the images in the benchmark data set 4Occluded.mat. This data set contains 40 images.
 
 To use it, run the file [x1,xmo,COSTFinal]=EllipseFittingCA(p), where p is the number of the image in the database (from 1 to 50)
 The results are: 'x1' is the fitted ellipse, 'xmo' is the starting point (randomly selected) and 'COSTFinal', is the final value of the cost function
 
 Part b) 
 Data set used for assesing the robustness to outliers and noise of the 2D ellipse fitting 
