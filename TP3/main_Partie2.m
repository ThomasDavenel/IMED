close all;
clear all;

%% Question1
load('TP3_donnees.mat'); %Load des donn�es fournis

[W, p, q] = staple(Segm_toy); %Appelle de la fonction de segmentation STAPLE sur l'ensemble de Segmentation Segm_toy

imshow(W); %On affiche le r�sultat de Staple