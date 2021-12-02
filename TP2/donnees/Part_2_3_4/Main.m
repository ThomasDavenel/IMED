clear all;
close all;
%% Partie 2

% I = imread('../Part_1/I1.jpg');

load('TP2_donnees');
subplot(1,2,1)
% imshow(I)
I = Brain_MRI_1;
imshow(I,[])
p=20.5;
q=10.2;
J = translation(I,p,q);
subplot(1,2,2)
imshow(J,[])

%[Jdecal, tab_ssd] = recalage_2D(I,J);

%% Partie 4

J = rigid_transformation(I,pi/10,1,1);
%[Jdecal, tab_ssd] = recalage_rigid_transform(I,J);