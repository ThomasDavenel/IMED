close all;
clear;clc

load('IRM_cerveau_avecbiais.mat')
test = squeeze(M0(:,:,80));
figure(1);
imshow(test, []);
%coupe_cerveau(M0, 1)

k_moyennes(test,2)