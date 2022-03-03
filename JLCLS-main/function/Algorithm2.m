
function [model_1] = Algorithm2( X, Y, W_s,optmParameter)
% fix W solve A¡¢Q
   %% optimization parameters
    alpha            = optmParameter.alpha;
    theta            = optmParameter.theta;
    maxrho           = optmParameter.maxrho;
    p                = optmParameter.p;
    rho              = optmParameter.rho;
    maxIter2         = optmParameter.maxIter2;
    miniLossMargin   = optmParameter.minimumLossMargin;
   %% initializtion
    num_N=size(X,1);
    num_labels=size(Y,2);

    W_s_1=W_s;
    
    U_s=zeros(num_labels,num_labels);
    U_s_1=U_s;
    
    A_s=zeros(num_labels,num_labels);
    A_s_1=A_s;
   
    Q_s=zeros(size(Y,1),num_labels);
    Q_s_1=Q_s;
    
    miu1=zeros(num_N,num_labels);
    miu1_s_1=miu1;
    miu2=zeros(num_labels,num_labels);
    miu2_s_1=miu2;  
    rho_s_1=rho;
    
    iter    = 1;
    oldloss = Inf;
   %% proximal gradient
    while iter <= maxIter2
%         fprintf('\n- begin Algorithm2 %d/%d -\n',iter,maxIter2) ;
       %fix A,Q,rho,miu2 update U
       U_s_k=miu2_s_1/rho_s_1+A_s_1+alpha/(2*rho_s_1)*(W_s_1'*W_s_1);
       U_s_1=U_s_k;
       %fix U,Q,rho.miu1,miu2 update A  
       A_s_k=((2+rho_s_1)*Y'*Y+rho_s_1*eye(num_labels))\(2*Y'*X*W_s_1+rho_s_1*(Y'*Y-Y'*Q_s_1+U_s_1)+Y'*miu1_s_1-miu2_s_1);
       A_s_1=A_s_k;
       %fix U,A update Q 
       Q_s_1=Y-Y*A_s_1+(miu1_s_1)/rho_s_1;
       for i=1:num_labels
             if norm(Q_s_1(:,i),2)>theta/rho_s_1
                  Q_s_k(:,i)=((norm(Q_s_1(:,i),2)-theta/rho_s_1)/(norm(Q_s_1(:,i),2)))*Q_s_1(:,i);
             else
                  Q_s_k(:,i)=zeros(num_N,1);
             end
       end
                    Q_s_1=Q_s_k;

       %fix A,U,Q update miu1,miu2
       miu1_s_k=rho_s_1*(Y-Y*A_s_1-Q_s_1)+miu1_s_1;
       miu1_s_1=miu1_s_k;
       miu2_s_k=rho_s_1*(A_s_1-U_s_1)+miu2_s_1;
       miu2_s_1=miu2_s_k;
       %update rho
       rho_s_k=min(rho_s_1*p,maxrho);
       rho_s_1=rho_s_k;
       
        predictionLoss = trace((X*W_s_1 - Y*A_s_1)'*(X*W_s_1 - Y*A_s_1))+0.5*alpha*trace(U_s_1*W_s_1'*W_s_1)+rho_s_1*norm((Y-Y*A_s_1-Q_s_1+miu1_s_1/rho_s_1),'fro')^2;
        E21= sum(sqrt(sum(Q_s_1.*Q_s_1,2)),1);
        ParameterLoss = (-1/(2*rho_s_1))*norm((miu1_s_1),'fro')^2+(1/(2*rho_s_1))*norm((A_s_1-U_s_1+miu2_s_1/rho_s_1),'fro')^2-(1/(2*rho_s_1))*norm((miu2_s_1),'fro')^2;
        totalloss = predictionLoss + theta*E21+ParameterLoss;

        if abs(oldloss - totalloss) <= miniLossMargin

             break;
        elseif totalloss <=0

             break;
        else
             oldloss = totalloss;
        end


       iter=iter+1;
   end
       model_1.A = A_s_1;
       model_1.Q = Q_s_1;
       model_1.U = U_s_1;
end
