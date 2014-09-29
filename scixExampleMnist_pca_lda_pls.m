%%
dstemp = ds.retainClasses([2 3]);

pca = prtPreProcPca; pca = pca.train(dstemp);
pls = prtPreProcPls; pls = pls.train(dstemp);
lda = prtPreProcPca('nComponents',50) + prtClassLda; lda = lda.train(dstemp);

ldaOrig = lda.actionCell{1}.pcaVectors * lda.actionCell{2}.w;

subplot(2,3,1); imagesc(reshape(pca.pcaVectors(:,1),[28 28])); tickOff; title('PCA');
subplot(2,3,2); imagesc(reshape(ldaOrig,[28 28]));  tickOff; title('LDA');
subplot(2,3,3); imagesc(reshape(pls.projectionMatrix(:,1),[28 28]));  tickOff; title('PLS');

subplot(2,3,4); [pf,pd,~,a] = prtScoreRoc(pca.run(dstemp)); plot(pf{1},pd{1});
title(sprintf('PCA AUC: %.2f',a{1}));
subplot(2,3,5); [pf,pd,~,a] = prtScoreRoc(lda.run(dstemp)); plot(pf,pd);
title(sprintf('LDA AUC: %.2f',a));
subplot(2,3,6);  [pf,pd,~,a] =prtScoreRoc(pls.run(dstemp)); plot(pf{1},pd{1});
title(sprintf('PLS AUC: %.2f',a{1}));
