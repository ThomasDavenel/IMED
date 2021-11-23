
I = imread('../Part_1/I1.jpg');
subplot(1,2,1)
imshow(I)

p=20.5;
q=10.2;
J = translation(I,p,q);
subplot(1,2,2)
imshow(J)