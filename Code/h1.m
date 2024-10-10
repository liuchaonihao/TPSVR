function he=h1(x,t)
%h1 is an equality constraint function
L=length(t);
alpha1=x(1:L);
alpha2=x(L+1:2*L);
he=sum(-alpha1+alpha2);

%{
syms i
he=symsum(x(i),1,l);
l=length(temp1);
for i=1:l
he=sum(x(i))
end
%}
