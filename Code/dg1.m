function dgi =dg1(x,t)
L=length(t);
dgi =[-ones(1,2*L);eye(2*L);-eye(2*L)]';