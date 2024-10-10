# GL-TPSVR
1. Abstract
   
Both the classic proximal support vector regression (PSVR) and the twin support vector regression (TSVR) assume that the data is affected by a single noise characteristic distribution. However, in some low-quality data, such as wind power and photovoltaic power, it is found that the data does not obey a single noise distribution, but tends to follow a Gauss-Laplace mixed noise distribution. Therefore, based on the theoretical basis of the PSVR model combined with the TSVR model, we introduce the Gauss-Laplace mixed noise feature, and design a new regressor, called the twin proximal support vector regression with Gauss-Laplace mixed noise (GL-TPSVR). At the same time, the augmented Lagrange multiplier (ALM) method is used to solve the GL-TPSVR model.

2. Installation

Set up a Matlab environment for R2016a version

## Source

1. Dataset

You can download the dataset by referring to the URL.

https://github.com/liuchaonihao/TPSVR.git

2. Code

Run mulphrdemo.m

## Application
MATLAB Compiler

1. Prerequisites for Deployment 

. Verify the MATLAB Runtime is installed and ensure you have installed version 9.0.1 (R2016a).   

. If the MATLAB Runtime is not installed, do the following:
 
  (1) enter
  
      >>mcrinstaller
      
      At MATLAB prompt. The MCRINSTALLER command displays the location of the MATLAB Runtime installer.

  (2) run the MATLAB Runtime installer.

      Or download the Windows 64-bit version of the MATLAB Runtime for R2016a from the MathWorks Web site by navigating to http://www.mathworks.com/products/compiler/mcr/index.html
      
For more information about the MATLAB Runtime and the MATLAB Runtime installer, see Package and Distribute in the MATLAB Compiler documentation in the MathWorks Documentation Center.    


NOTE: You will need administrator rights to run MCRInstaller. 


2. Files to Deploy and Package

#######Files to package for Standalone#######

-Gui.exe
   
   -if end users are unable to download the MATLAB Runtime using the above link, include it when building your component by clicking the "Runtime downloaded from web" link in the Deployment Tool

-This readme file 

3. Definitions

For information on deployment terminology, go to http://www.mathworks.com/help. Select MATLAB Compiler >  Getting Started > About Application Deployment > Deployment Product Terms in the MathWorks Documentation Center.
