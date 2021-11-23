%% Test Histo

I1 = imread('I1.jpg');
subplot(1,2,1)
imshow(I1)

J1 = imread('J1.jpg');
subplot(1,2,2)
imshow(J1)

[R,C] = size(I1);
disp(R*C)

H = hist2(I1,J1);
figure()
imagesc(log(H));axis equal;axis off;axis xy;colormap jet;

nbValH = 0;
for i=1:256
    for j=1:256
        nbValH = nbValH + H(i,j);
    end
end
disp(nbValH)

%% SSD et Correllation

ssdI1J1 = ssd(I1,J1)
corI1J1 = correlation(I1,J1)