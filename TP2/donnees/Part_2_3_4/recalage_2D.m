function [ out, tab_ssd ] = recalage_2D( I,J )
%J bouge
[fx,fy] = grad_centre(I);
p=0;
q=0;
tab_ssd = [];
cur_ssd = ssd(I,J);
subplot(1,2,1);
imshow(I);
while cur_ssd > 100
    tmp1 = (I-J).*fx;
    dp = 2*sum(tmp1(:));
    tmp2 = (I-J).*fy;
    dq = 2*sum(tmp2(:));
    p = p - dp;
    q = q - dq;
    J = translation(J,p,q);
    subplot(1,2,2);
    imshow(J);
    pause;
    cur_ssd = ssd(I,J);
    tab_ssd = tab_ssd + [cur_ssd];
    disp(cur_ssd)
end
out = J;

end

