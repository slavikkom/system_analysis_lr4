function Y = F_restored( X1, X2, X3 )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% Construction of polinoms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global q1 q2 q3 qY qNx p1 p2 p3 M MI Lambda A C
qNx = size(X1);
B = 0.5*ones(qNx,1); % Polinom 0 stepeni
T1 = 2*B;
T2 = 2*B;
T3 = 2*B;
for j = 1:q1
    for i = 1:p1
        T1 =[T1, 2*Pol_Chebush_Shifted(i,X1(1:qNx,j))];
    end
    if (j~=q1) 
        T1 =[T1, B];
    end
end

for j = 1:q2
    for i = 1:p2
        T2 =[T2, 2*Pol_Chebush_Shifted(i,X2(1:qNx,j))];
    end
    if (j~=q2) 
        T2 =[T2, B];
    end
end

for j = 1:q3
    for i = 1:p3
        T3 =[T3, 2*Pol_Chebush_Shifted( i,X3(1:qNx,j))];
    end
    if (j~=q3) 
        T3 =[T3, B];
    end
end    
T1 = T1/2.01;
T2 = T2/2.01;
T3 = T3/2.01;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    T1=log1p(T1);
    T2=log1p(T2);
    T3=log1p(T3);

% Construction of psi

for i=1:q1
    PSI1(:,i) = exp(T1(:,(i-1)*(p1+1)+1:i*(p1+1)) *...
                   Lambda((i-1)*(p1+1)+1:i*(p1+1)))-1;
end

for i=1:q2
    PSI2(:,i) = exp(T2(:,(i-1)*(p2+1)+1:i*(p2+1)) *...
                   Lambda( q1*(p1+1)+(i-1)*(p2+1)+1: ...
                   q1*(p1+1)+i*(p2+1)))-1;
end

for i=1:q3
    PSI3(:,i) = exp(T3(:,(i-1)*(p3+1)+1:i*(p3+1)) *...
                   Lambda( q1*(p1+1)+q2*(p2+1)+(i-1)*(p3+1)+1: ...
                   q1*(p1+1)+q2*(p2+1)+i*(p3+1)))-1;                               
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%

    PSI1=log1p(PSI1);
    PSI2=log1p(PSI2);
    PSI3=log1p(PSI3);
% Construction of fi

for i = 1:qY
    FI1(:,i) = exp(PSI1*A(1:q1,i))-1;
    FI2(:,i) = exp(PSI2*A(q1+1:q1+q2,i))-1;
    FI3(:,i) = exp(PSI3*A(q1+q2+1:q1+q2+q3,i))-1;
end

%%%%%%%%%%%%%%%%%%%%%%%%

    FI1=log1p(FI1);
    FI2=log1p(FI2);
    FI3=log1p(FI3);

% Find F
for i = 1:qY
    Fntemp(:,i) = [FI1(:,i) FI2(:,i) FI3(:,i)] * C(:,i);
    
    Fntemp=exp(Fntemp)-1;           
F(:,i) = Fntemp(:,i)* M(i)+ MI(i);
end 

Y = F;

end

