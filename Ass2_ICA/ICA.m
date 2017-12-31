function [Y, Y1, Y2, X] = ICA(A, U)

no_org_sig = size(U,1);
sig_len = size(U,2);
no_mix_sig = size(A,1);
I = eye(no_org_sig);
eta = 0.1;
max_iter = 500000;

X = A*U;

W = randn(no_org_sig, no_mix_sig);
W = W./10;

for i=1:max_iter
    Y = W*X;
    if (mod(i,100000)==0)
        Y2 = Y;
    end
    if (mod(i,300000)==0)
        Y1 = Y;
    end
    Z = 1./(1.+exp(-Y));            
    dW = eta*(I + (1-2.*Z)*Y')*W;
    W = W + dW;
    if (mod(i,10000)==0)
        str = sprintf('\n Iterations: %d',i);
        disp(str);
    end
end

end