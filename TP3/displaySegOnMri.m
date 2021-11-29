function [  ] = displaySegOnMri( Seg, MRI )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[l,w] = size(MRI);
MAX = max(MRI(:));
segColor = zeros(l,w,3);
for i = 1:l
    for j = 1:w
        if(Seg(i,j) == 1)
            segColor(i,j,1)=255;
        else
            val = MRI(i,j)/MAX;
            segColor(i,j,1)=val;
            segColor(i,j,2)=val;
            segColor(i,j,3)=val;
        end
    end
end
figure()
imshow(segColor,[]);
end

