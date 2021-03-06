%% Test Histo

%Initialisation et affichage de I1
I1 = imread('I1.jpg');
subplot(1,2,1)
imshow(I1);title('I1');

%Initialisation et affichage de J1
J1 = imread('J1.jpg');
subplot(1,2,2)
imshow(J1);title('J1');

%On r?cup?re et affiche les dimensions de I1
[R,C] = size(I1);
disp(R*C)

%On calcule l'histogramme joint entre I1 et J1
H = hist2(I1,J1);
figure()
imagesc(log(H));title('Histogramme joint');axis equal;axis off;axis xy;colormap jet;

%On calcule le nombre de valeurs dans l'histogramme
nbValH = 0;
for i=1:256
    for j=1:256
        nbValH = nbValH + H(i,j);
    end
end
%On affiche le nombre de valeurs de l'histogramme pour le comparer
%aux dimensions de l'image
disp(nbValH)

%% SSD et Correllation

%Calcul de la SSD et du coefficient de corr?lation
%entre les images I1 et J1
ssdI1J1 = ssd(I1,J1)
corI1J1 = correlation(I1,J1)

%% Information mutuelle

%Calcul et affichage de l'information mutuelle entre I1 et J1
IM = mutual_information(H)