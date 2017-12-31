function [A] = mix_sig(U, n)

[m,~] = size(U);
A = randn(n,m)./10;

end