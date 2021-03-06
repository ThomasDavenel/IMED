close all;
clear all;
%% Question1
load('TP3_donnees.mat');
k = 1; %l'indice de l'image selectionn?e (entre 1 et 15)
seg = Segm_binaire(:,:,k);

%Affichage de l'IRM et de la segmentation de la couche 1
figure()
subplot(1,2,1);
imshow(IRM_T1,[]);title('IRM moyenne');
subplot(1,2,2);
imshow(seg,[]);title('Segmentation de la couche 1');

%Superposition de l'IRM et des segmentations des couches 1,10 et 15
for i=[1,10,15]
    seg = Segm_binaire(:,:,i);
    displaySegOnMri(seg,IRM_T1,i);
end

%% Question2

%Intersection des segmentations 
Inter =  prod(Segm_binaire,3);

%Union des segmentations 
Union =  sum(Segm_binaire,3);

%Affichage
figure()
subplot(1,3,1);
imshow(Inter,[0,1]);title('Intersection');
subplot(1,3,2);
imshow(Union,[0,1]);title('Union');

%% Question3
%Affichage de la m?thode majority voting
subplot(1,3,3);
maj = mode(Segm_binaire,3);
imshow(maj,[0,1]);title('Majority voting');

%Segm_4classes
figure()
maj = mode(Segm_4classes,3);
imshow(maj,[]);title('Majority voting 4 classes');

%% Question4
%Calculs des trois m?thodes d'estimation de la segmentation moyenne pour le
%nouveau volume
Inter =  prod(Segm_toy,3);
Union =  sum(Segm_toy,3);
maj = mode(Segm_toy,3);

%Affichage
figure()
subplot(1,3,1);
imshow(Inter,[0,1]);title('Intersection');

subplot(1,3,2);
imshow(Union,[0,1]);title('Union');

subplot(1,3,3);
imshow(maj,[0,1]);title('Majority voting');