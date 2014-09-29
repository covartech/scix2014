% 
% scanDir = 'C:\Users\pete\Documents\data\LIBS\materialytics\Tourmaline Data - 2011\';
% scanList = prtUtilSubDir(scanDir,'*.scan');
% 
% dataStruct =  readMaterialyticsScan(scanList{1});
% for i = 1:length(scanList);
%     % % Necessary to fix weirdness in Materialytics files
%     %     fid = fopen(scanList{i});
%     %     s = fscanf(fid,'%c');
%     %     fclose(fid);
%     %     index = find(s(:) == '>',1,'last');
%     %     s = s(1:index);
%     %     fid = fopen(scanList{i},'w');
%     %     fprintf(fid,'%c',s);
%     %     fclose(fid);
%     
%     dataStruct(i) = readMaterialyticsScan(scanList{i});
% %     data(i).w = w; data(i).n = n;
%     disp(i)
% end
% 
% s = arrayfun(@(s)length(s.n),dataStruct);
% retain = s == 40002;
% dataStruct = dataStruct(retain);

% %%
% close all;
% x = cat(1,dataStruct.n);
% w = dataStruct.w;
% for i = 1:length(dataStruct);
%     pp = pathParts(dataStruct(i).dataFile);
%     str{i} = pp{end-1};
% end
% [y,ustrs] = prtUtilStringsToClassNumbers(str(:));
% ds = prtDataSetClass(x,y);
% ds.classNames = ustrs;
% ds.userData.wavelengths = w;
load C:\Users\pete\Documents\data\LIBS\materialytics\tourmalineData2011.mat ds

dsEnergy = rt(prtPreProcEnergyNormalizeRows,ds);
imagesc(dsEnergy,'x',ds.userData.wavelengths);
title('Tourmaline Data Imaged');
xlabel('Wavelength');

%%
imagesc(rt(prtPreProcZmuv,dsEnergy),'x',ds.userData.wavelengths,'clim',[-5 5]);

%%
imagesc(dsEnergy,'x',ds.userData.wavelengths,'clim',[0 .02]);
title('Tourmaline Data Zoom, High Contrast');
xlabel('Wavelength');
axis([219.2562  380.0190   90.0994  209.3039]);

%%
plot(rt(prtPreProcPca('nComponents',2),dsEnergy));
title('Tourmaline 2-PCA Scatter');

%%
tsne = prtPreProcTsne;
tsne = tsne.train(dsEnergy);
dsTsne = tsne.run(dsEnergy);
plot(dsTsne);
title('Tourmaline t-SNE Scatter');