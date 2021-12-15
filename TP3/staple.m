function [W,p,q] = staple(L,eps)
% Algorithme STAPLE dans le cas binaire
% L contient les segmentations initiales
% eps (optionnel) pour le test d'arret

if (nargin<2)
    eps = 1e-7;
end

n = size(L,3); %nombre de segmentations initiales

%a priori
P0 = sum(L(:)==0)/numel(L); % Pr(T_i=0)
P1 = sum(L(:)==1)/numel(L); % Pr(T_i=1)

% initialisation
p = ones(1,n); p = p-.001; % sensibilite
q = ones(1,n); q = q-.001; % specificite


arret=0;
while(~arret)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   E-Step (on connait p et q, on met a jour W)  %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    A = P1 * ones(size(L,1),size(L,2));
    B = P0 * ones(size(L,1),size(L,2));
    
    for j = 1:n
            A(L(:,:,j)==1) = A(L(:,:,j)==1)*p(j);
            A(L(:,:,j)==0) = A(L(:,:,j)==0)*(1-p(j));
                        
            B(L(:,:,j)==1) = B(L(:,:,j)==1)*(1-q(j));
            B(L(:,:,j)==0) = B(L(:,:,j)==0)*q(j);
    end
    
    W = A./(A+B);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   M-Step (on connait W, on met a jour p et q)  %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    p_old=p;
    q_old=q;
    
    %A COMPLETER
    sumPj =ones(1,n);
    sumQj =ones(1,n);
    for j = 1:n        
        sumPj(j) = sum(W(L(:,:,j)==1));
        sumQj(j) = sum(1-W(L(:,:,j)==0));
    end
    
    p=sumPj/sum(W(:));
    q=sumQj/sum(1-W(:));
    
    % test d'arret sur la variation de p et q
    dpq = max(norm(p_old-p),norm(q_old-q));
    arret = dpq<eps;
    disp(num2str(dpq));
end