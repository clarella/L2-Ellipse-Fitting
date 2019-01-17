function COSTFinal=CostElipseGralpolarPDF_3Part2(X,obsIn,h,d,c)
D=3; %dimension
x=X(1);
y=X(2);
a=X(3);
b=X(4);
angle=X(5);
dta=18; 
n=20;
 COST2=0;

R=[cosd((angle)),sind((angle));-sind((angle)),cosd((angle))];
for i=1:n
    teta=(i-1)*(dta);
    U1=[a*cosd(teta),b*sind(teta)];
    U(i,:)=[x;y]+R*U1';
end
hgx=2*h;
%%MODELO
  [sigmaM_1,newshapeM,wmod,n1,n2,angle1]=pdfModelElipse(U,min(h,1),hgx);
  sigmaM=zeros(3,3,length(n1));
  sigmaM(1:2,1:2,:)=sigmaM_1;
    sigmaM(3,3,:)=hgx^2;
newshape=[newshapeM,(angle1)'];
%%OBSERVATION
angle2=obsIn(:,5);
% figure(102),quiver(newshapeM(1:10,1),newshapeM(1:10,2),cosd(angle1(1:10)'),sind(angle1(1:10)'))
% hold on, quiver(obsIn(1:250,1),obsIn(1:250,2),cosd(angle2(1:250)),sind(angle2(1:250)))
% figure(103), plot(angle1(1:10),'r*'),hold on, plot(angle2(1:250),'b*')
% figure(104), plot(angle2(1:250),'b*')
% pause
[SigmaOBS,wmodobs]=ComputeSigmaPart2(angle2,h,hgx,d);
obs=[obsIn(:,1:2),((angle2))];
SigmaOBSf=[SigmaOBS(1:3,1:3,:)];
sigmaMM=sigmaM(1:3,1:3,:);
COST=FunctionOptimizaElipse(double(newshape'),double(sigmaMM),double(wmod),double(newshape'),double(sigmaMM),double(wmod));
COST2=FunctionOptimizaElipse(double(obs'),double(SigmaOBSf),double(wmodobs),double(newshape'),double(sigmaMM),double(wmod));
if c==1
COSTFinal=-2*COST2;%+0.005+((X(3)-10)^2/125^2+(X(4)-20)^2/125^2);;
else 
   COSTFinal=(COST-2*COST2); 
end

function q=gaussinQ(u1,u2,S1,S2)
u=inv(inv(S1)+inv(S2))*(inv(S1)*u1+inv(S2)*u2);
q=u1'*inv(S1)*u1+u2'*inv(S2)*u2-u'*(inv(S1)+inv(S2))*u;
