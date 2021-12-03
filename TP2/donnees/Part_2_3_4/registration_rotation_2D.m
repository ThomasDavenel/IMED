clear;close all;clc;
load('TP2_donnees');
%J bouge

%Initialisation de l'image cible (I) et de l'image source (J)
I = Brain_MRI_1;
J = rotation(I,pi/13);

mini = min(I(:));
maxi = max(I(:));

%Initialisation de la SSD
tab_ssd = [];
cur_ssd = ssd(I,J);

epsilon = 1e-7; %Initialisation de epsilon (pas de calcul des dérivées)

theta = 0;
theta_old = theta+1; %Initialisation des valeurs theta et de theta_old (ancienne valeur et valeur courante)

[J_x,J_y] = grad_centre(J); %Calcul des gradients de l'image J
[X,Y] = ndgrid(1:size(J,1),1:size(J,2)); %Initialisation des 2 grilles à la taille de  J

%Début du traitement avec la distance à minimiser entre theta et theta_old
while(abs(theta-theta_old)>1e-7)
    J_r = rotation(J,-theta); %Calcul de la nouvelle rotation de J
    J_rx = rotation(J_x,-theta);
    J_ry = rotation(J_y,-theta); %Calcul des gradients tournés
    [R, C] = size(tab_ssd);
        
    A = -X*sin(theta)-Y*cos(theta);
    B = X*cos(theta)-Y*sin(theta); %Calcul des coefficients de la dérivée
    d_theta = 2*sum((J_r(:)-I(:)).*(J_rx(:).*A(:)+J_ry(:).*B(:))); %Calcul de la dérivée de la SSD par rapport à theta
    
    theta_old = theta; %Attribution de l'ancienne valeur de theta
    theta = theta - epsilon*d_theta; %Calcul du nouveau theta
    
    % Affichage de I et de l'évolution du recalage de J (J_r) ainsi que la
    % différence des 2
    subplot(1,4,1);
    imshow(I, [mini, maxi]);title('Brain_MRI_1');
    subplot(1,4,2);
    imshow(J_r, [mini, maxi]);title('J en recalage');
    subplot(1,4,3);
    imshow(abs(J_r-I), [mini, maxi]);title('abs(I-J_r)');
    drawnow;
    
    %Calcul de la nouvelle SSD entre I et J et ajout au tableau
    cur_ssd = ssd(I,J_r)
    tab_ssd = [tab_ssd, cur_ssd];
end
%Affichage de la valeur de theta retenue pour le recalage
disp(theta);

%Affichage de la courbe de l'évolution de la SSD
subplot(1,4,4);
plot(0:1:C,tab_ssd);title('Évolution de la SSD');