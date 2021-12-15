clear all;
close all;
%% Partie 2

%Chargement des images fournies
load('TP2_donnees');

%Attribution de l'image Brain_MRI_1 � I et affichage
subplot(1,2,1)
I = Brain_MRI_1;
imshow(I,[]);title('Brain_MRI_1');

%Calcul et affichage de l'image J, translat�e du vecteur [p,q] par rapport
%� I
p=50;
q=50;
J = translation(I,p,q);
subplot(1,2,2)
imshow(J,[]);title('J translat�e');

%Calcul du recalage par translation de l'image J vers l'image I
[Jdecal, tab_ssd] = recalage_2D(I,J);

%% Partie 3
%La partie 3 se d�roule dans le script registration_rotation_2D.m

%% Partie 4

%Calcul de l'image J, translat�e d'un vecteur [p,q] et tourn�e d'un angle
%theta par rapport � I
p=20;
q=20;
theta =pi/12;
J = rigid_transformation(I,theta,p,q);

%Affichage de I et J
figure()
subplot(1,2,1)
imshow(I,[]);title('Brain_MRI_1');
subplot(1,2,2)
imshow(J,[]);title('J rigid transform');

%Calcul du recalage par transformation rigide de l'image J vers l'image I
[Jdecal, tab_ssd] = recalage_rigid_transform(I,J);