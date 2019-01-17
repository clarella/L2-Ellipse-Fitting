function U=PlotElipse(X)
x=X(1);
y=X(2);
a=X(3);
b=X(4);
angle=X(5);
R=[cos(deg2rad(angle)),sin(deg2rad(angle));-sin(deg2rad(angle)),cos(deg2rad(angle))];
dta=1; 
%9 grados
n=360;
%%FIRST: I determinate the set of point that represent the elipse according
%%to the input xo.yo.a and b
% figure()load x

for i=1:n
    teta=(i-1)*(dta);
    U1=[a*cosd(teta),b*sind(teta)];
    U(i,:)=[x;y]+R*U1';
end
plot(U(:,1),U(:,2),'r*')