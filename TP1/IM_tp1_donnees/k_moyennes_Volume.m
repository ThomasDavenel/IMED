function [ irmSeg ] = coupe_cerveau( irm, coupe ,nbclasse)

irmSeg = zeros(size(irm));

if coupe==1
    disp('coronale')
    for y=1:size(irm,2)
        [irmSeg(:,y,:), seuil] = k_moyennes(squeeze(irm(:,y,:)),nbclasse);
    end
end

if coupe==2
    disp('sagittale')
    for x=1:size(irm,1)
        [irmSeg(x,:,:), seuil] = k_moyennes(squeeze(irm(x,:,:)),nbclasse);
    end
end

if coupe==3
    disp('axiale')
    for z=1:size(irm,3)
        [irmSeg(:,:,z), seuil] = k_moyennes(squeeze(irm(:,:,z)),nbclasse);
    end
end


end
