clear all;
clc;

C=81;nu=0.5;
load windpower;

tic;

step=11; %%%%%%%The step size of the forward expansion
Snum=1440;%%%%%%%The number of training samples
Ostep=1;%%%%%%%Predict the position of the output from the nearest data point
data=[];
datay=[];

for i=1:1:Snum    
    temp=power(i,6);
    data=[data;temp'];
    datay=[datay;power(i+step+Ostep,6)];
end
 
trainnum=round(Snum*1/2);%%%%%%% How many data are used for training and the rest for testing
temp1=data(1:trainnum,:);
temp2=datay(1:trainnum,:); 
temp3=data(trainnum+1:Snum,:);
temp4=datay(trainnum+1:Snum,:);

 kernel='poly';
 kerneloption=1;

 %kernel='jcb';
 %kerneloption=3;
 
 %kernel='polyhomog';
 %kerneloption=1;
 
%kernel='gaussian';
%kerneloption=0.01;

global L
t=temp1;
L=length(t);
y=temp2;
%objectivef=@(x)f1(x,t,y,C,m,n,kernel,kerneloption);

x0=[0.15*ones(1,L),0.15*ones(1,L)]';
%A=ones(1,2*L);b=C*nu;Aeq=[-1*ones(1,L),ones(1,L)];beq=0;
%lb=zeros(1,2*L)';ub=C*ones(1,2*L)';
[x,mu,lambda,output]=multphr('f1','h1','g1','df1','dh1','dg1',x0,t,y,C,kernel,kerneloption)

%function [ ] = sinPloyfit(NumOfsamples, Dim)

%{
for index = [1:10]
    Xtest=X(i);
    Ytest=Y(i);
    Xtrain=X( index~=i);
    Ytrain=Y( index~=i);
 %{
  x = [20:30]
index = [1:10]     % 10-fold cross-validation
i=5
xtest = x(i) 
xtrain = x(index~=i)
 %}
    Pre=f2(x,temp1,temp2,X,kernel,kerneloption);
    errorTest(inter+1) = mean(abs(Y - Pre));
end
%}
N = length(trainnum);
X = temp3;
Y = temp4;
for inter = 0:1:9
    low = inter * N / 10 + 1;
    high = low + (N / 10) - 1;
    Xtest = X(low:high);
    Ytest = Y(low:high);
    if low == 1
        Xtrain = X((high+1):N);
        Ytrain = Y((high+1):N);
    else if high == N
            Xtrain = X(1:(low-1));
            Ytrain = Y(1:(low-1));
        else
            Xtrain = X(1:(low-1));
            Xtrain = [Xtrain X((high+1):N)];
            Ytrain = Y(1:(low-1));
            Ytrain = [Ytrain Y((high+1):N)];
        end
    end
end

%mu = mean(errorTest);
%sigma = var(errorTest);
%x = 0:0.1:(2*pi);
%f = polyval(p, x);
%    Xtrain = [X(1:(low-1)) X((high+1):N)];
%    Ytrain = [X(1:(low-1)) X((high+1):N)];
    Pre=f2(x,temp1,temp2,X,kernel,kerneloption)+1.19;
    errorTest(inter+1) = mean(abs(Y - Pre));
%plot(X, Y, 'o', Xtest, Ytest, 'or', x, f, '-');
%axis([0, (2*pi), -1.5, 1.5]);

%testd=temp3;
%Pre=f2(x,temp1,temp2,testd,kernel,kerneloption)+1.5;

alpha1=x(1:L);
alpha2=x(L+1:2*L);
v=find((alpha2-alpha1)<=0.0001);
count=size(v,2);

r=1-sum((temp4-Pre).^2)/sum(temp4-(sum(temp4)/length(temp4))).^2;
e=-temp4+Pre;
mae=sum(abs(temp4-Pre))/length(temp4)
mape=sum(abs(temp4-Pre)./temp4)/length(temp4)
rmse=sqrt(sum((temp4-Pre).^2)/length(temp4))
sep=rmse/(sum(temp4)/length(temp4))


%toc
%sample_plot;
%sample_plot1;