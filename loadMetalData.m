function ds = loadMetalData

addpath C:\Users\pete\Documents\MATLAB\repositories\libsGdt\Code\util\systemModes\OLS

str = {'NIST1256b-','NIST1259-','NIST1715-','Alumina','SigmaAl-'};
titleStr = {'NIST1256b (Al, Si, Mn, Fe)','NIST1259 (Al)','NIST1715 (Al, Mn)','Alumina (Al, Fe(?), Si)','Al'};

dataCount = 1;
for typeIndex = 1:length(str)
    for index = 1:50
        file = fullfile('C:\Users\pete\Documents\data\LIBS\metalData\metalData\',sprintf('%s%d.ols',str{typeIndex},index));
        info = libsReadOLS(file);
        x = info.data(:,1);
        inds = find(x < 261);
        x = x(inds);
        y = info.data(:,2);
        y = y(inds);
        if max(y) < 100
            y = y./max(y)*100;
        end
        
        X(dataCount,:) = y(:)';
        targets{dataCount} = str{typeIndex};
        dataCount = dataCount + 1;
    end
    
end

[y,uStrs] = prtUtilStringsToClassNumbers(targets(:));
ds = prtDataSetClass(X,y);
ds.classNames = uStrs;
ds.userData.wavelengths = x;