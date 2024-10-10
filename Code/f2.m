function pre_output=f2(x,t,y,testd,kernel,kerneloption)
%%%%% t is training sample %%%%% y is training sample output %%%%% testd is test sample
% f2 is the decision function

L=length(t);
alpha1=x(1:L);
alpha2=x(L+1:2*L);

K=svmkernel(t,kernel,kerneloption,t);
K=K';
alpha_m=alpha1-alpha2;
[loc_a,loc_b]=find(alpha_m~=0);

b=1/2*(y(loc_a(1))-(alpha2-alpha1)'*K(:,loc_a(1))+y(loc_a(2))-(alpha2-alpha1)'*K(:,loc_a(2))); 
%epsilon=-y(1)+(alpha2-alpha1)*K(:,1)+b;
K=svmkernel(testd,kernel,kerneloption,t);
K=K';
pre_output=K'*(alpha2-alpha1)+b;
