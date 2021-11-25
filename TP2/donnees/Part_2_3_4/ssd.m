function [ sum ] = ssd( A,B )

sum = 0;
[R,C] = size(A);

for i=1:R
    for j=1:C
        sum = sum + (A(i,j)-B(i,j))*(A(i,j)-B(i,j));
    end
end
end

