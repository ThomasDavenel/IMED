function [ out, tab_ssd ] = recalage_2D( I,J )
%J bouge
p=0;
q=0;
epsilon = 0.01;
tab_ssd = [];
cur_ssd = ssd(I,J);
T=[p q]; T_curr=T+1;

mini = min(I(:));
maxi = max(I(:));
[Jx,Jy] = grad_centre(J);
    
while norm(T-T_curr)>0.028
    J_t = translation(J,-p,-q);
    [R, C] = size(tab_ssd);
    
    fx = translation(Jx,-p,-q);
    fy = translation(Jy,-p,-q);
    
    dp = 2*sum((J_t(:)-I(:)).*fx(:));
    dq = 2*sum((J_t(:)-I(:)).*fy(:));
    T = [p q];
    p = p - epsilon*dp;
    q = q - epsilon*dq;
    T_curr = [p q];    
    
    subplot(1,4,1);
    imshow(I, [mini, maxi]);
    subplot(1,4,2);
    imshow(J_t, [mini, maxi]);
    subplot(1,4,3);
    imshow(abs(J_t-I), [mini, maxi]);
    drawnow;
    
    cur_ssd = ssd(I,J_t)
    tab_ssd = [tab_ssd, cur_ssd];
end
disp(p);
disp(q);

subplot(1,4,4);
plot(0:1:C,tab_ssd);

out = J_t;

end

