function [Segmentation,Seuils] = k_moyennes(M0,k)
Moyennes = zeros(k,1);
%initialisation des k seuils
min_M0 = min(M0(:));
max_M0 = max(M0(:));
Seuils =linspace(min_M0,max_M0,k+1);


Seuils_old = Seuils+1;

while (norm(Seuils-Seuils_old)>0) %tant que les seuils bougent
    
    
   %Mise a jour des moyennes de chaque classe 
   %faire une boucle
   for i = 1:k
    Moyennes(i) = mean(M0(M0>Seuils(i) & M0<=Seuils(i+1)));
   end
   
   Seuils_old = Seuils;
   %Mise a jour des seuils séparant chaque classe
   for i = 2:k-1
       Seuils(i) = (Moyennes(i)+Moyennes(i-1))/2;
   end
end

%Construction de la segmentation 
Segmentation = zeros(size(M0));
for i = 1:k
    Segmentation(M0>Seuils(i) & M0<=Seuils(i+1)) = i;
end
end