function [model_JLCLS] = JLCLS( X, Y, optmParameter)
% Alternating iterative solution W¡¢A¡¢Q  ||XW-YA||F2+0.5*alphatrace(AW'W)+0.5*beta||W||L1+theta||Q||L2,1
   %% optimization parameters
    alpha            = optmParameter.alpha;
    gamma            = optmParameter.gamma;

    beta             = optmParameter.beta;

    maxIter          = optmParameter.maxIter;

    epsilon          = optmParameter.epsilon;
   %% initializtion
    num_dim= size(X,2);
    num_labels=size(Y,2);

    XTX = X'*X;
    XTY = X'*Y;
    
    A_s   =  eye(num_labels);
    A_s_1 =A_s;
    

    iter    = 1;
    bk = 1;
    bk_1 = 1; 

   %% proximal gradient
    while iter <= maxIter
    %%fix A and Q solve W
  
        norm_1=norm(XTX)^2; 
        W_s   = (XTX + gamma*eye(num_dim)) \ (XTY*A_s_1);
        W_s_1 = W_s;
        Lip = sqrt(2*(norm_1) + norm(alpha*A_s_1)^2+norm(alpha*A_s_1')^2);


       W_s_k  = W_s + (bk_1 - 1)/bk * (W_s - W_s_1);
       
       Gw_s_k = W_s_k - 1/Lip * ((XTX*W_s_k - XTY*A_s_1) + 0.5*alpha*W_s_k*A_s_1+0.5*alpha*W_s_k*A_s_1');
       bk_1   = bk;
       bk     = (1 + sqrt(4*bk^2 + 1))/2;
       W_s    = softthres(Gw_s_k,beta/Lip);
       
       [model_1] = Algorithm2( X, Y, W_s,optmParameter);
       A_s_1=model_1.A;
       Q_s_1=model_1.Q;
       U_s_1=model_1.U;
       T=Y-Y*A_s_1-Q_s_1;N=U_s_1-A_s_1;
        if norm(T,'inf')<epsilon&&norm(N,'inf')<epsilon

            break;
        elseif  iter >= maxIter

            break;       
        end


%        if abs(oldloss - totalloss) <= miniLossMargin
% 
%            break;
%        elseif totalloss <=0
%            break;
%        else
%            oldloss = totalloss;
%        end
       if iter>maxIter

       end
       iter=iter+1; 
    end

      model_JLCLS.W=W_s;
      model_JLCLS.A=A_s_1;

end

%% soft thresholding operator
function W = softthres(W_t,lambda)
    W = max(W_t-lambda,0) - max(-W_t-lambda,0); 
end
