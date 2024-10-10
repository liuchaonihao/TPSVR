function [x,val,k]=NM(f,gf,x0,varargin)
% Function: NM algorithm is used to solve unconstrained problems
% Input: x0 is the initial point and fun is the objective function;
% varargin is the input variable parameter variable,
%Other programs will play an important role when calling the program in a loop
% Output: alpha, val are approximate optimal and optimal values respectively, 
%and k is the number of iterations.
maxk=5000;   %500 gives the maximum number of iterations
rho=0.55; sigma1=0.4; epsilon1=1e-5; 
k=0;   n=length(x0); 
Bk=eye(n);   %Bk=feval('Hess',x0); 
while(k<maxk)
    %gk=feval(gfun,x0,varargin{:},t,y,C,m,n,kernel,kerneloption);
    gk=feval(gf,x0,varargin{:});  
    gk_ifnan=isnan(gk);
    gk_ifinf=isinf(gk);
    Bk_ifnan=isnan(Bk);
    Bk_ifinf=isinf(Bk);
    % test termination criteria
    if(norm(gk)<epsilon1 | length(find(gk_ifnan==1))>1 |length(find(gk_ifinf==1))>1 | length(find(Bk_ifnan==1))>1 |length(find(Bk_ifinf==1))>1); break; end  
    
  % dk=-Bk\gk;  % Solve the equations and calculate the search direction
  
    dk=-pinv(Bk)*gk; % Solve the equations and calculate the search direction
    dk_ifnan=isnan(dk);
    dk_ifinf=isinf(dk);
    if(length(find(dk_ifnan==1))>1 |length(find(dk_ifinf==1))>1); break; end  % test termination criteria
% if (det(Bk)~=0)
%         dk=-inv(Bk)*gk;% Solve the equations and calculate the search direction
%         
%     else
%        dk=-pinv(Bk)*gk;  % Solve the equations and calculate the search direction
% end

    m=0; mk=0;
    while(m<28)   % Find the step size with Armijo search
       %newf=feval(fun,x0+rho^m*dk,varargin{:},t,y,C,m,n,kernel,kerneloption);

         newf=feval(f,x0+rho^m*dk,varargin{:});
%          newf=feval(fun,x0+rho^m*dk,varargin{:},t);
        oldf=feval(f,x0,varargin{:});
        if(newf<oldf+sigma1*rho^m*gk'*dk)
            mk=m; break;
        end
        m=m+1;
    end
    % correction
    x=x0+rho^mk*dk;  
    sk=x-x0;  
    yk=feval(gf,x,varargin{:})-gk;
    if(yk'*sk>0)
        m11 = sk'*Bk*sk;
        m12 = (yk'*sk);
        Bk=Bk-(Bk*sk*sk'*Bk)/(m11)+(yk*yk')/(m12);
%          Bk=Bk-(Bk*sk*sk'*Bk)/(sk'*Bk*sk)+(yk*yk')/(yk'*sk);
    end
    
    k=k+1; x0=x;
end
%val=feval(fun,x0,varargin{:},t,y,C,m,n,kernel,kerneloption); 
val=feval(f,x0,varargin{:}); 

