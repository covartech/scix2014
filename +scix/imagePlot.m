function h = imagePlot(ds)

if ~isfield(ds.userData,'wavelengths')
    wavelengths = 1:size(ds.X,2);
else
    wavelengths = ds.userData.wavelengths;
end

h = imagesc(ds,'x',wavelengths);