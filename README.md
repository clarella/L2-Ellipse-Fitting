# L2-Ellipse-Fitting
 
 This file contains a demo of the paper: Robust Ellipse Detection With Gaussian Mixture Models 
 
 # Abstract
 The Euclidian distance between Gaussian Mixtures has been shown to be robust to perform point set registration (Jian and Vemuri, 2011). We propose to extend this idea for robustly matching a family of shapes (ellipses). Optimisation is performed with an annealing strategy, and the search for occurrences is repeated several times to detect multiple instances of the shape of interest. We compare experimentally our approach to other state-of-the-art techniques on a benchmark database for ellipses, and demonstrate the good performance of our approach.
 
 # DataSet
  
 It uses the  4Occluded.mat benchmark data set. This set contains 50 images with 4 occluded ellipses. It is widelly used for comparing ellipse detection algorithms. 
 
 # Run Demo
 To run the algorithm use the following file: [x1,xmo,COSTFinal]=EllipseFittingCA(p)
 
 p: Number from 1 to 50 (It corresponds to the image to test in the data set 4Occluded.mat.
 x1: The resulting ellipse fitted to the data
 xmo: The starting point (randomly selected)
 COSTFinal: The final value of the cost function
 
 In the paper, this algorithm is used iterativelly to detect all the instances of the ellipse in the image.
 
 
# Paper reference
@article{ARELLANO201612,
title = "Robust ellipse detection with Gaussian mixture models",
journal = "Pattern Recognition",
volume = "58",
pages = "12 - 26",
year = "2016",
issn = "0031-3203",
doi = "https://doi.org/10.1016/j.patcog.2016.01.017",
url = "http://www.sciencedirect.com/science/article/pii/S0031320316000388",
author = "Claudia Arellano and Rozenn Dahyot",
keywords = "Ellipse detection, L2 distance, GMM, Parameter estimation",
abstract = "The Euclidian distance between Gaussian Mixtures has been shown to be robust to perform point set registration (Jian and Vemuri, 2011). We propose to extend this idea for robustly matching a family of shapes (ellipses). Optimisation is performed with an annealing strategy, and the search for occurrences is repeated several times to detect multiple instances of the shape of interest. We compare experimentally our approach to other state-of-the-art techniques on a benchmark database for ellipses, and demonstrate the good performance of our approach."
}
