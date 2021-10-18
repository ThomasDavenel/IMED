close all;
clear;clc

%% AVEC BIAIS
figure(1)
load('IRM_cerveau.mat')
subplot(1,2,1)
surf(M0(:,:,80))
subplot(1,2,2)
load('IRM_cerveau_avecbiais.mat')
surf(M0(:,:,80))