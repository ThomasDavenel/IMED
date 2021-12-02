clear all;
close all;
%% Partie 2

% I = imread('../Part_1/I1.jpg');

load('TP2_donnees');
subplot(1,2,1)
% imshow(I)
I = Brain_MRI_1;
imshow(I,[])
p=50;
q=50;
J = translation(I,p,q);
subplot(1,2,2)
imshow(J,[])

%[Jdecal, tab_ssd] = recalage_2D(I,J);

%% Partie 3
%La partie 3 se déroule dans le script registration_rotation_2D.m

%% Partie 4

figure()
p=20;
q=20;
theta =pi/12;
J = rigid_transformation(I,theta,p,q);
subplot(1,2,1)
imshow(I,[])
subplot(1,2,2)
imshow(J,[])

[Jdecal, tab_ssd] = recalage_rigid_transform(I,J);