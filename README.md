CoVar Code for Visualization; SCIX 2014 
==============================

The MATLAB code included here helps to generate many of the figures shown in 
Torrione, Morton, Collins, Visualizing High Dimensional Data: Techniques, Tips, and Tricks, Presented to SCI-X 2014.

Data provided:
The metal alloy data included with this ZIP file was collected by Jennifer Gottfried et al.  Any use of this data should cite
Gottfried JL. Influence of metal substrates on the detection of
explosive residues with laser-induced breakdown spectroscopy. Appl. Opt.
2012; 52 (4): B10-B19.

The HSI data plots shown here require downloading the data here:
http://engineers.missouri.edu/zarea/2013/10/muufl-gulfport-hyperspectral-and-lidar-data-collection/
(*Note the citation restrictions for that data*)

Installation:
This code requires the (free) MATLAB Pattern Recognition Toolbox, available here: https://github.com/newfolder/PRT

The M-files necessary to run the code can be added to your MATLAB path via:

% Add the PRT to the path:
addpath(fullfile(pathToPrt));
prtPath;

% Add the current directory to the path
addpath(fullfile(basePath))
addpath(fullfile(basePath,'tsne'))  %Note, the t-SNE code included here has its own license http://homepage.tudelft.nl/19j49/t-SNE.html

For example, on my computer, pathToPrt is:
C:\Users\pete\Documents\MATLAB\toolboxes\nfPrt

And basePath is:
C:\Users\pete\Documents\MATLAB\repositories\devel\scix2014

The M-file scixExampleScript.m runs most of the examples from our slides.  Note that you'll need to change the path to the HSI MAT file on line 11.

All this code is provided as-is, and without warranty of any kind.  This code is licensed for academic use, and can be redistributed freely for academic use.  

Note: the t-SNE code has its own license, which you must follow when using that code.
Note: MUUFL data distributed with this code has its own license, which you must follow when using that data.