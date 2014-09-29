%%

close all;

addpath(fullfile(pwd,'tsne'));
prtLocation = which('prtPath'); %Check that PRT is installed:
if isempty(prtLocation)
    error('Please install the PRT and add it to your MATLAB path.  A ZIP file is available here: https://github.com/newfolder/PRT, installation instructions: http://newfolder.github.io/prtdoc/prtDocInstallation.html');
end

hsiMatFile = 'C:\Users\pete\Documents\data\MUUFLGulfportDataCollection\muufl_gulfport_campus_4.mat';
if ~exist(hsiMatFile,'file');
    error('To use the HSI MAT data, it must be downloaded from http://engineers.missouri.edu/zarea/2013/10/muufl-gulfport-hyperspectral-and-lidar-data-collection/; then change hsiMatFile to point to the correct location');
end

%ds = loadMetalData;
load sciX2014_dataSetMetalData.mat dsMetal
w = dsMetal.userData.wavelengths;

%%
dsMetal.plotAsTimeSeries([],dsMetal.userData.wavelengths)

title('Metal Alloy Data (Time-Series Plot');
xlabel('wavelength'); ylabel('Magnitude');

%%
feats = [526,723,999];
dsMetalFeat = dsMetal.retainFeatures(feats);
dsMetalFeat.featureNames = prtUtilCellPrintf('%.2f',dsMetal.userData.wavelengths(feats));
plot(dsMetalFeat)
title('3 Selected Wavelength Scatter');

%%
mu0 = [-1 -1];
mu1 = [.5 .5];
sigma1 = 4*[1 -.9; -.9 1];
sigma0 = [1 -.9; -.9 1];
ds = prtDataGenUnimodal(200,mu0,mu1,sigma0,sigma1);
title('Example Data with Uninteresting 1st PCA Loading');

%%
scix.pcaPlot(ds,3);

%%
scix.plsPlot(ds,3);

%%
tsne = prtPreProcTsne;
tsne = tsne.train(dsMetal);
dsOut = tsne.run(dsMetal);
plot(dsOut);

%% 
scix.imagePlot(dsMetal);

%%
dsEnergyNorm = rt(prtPreProcEnergyNormalizeRows,dsMetal);
scix.imagePlot(dsEnergyNorm);
title('Metal Alloy Data Image');

%%
dsZmuv = rt(prtPreProcZmuv,dsMetal);
scix.imagePlot(dsZmuv)
title('Metal Alloy Data Image');

%%

dsSmooth = dsEnergyNorm;
dsSmooth.X = imfilter(dsSmooth.X,fspecial('gaussian',[1 11],3));
scix.imagePlot(dsSmooth);

%%
dsDilate = dsEnergyNorm;
dsDilate.X = imdilate(dsDilate.X,ones(1,5));
scix.imagePlot(dsDilate);

%%
imagesc(dsHsi)

%%

load(hsiMatFile,'hsi');
dsHsi = prtDataSetClass(double(reshape(hsi.Data,[333*345],[])));
pca = prtPreProcPca;
pca = pca.train(dsHsi);
dsHsiPca = pca.run(dsHsi);

dsHsiPca = rt(prtPreProcMinMaxColumns,dsHsiPca);
dsHsiPca.X = uint8(round(255*dsHsiPca.X));
imshow(reshape(dsHsiPca.X,[333 345 3]))

