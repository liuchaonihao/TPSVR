function [x,mu,lambda,output]=multphr(f,hf,gf,df,dhf,dgf,x0,t,y,C,kernel,kerneloption)
% function: The multiplier method is used to solve general constraint problems
% Input: x0 is the initial point and fun is the objective function;
% hf is an equality constraint (vector) function;
% gf is an inequality constraint (vector) function;
% Output: x is the approximate best advantage, mu, lambda are 
%the corresponding multiplier vectors of equality constraints and inequality constraints respectively; 
%The output is a structural variable with an approximate minimum f, the number of iterations
maxk=5000;   % Maximum number of iterations
sigma=2.0;   % penalty factor
eta=2.0;  theta=0.8;  %Real parameters  
k=0; ink=0;   %k, ink is the number of external and internal iterations, respectively
epsilon=1e-5;  % Termination error value
x=x0;  he=feval(hf,x,t); gi=feval(gf,x,t);
n=length(x); l=length(he); m=length(gi);
% Selects the initial value of the multiplier vector
mu=0.1*ones(l,1);  lambda=0.1*ones(m,1);
btak=10;  btaold=10;  The % is used to test the two values of the termination condition
while(btak>epsilon & k<maxk)
    % calls the algorithm program to solve the unconstrained subproblem
    %function [alpha,val,k]=NM(fun,gfun,alpha0,varargin)
    [x,v,ik]=NM('mpsi','dmpsi',x0,f,hf,gf,df,dhf,dgf,mu,lambda,sigma,t,y,C,kernel,kerneloption);
    ink=ink+ik; 
    he=feval(hf,x,t); gi=feval(gf,x,t);
    btak=0.0;
    for (i=1:l), btak=btak+he(i)^2;   end
    for i=1:m
        temp=min(gi(i),lambda(i)/sigma);
        btak=btak+temp^2;
    end
    btak=sqrt(btak);   
    if btak>epsilon
        if(k>=2 & btak > theta*btaold)
            sigma=eta*sigma;
        end
        % updates the multiplier vector
        for (i=1:l),  mu(i)=mu(i)-sigma*he(i);  end
        for (i=1:m)
            lambda(i)=max(0.0,lambda(i)-sigma*gi(i));
        end
    end
    k=k+1;
    btaold=btak;
    x0=x;
end
% aaa=1,pause
f=feval(f,x,t,y,C,kernel,kerneloption);
output.fval=f;
output.iter=k;
output.inner_iter=ink;
output.bta=btak;
%xstar=[0.5*(sqrt(7)-1);0.25*(sqrt(7)+1)];
%err1=norm(x-xstar)
%%%%%%%%%%%%%%%%%% Augments the Lagrange function %%%%%%%%%%%%%%%%%%%%%%%%
% function psi=mpsi(x,f,hf,gf,df,dhf,dgf,mu,lambda,sigma,t,y,C,kernel,kerneloption)
% f=feval(f,x,t);  he=feval(hf,x,t);  gi=feval(gf,x,t);
% l=length(he); m=length(gi);
% psi=f;  s1=0.0;
% 
% % psi=f-sum(he.*mu)+0.5*sigma*sum(he.^2);
% % psi=psi+sum(max(0,lambda - sigma*gi).^2-lambda.^2)/(2.0*sigma);
% 
% for(i=1:l)
%     psi=psi-he(i)*mu(i);
%     s1=s1+he(i)^2;
% end
% psi=psi+0.5*sigma*s1;
% s2=0.0;
% for(i=1:m)
%     s3=max(0.0, lambda(i) - sigma*gi(i));
%     s2=s2+s3^2-lambda(i)^2;
% end
% psi=psi+s2/(2.0*sigma);
% % %%%%%%%%%%%%%%%%%% the gradient of the augments the Lagrange function %%%%%%%%%%%%%%%%%%%%%%%%
% function dpsi=dmpsi(x,f,hf,gf,df,dhf,dgf,mu,lambda,sigma,t,y,C,kernel,kerneloption)
% dpsi=feval(df,x,t,y,C,p,q,kernel,kerneloption);
% he=feval(hf,x,t);  gi=feval(gf,x,t);
% dhe=feval(dhf,x,t);  dgi=feval(dgf,x,t);
% l=length(he); m=length(gi);
% 
% % dpsi1=dpsi+(sigma*he-mu)*dhe;
% % dpsi=dpsi1+dgi*(sigma*gi-lambda);
% 
% for(i=1:l)
%     dpsi=dpsi+(sigma*he(i)-mu(i))*dhe(:,i);
% end
% for(i=1:m)
%     dpsi=dpsi+(sigma*gi(i)-lambda(i))*dgi(:,i);
% end