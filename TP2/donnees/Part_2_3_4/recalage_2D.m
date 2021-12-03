function [ out, tab_ssd ] = recalage_2D( I,J )
%J bouge
p=0;
q=0; %Initialisation des valeurs de p et q
epsilon = 0.005; %Initialisation de epsilon (pas de calcul des d�riv�es)
tab_ssd = []; %Initialisation du tableau des valeurs de la SSD
cur_ssd = ssd(I,J); %Initialisation de la premi�re valeur de la SSD

T=[p q]; T_curr=T+1; %Initialisation des [p,q] pr�c�dent et courant 

mini = min(I(:));
maxi = max(I(:)); %Calcul des valeurs extr�mes de I pour affichage

[Jx,Jy] = grad_centre(J); %Calcul des gradients de l'image J
figure()
%D�but du traitement avec la distance � minimiser entre T et T_curr
while norm(T-T_curr)>0.03
    J_t = translation(J,-p,-q); %Calcul de la nouvelle translation de J
    [R, C] = size(tab_ssd);
    
    fx = translation(Jx,-p,-q); 
    fy = translation(Jy,-p,-q); %Calcul des gradients translat�s
    
    dp = 2*sum((J_t(:)-I(:)).*fx(:));
    dq = 2*sum((J_t(:)-I(:)).*fy(:)); %Calcul des d�riv�es de la SSD par rapport � p et q
    
    %{
        - Attribution des valeurs de p et q � T (anciennes valeurs)
        - Calculs des nouveaux p et q
        - Attribution des valeurs de p et q � T_curr (valeurs courantes)
    %}
    T = [p q];
    p = p - epsilon*dp;
    q = q - epsilon*dq;
    T_curr = [p q];    
    
    % Affichage de I et de l'�volution du recalage de J (J_t) ainsi que la
    % diff�rence des 2
    subplot(1,4,1);
    imshow(I, [mini, maxi]);
    subplot(1,4,2);
    imshow(J_t, [mini, maxi]);
    subplot(1,4,3);
    imshow(abs(J_t-I), [mini, maxi]);
    drawnow;
    
    %Calcul de la nouvelle SSD entre I et J et ajout au tableau
    cur_ssd = ssd(I,J_t)
    tab_ssd = [tab_ssd, cur_ssd];
end
%Affichage des valeurs de p et q retenues pour le recalage
disp(p);
disp(q);

%Affichage de la courbe de l'�volution de la SSD
subplot(1,4,4);
plot(0:1:C,tab_ssd);

%On retourne l'image recal�e
out = J_t;

end

