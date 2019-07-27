
clear all;
%n = importdata('/home/anuplal/projectdata/NoVM');
n=4; % vm2 to vm4
minerr = 999999999999999999999;
type = 0;
str1 = '/home/anuplal/1To_study/ProjectCasl/Experiments/vm' ;

for i = 2 : n
      
    str = num2str(i);
    minerr = 999999999999999999999;
    
    filename = strcat(str1,str);
    filename = strcat(filename,'stat');
    filename
    mrc = importdata(filename);
    mrc = [ mrc(:,1)/1024 , mrc(:,2) ] ;
    
    %linear fit
    p1 = polyfit(mrc(:,1),mrc(:,2),1);
    f = polyval(p1, mrc(:,1));
    error = sum((mrc(:,2) - f).^2);    
    if error < minerr
        minerr = error;
        type =1;
        
   
    end
    
    % quardatic fit
   p2 = polyfit(mrc(:,1),mrc(:,2),2);
    f = polyval(p2, mrc(:,1));
    
    
   mrc(:,2) - f 
    error = sum((mrc(:,2) - f).^2);    
    if error < minerr
       minerr = error;
        type =2;
      
        
    end
    
    % degree three polynomial fit
    
     p7 = polyfit(mrc(:,1),mrc(:,2),2);
    f = polyval(p7, mrc(:,1));
    
    
   mrc(:,2) - f 
    error = sum((mrc(:,2) - f).^2);    
    if error < minerr
       minerr = error;
        type =7;
      
        
    end
    
    
    
    % exponential fit with one term
    [p3,gof] = fit(mrc(:,1),mrc(:,2),'exp1');
   
    gof.sse
    if(gof.sse < minerr)
        minerr = gof.sse;
        type = 3 ;
       
         
    end
    
    %exponential fit with two term
  [p4,gof] = fit(mrc(:,1),mrc(:,2),'exp2');
  e4=gof.sse;
  e4
   if(gof.sse < minerr)
       minerr = gof.sse;
       type = 4 ;

   end %/

    % c*a^x fit
   g = fittype( @(c,a , x) c*a.^x );
    [p5,gof] = fit(mrc(:,1),mrc(:,2),g);
    e5=gof.sse;
    e5
    if(gof.sse < minerr)
        minerr = gof.sse;
        type =   5;
      
        
    end
    
    %c/x fit
     g = fittype( @(c , x) c./x );
    [p6,gof] = fit(mrc(:,1),mrc(:,2),g);
    if(gof.sse < minerr)
        minerr = gof.sse;
        type = 6 ;
         
    end
    
 
    
    
 
 outputfile = strcat(str1,str);
 outputfile = strcat(outputfile,'fit');
 outputfile = strcat(outputfile,'.txt');
 lgnd=[];
 markers={'*','o','+','x'};
 colors={'r',[0 0.55 .55],'m','c'};
 linemarkers={'-','-','-'};
 switch type
     case 1 
         DS = [1, p1];
         formatSpec = '%d %f %f \n';
        p = plot(mrc(:,1),mrc(:,2), markers{i-1},mrc(:,1),f,linemarkers{i-1});
        set(p,'Color',colors{i-1},'LineWidth',2);
       %text(mrc(1,1),mrc(2,2), 'f(x) = x^2', 'Color', 'r');
     case 2  
         DS = [2, p2];
         DS = DS';
         formatSpec = '%d %f %f %f \n';
        p= plot(mrc(:,1),mrc(:,2), markers{i-1},mrc(:,1),f,linemarkers{i-1});
         set(p,'Color',colors{i-1},'LineWidth',2);
         lgnd = [lgnd ; p ];
     case 3  
         DS = [3, p3.a, p3.b];
         formatSpec = '%d %f %f \n';
         p=  plot(p3,mrc(:,1),mrc(:,2),markers{i-1});
          set(p,'Color',colors{i-1},'LineWidth',2);
          lgnd = [lgnd ; p ];
     case 4  
         DS = [4, p4.a, p4.b, p4.c, p4.d];
         formatSpec = '%d %f %f %f %f \n';
         p = plot(p3,mrc(:,1),mrc(:,2),markers{i-1});
          set(p,'Color',colors{i-1},'LineWidth',2);
          lgnd = [lgnd ; p ];
     case 5 
         DS = [5, p5.c, p5.a];
         formatSpec = '%d %f %f \n';
         p=plot(p5,mrc(:,1),mrc(:,2),markers{i-1});
          set(p,'Color',colors{i-1},'LineWidth',2);
          lgnd = [lgnd ; p ];
     case 6  
         DS = [6, p6.c];
         formatSpec = '%d %f \n';
         p=plot(p6,mrc(:,1),mrc(:,2),markers{i-1});
         set(p,'Color',colors{i-1},'LineWidth',2);
         lgnd = [lgnd ; p ];
     case 7
         DS = [7, p7];
         p= plot(mrc(:,1),mrc(:,2), markers{i-1},mrc(:,1),f,linemarkers{i-1});
         set(p,'Color',colors{i-1},'LineWidth',2);
         lgnd = [lgnd ; p ];
 end
 ylim([0,120]);
 dlmwrite(outputfile,DS);
      % fid = fopen(outputfile,'w');
       % fprintf(fid,formatSpec,DS);

      %  fclose(fid);  
      type
      hold on;
      legend('vm1','vm1','vm2','vm2','vm3','vm3');
    
end
 xlabel('cache size (GB)');
          ylabel('miss ratio' );

