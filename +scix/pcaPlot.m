function h = pcaPlot(ds,nComponents)

if ~isfield(ds.userData,'wavelengths')
    wavelengths = 1:size(ds.X,2);
else
    wavelengths = ds.userData.wavelengths;
end

pca = prtPreProcPca('nComponents',nComponents);
pca = pca.train(ds);
dsPca = pca.run(ds);
figure(1);
plot(dsPca);
title('PCA Scatter');

figure(2);
subplot(2,1,1); 
stem(pca.totalPercentVarianceCumulative);
title('Percent Total Variance Explained vs. #PCs');
subplot(2,1,2);
plot(wavelengths(:),pca.pcaVectors);
title('PCA Loadings');