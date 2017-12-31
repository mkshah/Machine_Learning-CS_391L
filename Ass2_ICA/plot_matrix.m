function [] = plot_matrix(Y)

[m,~] = size(Y);
figure;

for i=1:m
    r = Y(i,:);
    min1 = min(r);
    r = r - min1;
    max1 = max(r);
    r = r ./ max1;
    subplot(m,1,i);
    plot(r);
end

end