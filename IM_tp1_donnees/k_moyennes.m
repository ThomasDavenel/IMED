function [Segmentation,Seuils] = k_moyennes(M0,k)


isnan(irm)

Moyennes = zeros(k,1);

%initialisation des k seuils
min_M0 = min(M0(:))
max_M0 = max(M0(:))
Seuils =linspace(min_M0,max_M0,k+1)


Seuils_old = Seuils+1;

while (norm(Seuils-Seuils_old)>0) %tant que les seuils bougent
    
    
   %Mise a jour des moyennes de chaque classe 
   %faire une boucle
   moyennes = mean(M0(M0>Seuils1 & M0<=Seuils2));
   
   valParMoyennes = zeros(k,1);
   for i=1:size(M0,1)
       for j=1:size(M0,2)
           if isnan(M0(i,j))
               index = 1;
               s = Seuils(index);
               while(M0(i,j)>=s)
                   index = index+1;
                   s = Seuils(index);
               end
               M0(i,j)
           Moyennes(index-1) = Moyennes(index-1) + M0(i,j);
           valParMoyennes(index-1) = valParMoyennes(index-1) + 1;
           end
       end
   end
    Moyennes =  Moyennes./valParMoyennes;
   
   Seuils_old = Seuils;
   %Mise a jour des seuils s�parant chaque classe
   for i = 2:k-1
       Seuils(i) = (Moyennes(i)+Moyennes(i-1))/2;
   end
end

%Construction de la segmentation 
Segmentation = zeros(size(M0,1),size(M0,2));

for i=1:size(M0,1)
    for j=1:size(M0,2)
        index = 1;
        s = Seuils(index);
        while(s<M0(i,j))
            index = index+1;
            s = Seuils(index);
        end
        Segmentation(i,j) = Seuils(index);
    end
end
end