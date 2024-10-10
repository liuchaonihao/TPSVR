function dhe=dh1(x,t)
%dh is the transpose of the Jacobi matrix of the equationally constrained (vector) function
L=length(t);
dhe=[-ones(1,L),ones(1,L)]';