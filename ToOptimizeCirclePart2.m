function [x,xoo,COSTFinal]=ToOptimizeCirclePart2(op,obs,h,hmin,xo,d,c)
 lmin=min(obs(:,1));
  Pmin=min(obs(:,2));
   lmax=max(obs(:,1));
  Pmax=max(obs(:,2));
 dx=lmax-lmin;
 dy=Pmax-Pmin;
beta=0.6;
 h=min(h,min(dx,dy)/4);
if h<hmin
h=hmin/beta;
end
    

xoo=xo;
      while h>hmin 
          
          if op==5
     options = optimset('MaxIter',300,'Diagnostics','on','TolX',0.01,'TolFun',0.01);
    [x,COSTFinal] = fminsearch(@(x)CostElipseGralpolarPDF_3Part2(x,obs,h,d,c),xo,options); 
          else
              
                  options = optimset('MaxIter',300,'Diagnostics','on','TolX',0.0001,'TolFun',0.0001);
    [x,COSTFinal] = fminsearch(@(x)CostElipseGralpolarPDF_3Part2(x,obs,h,d,c),xo,options);  
          end
          
%    LB=[100,50,5,5,0];
%   UB=[250,250,50,50,360];
%  [x,COSTFinal] = fminsearchbnd(@(x)CostElipseGralpolarPDF_3Part2(x,obs,h,d,c),xo,LB,UB,options);
 if  x(3)<10 & x(4)<5 & COSTFinal<-1 %|| x(1)+x(3)/2>100 || x(2)+x(4)/2>100 || x(1)-x(3)/2<0 || x(2)-x(4)/2<0
    fprintf('paso por aqui tambienPART 1')
    COSTFinal=100; 
 end
h=h*beta;
xo=x;
end



function stop = myoutput(x,optimvalues,state)
        stop = false;
        dM=optimvalues.fval;
        if dM<-1
switch state
    case 'interrupt' 
          fprintf('paso por aqui')
end
      end

