function dpsi=dmpsi(x,f,hf,gf,df,dhf,dgf,mu,lambda,sigma,t,y,C,kernel,kerneloption)
dpsi=feval(df,x,t,y,C,kernel,kerneloption);
he=feval(hf,x,t); 
gi=feval(gf,x,t);
dhe=feval(dhf,x,t);  
dgi=feval(dgf,x,t);
l=length(he); m=length(gi);
% for(i=1:l)
%     dpsi=dpsi+(sigma*he(i)-mu(i))*dhe(:,i);
% end
% 
% for(i=1:m)
%     dpsi=dpsi+(sigma*gi(i)-lambda(i))*dgi(:,i);
% end

dpsi1=dpsi+(sigma*he-mu)*dhe;
dpsi=dpsi1+dgi*(sigma*gi-lambda);