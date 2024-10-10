function  f=f1(x,t,y,C,kernel,kerneloption)
%f1 is the objective function
L=length(t);
K=svmkernel(t,kernel,kerneloption);
alpha1=x(1:L);
alpha2=x(L+1:2*L);
X1=(alpha2-alpha1)'*K*(alpha2-alpha1);
a=(alpha2-alpha1)'*y;
f=1/2*X1-a+1/(2*(C/L))*(alpha1'*alpha1+alpha2'*alpha2);