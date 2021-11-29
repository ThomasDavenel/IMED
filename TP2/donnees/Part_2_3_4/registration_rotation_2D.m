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

epsilon = 1e-7;

theta = 0;
theta_old = theta+1;

[J_x,J_y] = grad_centre(J);
[X,Y] = ndgrid(1:size(J,1),1:size(J,2));
%pause;

while(abs(theta-theta_old)>1e-7)
    J_r = rotation(J,-theta);
    J_rx = rotation(J_x,-theta);
    J_ry = rotation(J_y,-theta);
    [R, C] = size(tab_ssd);
        
    A = -X*sin(theta)-Y*cos(theta);
    B = X*cos(theta)-Y*sin(theta);
    d_theta = 2*sum((J_r(:)-I(:)).*(J_rx(:).*A(:)+J_ry(:).*B(:)));
    
    theta_old = theta;
    theta = theta - epsilon*d_theta;
    
    subplot(1,4,1);
    imshow(I, [mini, maxi]);
    subplot(1,4,2);
    imshow(J_r, [mini, maxi]);
    subplot(1,4,3);
    imshow(abs(J_r-I), [mini, maxi]);
    drawnow;
    
    cur_ssd = ssd(I,J_r)
    tab_ssd = [tab_ssd, cur_ssd];
end

subplot(1,4,4);
plot(0:1:C,tab_ssd);