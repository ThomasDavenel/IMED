close all;
clear;clc
%% SANS BIAIS
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

%% AVEC BIAIS
figure(3)
subplot(1,2,1)
surf(M0(:,:,80))

subplot(1,2,2)
load('IRM_cerveau_avecbiais.mat')
surf(M0(:,:,80))

%% CORRECTION BIAIS

%on g�n�re les donn�es 
x = 1:size(test,1);
y = 1:size(test,2);
z = test(x,y);

%on affiche les donn�es
L=plot3(x,y,z,'ro'); % affiche les points (x,y,z) (donn�es)
set(L,'Markersize',2*get(L,'Markersize')) % augmente la taille des cercles
set(L,'Markerfacecolor','r') % remplit les cercles

%pause %appuyez sur une touche pour continuer

Xcolv = x(:); % on transforme en vecteur colonne
Ycolv = y(:); 
Zcolv = z(:); 
Const = ones(size(Xcolv)); %vecteur de 1 pour le terme constant

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Coefficients = [Xcolv Ycolv Const]\Zcolv; % Trouve les coefficients (moindre carr�)
%help \   -->  
%     If A is an M-by-N matrix with M < or > N and B is a column
%     vector with M components, or a matrix with several such columns,
%     then X = A\B is the solution in the least squares sense to the
%     under- or overdetermined system of equations A*X = B.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

XCoeff = Coefficients(1); % coefficient dvt le terme en X (a)
YCoeff = Coefficients(2); % coefficient dvt le terme en Y (b)
CCoeff = Coefficients(3); % terme constant (c)
% avec les variables ci-dessus on a z " � peu pr�s �gal �" XCoeff * x + YCoeff * y + CCoeff
% il s'agit du plan qui "explique" le mieux les donn�es.

% On affiche le plan pour v�rifier
hold on
[xx, yy]=meshgrid(0:.1:1,0:.1:1); % g�n�re une grille r�guli�re pour l'affichage du plan estim�
zz = XCoeff * xx + YCoeff * yy + CCoeff;
surf(xx,yy,zz) % affiche le plan donn� par l'�quation estim�e
title(sprintf('Plan z=(%f)*x+(%f)*y+(%f)',XCoeff, YCoeff, CCoeff)) %�quation du plan estim� (doit �tre proche de z=2x-5y+3)
% En tournant autour de la surface on voit que les points (x,y,z) sont "� peu pr�s" sur le plan estim�