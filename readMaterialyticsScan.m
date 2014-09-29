function dataStruct = readMaterialyticsScan(scanFile)

[p,f] = fileparts(scanFile);
newFile = fullfile(p,[f,'.ma.mat']);
w = [];
n = [];
if ~exist(newFile);
    s = xml2struct(scanFile);
    cc = cat(1,s.Children(4).Children);
    w = str2num(cc(68).Children.Data);
    n = str2num(cc(70).Children.Data);
    save(newFile,'w','n');
else
    load(newFile,'w','n');
end
dataStruct.w = w(:)';
dataStruct.n = n(:)';
dataStruct.dataFile = scanFile;