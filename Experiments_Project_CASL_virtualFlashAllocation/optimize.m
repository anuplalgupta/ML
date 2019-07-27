approximate;
sizeofcache =mrc(12,1);
%n = importdata('/home/anuplal/projectdata/NoVM');
n=4; % vm2 to vm4
n
%numel(X) = n;
outputpath = '/home/anuplal/1To_study/ProjectCasl/Experiments/vm' ;
f = @(X)(0);
for i = 2 : n
    strtemp = num2str(i);
    outputfile = strcat(outputpath,strtemp);
    outputfile = strcat(outputfile,'fit');
    outputfile = strcat(outputfile,'.txt');
    outputfile
    A = importdata(outputfile);
    switch A(1)
        case 1
            f1 = @(X)(A(2)*X(i-1)+A(3));
        case 2
            f1 = @(X)(A(2)*X(i-1)^2 + A(3)*X(i-1) + A(4));
        case 3
            f1 = @(X)(A(2)*exp(A(3)*X(i-1)));
        case 4
            f1 = @(X)(A(2)*exp(A(3)*X(i-1)) + A(4)*exp(A(5)*X(i-1)));
        case 5
            f1 = @(X)(A(2)*A(3)^X(i-1));
        case 6
            f1 = @(X)(A(2)./X(i-1));
        case 7
            f1 = @(X)(A(2)*X(i-1)^3 + A(3)*X(i-1)^2 + A(4)*X(i-1) + A(4));
            
   end
 
    f = @(X) f1(X) + f(X);
    
end
x0 = ones(n-1,1);


A1 = ones(1,n-1);
A2 = eye(n-1,n-1);
A2 = -A2;
A2 = [A1;A2];
b = zeros(n-1,1);
b = -b;
b=[sizeofcache;b];
%A1

   [X,fval] = fmincon(f,x0,A2,b);
   X
   dlmwrite('/home/anuplal/1To_study/ProjectCasl/Experiments/optimalcacheSize',X);
   