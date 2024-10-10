function gi=g1(x,t)
%g1 is an inequality constraint function
L=length(t);
alpha1=x(1:L);
alpha2=x(L+1:2*L);
C=81;nu=0.5;
gi=[C*nu-sum(alpha2+alpha1);alpha1;alpha2;(C/L)-alpha1;(C/L)-alpha2];