function z = zero_crossing(x)
[m,n] = size(x);
z = zeros(m,1);
for i = 1:m
    data = x(i,:);
    for j = 1:n-1
        if data(j)*data(j+1)<0 && abs(data(j)-data(j+1))>0.02
            z(i) = z(i) + 1;
        end
    end
end