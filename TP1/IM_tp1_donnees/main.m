close all;
clear;clc

load('IRM_cerveau.mat')
test = squeeze(M0(:,:,80));
figure(1);
subplot(1,2,1)
imshow(test, []);
%coupe_cerveau(M0, 1)

[Segmentation,Seuils] = k_moyennes(test,3);

subplot(1,2,2)
imshow(Segmentation, []);

figure(2);
imagesc(Segmentation);

volumeSeg = k_moyennes_Volume(M0,1,3);
volumeSeg = smooth3(volumeSeg);
MarchingCubes(volumeSeg,1.5);