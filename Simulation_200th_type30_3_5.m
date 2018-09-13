

clear all;

%max pdf is at type 3,X4=0.0945,
%Time totally spent is 2064s.



%%%%
b=0.3;
d=0.4;
lambda=1;
Kj=[];
limd=[];
Ks=sqrt(d/b)/(4*lambda^1.5*sqrt(2*pi)*(b*d)^0.25*( sqrt(b)-sqrt(d) )^2   );
for j=1:199
    Kj(j)=j*(sqrt(b/d))^j/(4*lambda^1.5*sqrt(2*pi)*b*(b*d)^0.25);
    limd(j)=Kj(j)/Ks;
end
%%%


tic;
p   = 0.3;
q   = 0.4;
lambda=1;

tfinal  = 1000;%t=50seconds
t       = 0;
X       = zeros(200,1);
X(2:200) =round(limd*100000)
Record  =zeros(10000,100);
%X(16)    = 1;
%Record(1,:)=X;
tRec=zeros(1000,1);
count=1;
%%%%create string for type name;
% strRec=cell(1,100);
% for i=1:100;
%     str1='Z';str2=num2str(i-1);
%     SC=[str1,str2];
%     strRec(i)={SC};
% end
%%%START SIMULATION
while t<tfinal
    
    sumlambda    = sum(X)*lambda;
    tau     = log(1/rand)/sumlambda;%exponentially distributed duration
    j       = min(find(rand< (cumsum(X)/sum(X))  ))-1;%which type will mutate
    x       = randReaction( p,q );%function to get whether up or down
    if j==0
        X(1)    = X(1)+1;
    else
        X(j+x+1)    = X(j+x+1)+2;%X(j+1) denote type Zj
        
        X(j+1)      = X(j+1)-1;
    end
    t = t+tau;
    count= count+1;
    realtime=toc;
    MAX=find(X==max(X(2:20)));
    fprintf('Time: %f      Count:%d  RealTime:%f    Max=%f\n',t,count,realtime,MAX);
    disp(X(1:15)');
    sumX=sum(X(2:100));
    judge1=(X(4)/sumX);
    judge2=(X(27)/sumX);
    if abs(judge1-0.0945)<0.001
        break
    end
    if count>10000000
        X=round(X/2);
        count=sum(X);
    end

%     if count<10
%         Record(count,:)=X';
%     end
%     if Record(2,1)>0
%         break;
%     end
end

beep on;
save workspace_half_100th_LIMIT_1000s_3_4.mat;
toc
