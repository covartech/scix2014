function h = plsPlot(ds,nComponents)

if ~isfield(ds.userData,'wavelengths')
    wavelengths = 1:size(ds.X,2);
else
    wavelengths = ds.userData.wavelengths;
end

pls = prtPreProcPls('nComponents',nComponents);
pls = pls.train(ds);
dsPls = pls.run(ds);
figure(1);
plot(dsPls);
title('PLS Scatter');

figure(2);
plot(wavelengths(:),pls.projectionMatrix);
title('PLS Loadings');