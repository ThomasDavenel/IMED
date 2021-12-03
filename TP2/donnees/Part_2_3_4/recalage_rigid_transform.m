function [ out,tab_ssd ] = recalage_rigid_transform( I,J )
 %Initialisation des valeurs de p et q
p=0;
q=0;

T=[p q]; T_curr=T+1; %Initialisation pour le cas d'arret

epsilon_pq = 0.005; %Initialisation de epsilon pour p et q(pas de calcul des dérivées)

theta = 0;
theta_old = theta+1;
epsilon_theta =5* 1e-6; %Initialisation de epsilon pour theta et q(pas de calcul des dérivées)

tab_ssd = [];
cur_ssd = ssd(I,J); %Initialisation pour le cas d'arret

[J_x,J_y] = grad_centre(J); %Calcul des gradients de l'image J
[X,Y] = ndgrid(1:size(J,1),1:size(J,2)); %Initialisation de deux grilles a la tailler de J

mini = min(I(:));
maxi = max(I(:));%Calcul des valeurs extrèmes de I pour affichage

figure()
cpt = 0;
while (norm(T-T_curr)>0.03 || abs(theta-theta_old)>5*1e-5) %double cas d'arret qui reprend la structure des deux descente de gradient précédentes.
    [R, C] = size(tab_ssd);
    
    %{
    On commence ici avec un epsilon plus concéquent qu'on décrémente
    fortement et rapidement. On fait cela car la rotation modifie plus les
    pixels de l'image que la translation. Ce paramètre est a changer en
    fonction de l'a priori que l'on a sur la rotation qu'a subit l'image J.
    %}
    if mod(cpt,8) == 0 && cpt~=0 && cpt<17
        epsilon_theta = (epsilon_theta)/20;
    end
    
    J_rt = rigid_transformation(J,-theta,-p,-q);%Calcul de la nouvelle transformation rigide de J
    J_rtx = rigid_transformation(J_x,-theta,-p,-q);
    J_rty = rigid_transformation(J_y,-theta,-p,-q); %Calcul de la nouvelle transformation rigide des gradients
        
    A = -X*sin(theta)-Y*cos(theta);
    B = X*cos(theta)-Y*sin(theta);
    d_theta = 2*sum((J_rt(:)-I(:)).*(J_rtx(:).*A(:)+J_rty(:).*B(:)));%Calcul des dérivées de la SSD par rapport à theta
    
    dp = 2*sum((J_rt(:)-I(:)).*J_rtx(:));
    dq = 2*sum((J_rt(:)-I(:)).*J_rty(:));%Calcul des dérivées de la SSD par rapport à p et q
    
    theta_old = theta;
    theta = theta - epsilon_theta*d_theta;
    
    T = [p q];
    p = p - epsilon_pq*dp;
    q = q - epsilon_pq*dq;
    T_curr = [p q];
    
    % Affichage de I et de l'évolution du recalage de J (J_t) ainsi que la
    % différence des 2
    subplot(1,4,1);
    imshow(I, [mini, maxi]);title('Brain_MRI_1');
    subplot(1,4,2);
    imshow(J_rt, [mini, maxi]);title('J en recalage');
    subplot(1,4,3);
    imshow(abs(J_rt-I), [mini, maxi]);title('abs(I-J_rt)');
    drawnow;
    
    %Calcul de la nouvelle SSD entre I et J et ajout au tableau
    cur_ssd = ssd(I,J_rt)
    tab_ssd = [tab_ssd, cur_ssd];
    
    cpt = cpt+1;
end
%Affichage des valeurs de p, q et theta retenues pour le recalage
disp(theta);
disp(p);
disp(q);

%Affichage de la courbe de l'évolution de la SSD
subplot(1,4,4);
plot(0:1:C,tab_ssd);title('Évolution de la SSD');

%On retourne l'image recaléée
out=J_rt;

end

