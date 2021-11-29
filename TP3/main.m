close all;
clear all;
%% PARTIE 1

%%Question1
load('TP3_donnees.mat');
k = 1;
seg = Segm_binaire(:,:,k);

figure()
subplot(1,2,1);
imshow(IRM_T1,[]);
subplot(1,2,2);
imshow(seg,[]);

displaySegOnMri(seg,IRM_T1);

%%Question2
%Intersection des segmentations 
%Union des segmentations 
Inter =  Segm_binaire(:,:,1);
Union =  Segm_binaire(:,:,1);
for i = 2:15
    Inter(Segm_binaire(:,:,i) == 0) = 0;
    Union(Segm_binaire(:,:,i) == 1) = 1;
end

figure()
subplot(1,2,1);
imshow(Inter,[]);
subplot(1,2,2);
imshow(Union,[]);

%%Question3
