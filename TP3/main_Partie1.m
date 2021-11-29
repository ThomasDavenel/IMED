close all;
clear all;
%% Question1
load('TP3_donnees.mat');
k = 1; %l'indice de l'image selectionnée (entre 1 et 15)
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
Inter =  prod(Segm_binaire,3);
Union =  sum(Segm_binaire,3);

figure()
subplot(1,3,1);
imshow(Inter,[]);
subplot(1,3,2);
imshow(Union,[0,1]);

%%Question3
subplot(1,3,3);
maj = mode(Segm_binaire,3);
imshow(maj,[]);

%Segm_4classes
figure()
maj = mode(Segm_4classes,3);
imshow(maj,[]);

%%Question4
Inter =  prod(Segm_toy,3);
Union =  sum(Segm_toy,3);
maj = mode(Segm_toy,3);

figure()
subplot(1,3,1);
imshow(Inter,[]);

subplot(1,3,2);
imshow(Union,[0,1]);

subplot(1,3,3);
imshow(maj,[]);