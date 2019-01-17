function [sigmaM,newshape,wmod,V1,V2,tet1]=pdfModelElipse(U,h,ha)
%% MOdifued dec 2019
 U(end+1,:)=U(1,:);
for i=1:size(U,1)-1
   newshape(i,:)=[(U(i,:)+U(i+1,:))/2];
   V1(i,:)=((U(i+1,:))-(U(i,:)))/normaCA((U(i+1,:))-(U(i,:))); %(vector tangente)
   V2(i,:)=[V1(i,2),-V1(i,1)];
   tet1(i)=rad2deg(atan(((V2(i,2))/V2(i,1)))); %% esto me da el angulo de la tangente
 
 if sign(V2(i,1))<0
     tet1(i)=tet1(i)+180;
 end
if (sign(V2(i,1)))>=0 & (sign(V2(i,2)))<0
     tet1(i)=tet1(i)+360;
end
  
% if tet1(i)>360
%     tet1(i)=tet1-360;
% end


Q=[cosd(tet1(i)),sind(tet1(i));-sind(tet1(i)),cosd(tet1(i))]';
A=[h^2,0;0,h^2];
newSigma=Q*A*Q';
newS=zeros(3,3);
newS(1:2,1:2)=newSigma;
newS(3,3)=ha^2;
sigmaM(:,:,i)=newSigma;
wmod(i)=sqrt(((2*pi)^3)*det(newS));

end
wmod=wmod/sum(wmod);
% figure(), quiver(newshape(:,1),newshape(:,2),V1(:,1),V1(:,2),'b')
% hold on, quiver(newshape(:,1),newshape(:,2),V2(:,1),V2(:,2),'r')
% figure(), plot(tet1,'*'), hold on, plot(100*sign(V2(:,1))), hold on, plot(100*sign(V2(:,2)),'g')
% pause


