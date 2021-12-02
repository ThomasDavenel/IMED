function [ out,tab_ssd ] = recalage_rigid_transform( I,J )
p=0;
q=0;
T=[p q]; T_curr=T+1;
epsilon_pq = 0.01;

theta = 0;
theta_old = theta+1;
epsilon_theta =5* 1e-6;

tab_ssd = [];
cur_ssd = ssd(I,J);

[J_x,J_y] = grad_centre(J);
[X,Y] = ndgrid(1:size(J,1),1:size(J,2));

mini = min(I(:));
maxi = max(I(:));
figure()
cpt = 0;
while norm(T-T_curr)>0.02 && abs(theta-theta_old)>1e-8
    [R, C] = size(tab_ssd);
    if mod(cpt,50) == 0 && cpt~=0
        epsilon_theta = (epsilon_theta)/10;
    end
    
    J_rt = rigid_transformation(J,-theta,-p,-q);
    J_rtx = rigid_transformation(J_x,-theta,-p,-q);
    J_rty = rigid_transformation(J_y,-theta,-p,-q);
        
    A = -X*sin(theta)-Y*cos(theta);
    B = X*cos(theta)-Y*sin(theta);
    d_theta = 2*sum((J_rt(:)-I(:)).*(J_rtx(:).*A(:)+J_rty(:).*B(:)));
    dp = 2*sum((J_rt(:)-I(:)).*J_rtx(:));
    dq = 2*sum((J_rt(:)-I(:)).*J_rty(:));
    
    theta_old = theta;
    theta = theta - epsilon_theta*d_theta;
    
    T = [p q];
    p = p - epsilon_pq*dp;
    q = q - epsilon_pq*dq;
    T_curr = [p q];
    
    subplot(1,4,1);
    imshow(I, [mini, maxi]);
    subplot(1,4,2);
    imshow(J_rt, [mini, maxi]);
    subplot(1,4,3);
    imshow(abs(J_rt-I), [mini, maxi]);
    drawnow;
    
    cur_ssd = ssd(I,J_rt)
    tab_ssd = [tab_ssd, cur_ssd];
    
    cpt = cpt+1;
end
disp(theta);
disp(p);
disp(q);

subplot(1,4,4);
plot(0:1:C,tab_ssd);
out=J_rt;

end

