function [V1, m] = hw1FindEigendigits(trainSet)

% Finding dimensions of trainSet (x x k)
[x, k] = size(trainSet);

% Finding Mean (x x 1) 
m = mean(trainSet,2);

% Subtracting Mean (x x k)
A = trainSet;
for i=1:k
    A(:,i) = A(:,i) - uint8(m);
end

% Finding Covariance Matrix (k x k) 
A1 = double(transpose(A))*double(A);
A1 = A1/k;

% Finding Eigenvalues and EigenMatrix (k x k)
[V,D] = eig(A1);
[~, indices] = sort(diag(D), 'descend');
V = V(:, indices);

% Multiplying Eigenvectors with A1 (x x k)
V1 = zeros(x,k);
for i=1:k
    V1(:,i) = double(A)*double(V(:,i));
end

% Normalizing
V1 = normc(V1);

end
