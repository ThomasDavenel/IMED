close all;
clear all;

%% Question1
load('TP3_donnees.mat');

[W, p, q] = staple(Segm_toy);

imshow(W);