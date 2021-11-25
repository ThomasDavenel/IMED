function [  ] = coupe_cerveau( irm, coupe )
figure(1)
irm(isnan(irm))=0;
i=1;
if coupe==1
    disp('coronale')
    for y=1:size(irm,2)
        im = squeeze(irm(:,y,:));
        imshow(im, [])
        disp(i)
        pause;
        i=i+1;
    end
end

if coupe==2
    disp('sagittale')
    for x=1:size(irm,1)
        im = squeeze(irm(x,:,:));
        imshow(im, [])
        disp(i)
        pause;
        i=i+1;
    end
end

if coupe==3
    disp('axiale')
    for z=1:size(irm,3)
        im = squeeze(irm(:,:,z));
        imshow(im, [])
        disp(i)
        pause;
        i=i+1;
    end
end


end

