function [  ] = displaySegOnMri( Seg, MRI, numSeg )

[l,w] = size(MRI); %On r?cup?re les dimensions de l'IRM
MAX = max(MRI(:)); %On r?cup?re son maximum pour la normalisation
segColor = zeros(l,w,3); %On initialise l'image ? afficher ? une image vide
for i = 1:l
    for j = 1:w
        if(Seg(i,j) == 1) %Si la segmentation vaut 1 alors on identifie en rouge le pixel consid?r? dans l'image de sortie
            segColor(i,j,1)=255;
        else              % Sinon on garde la valeur du pixel consid?r? sur l'IRM
            val = MRI(i,j)/MAX;
            segColor(i,j,1)=val;
            segColor(i,j,2)=val;
            segColor(i,j,3)=val;
        end
    end
end
%Affichage
figure()
imshow(segColor,[]);title(['IRM moyenne + Segm de la couche ',num2str(numSeg)]);
end

