clear all;
%n = importdata('/home/anuplal/projectdata/NoVM');
n=4; % vm2 to vm4
minerr = 999999999999999999999;
type = 0;
str1 = '/home/anuplal/1To_study/ProjectCasl/Experiments/vm' ;
%subplot(2,1,2);
f = @(X)(0);
for i = 2 : n
      
    str = num2str(i);
    minerr = 999999999999999999999;
    
    filename = strcat(str1,str);
    filename = strcat(filename,'stat');
    filename
    mrc = importdata(filename);
    mrc = [ mrc(:,1)/1024 , mrc(:,2) ] ;
    
    sizeofcache=mrc(12,1);
%     p1 = polyfit( mrc(:,1),mrc(:,2),size(mrc,1)/4);
%     f = polyval( p1, mrc(:,1));
% instead of cubicinter we can also use 'spline' 'smoothingspline'or 'pchipinterp' to get
% different fit
      p3=fit(mrc(:,1),mrc(:,2),'smoothingspline','SmoothingParam', 0.5);
      %p3=fit(mrc(:,1),mrc(:,2),'spline');
      %function handkle for poly5
% f1 = @(X) (p3.p1*X(i-1)^5 + p3.p2*X(i-1)^4 + p3.p3*X(i-1)^3 + p3.p4*X(i-1)^2 + p3.p5*X(i-1) + p3.p6 );
% f = @(X) f1(X) + f(X);

%funciton handle for poly2
% f1 = @(X) (p3.p1*X(i-1)^2 + p3.p2*X(i-1) + p3.p2);
% f= @(X) f1(X) + f(X);


    type=3;
  coeffs = p3.p.coefs;
  for j = 1 : 11
     f1 = @(X)(coeffs(j,1)*X(i-1)^3 + coeffs(j,2)*X(i-1)^2 + coeffs(j,3)*X(i-1) + coeffs(j,4));
      f = @(X) f1(X) + f(X);
  end
  
 outputfile = strcat(str1,str);
 outputfile = strcat(outputfile,'fit');
 outputfile = strcat(outputfile,'.txt');
 lgnd=[];
 markers={'r*','bo','m+','x'};
  colors={'r',[0 0.55 .55],'m','c'};
 linestyle={'-.','-','-'};
          %DS = [3, p3.a, p3.b];
         formatSpec = '%d %f %f \n';
         p=  plot(p3,mrc(:,1),mrc(:,2),markers{i-1});
          set(p,'Color',colors{i-1},'LineWidth',2);
          ylim([0,120]);
          xlabel('cache size (GB)');
          ylabel('miss ratio' );
          %f=f+p3;
          
          

%  dlmwrite(outputfile,DS);
      % fid = fopen(outputfile,'w');
       % fprintf(fid,formatSpec,DS);

      %  fclose(fid);  
      type
      hold on;
      legend('vm1','vm1','vm2','vm2','vm3','vm3');
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
minfval=9999999999999999999;
for k = 1: 6
    x0 = [ k, k, k];
    
   [opt,fval] = fmincon(f,x0,A2,b);
   if (fval < minfval )
       minfval = fval;
       sol = opt;
   end   
   opt
   k
end
sol


