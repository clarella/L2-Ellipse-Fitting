%to make the covariance matrices of the observation
function [sigmaMobs,wmod]=ComputeSigma(grx,gry,h,ha,d)
% length(grx)
% pause

tet=(atan2(grx,gry))';
Q=zeros(3,3,size(grx,1));
sigmaMobs=Q;
sigmaMobs(3,3,:)=ha^2;
A=Q(1:2,1:2,:);
A(1,1,:)=(h)^2;
A(2,2,:)=(max(5*d,h))^2;%*(1+d*abs(gry));
% A(1,1,:)=h^2*(1+abs(grx));
% A(2,2,:)=h^2*(1+abs(gry));
Q(1,1,:)=cos(tet);
Q(1,2,:)=-sin(tet);
Q(2,1,:)=sin(tet);
Q(2,2,:)=cos(tet);
% size(Q(1:2,1:2,:))
% size(tet)
% size([cos(tet),-sin(tet);sin(tet),cos(tet)])
% Q(1:2,1:2,:)=[cos(tet),-sin(tet);sin(tet),cos(tet)];
 for i=1:length(grx)
%      if grx(i)==0 || gry(i)==0
%     newSigma=h^2*eye(2);     
%          
%      else
% 
% A=(h)^2*[1+abs(grx(i)),0;0,1+abs(gry(i))];
% Q=[cos(tet),sin(tet);-sin(tet),cos(tet)]';
sigmaMobs(1:2,1:2,i)=Q(1:2,1:2,i)*A(:,:,i)*Q(1:2,1:2,i)';
%      end
% sigmaMobs(:,:,i)=newSigma;
% newS=zeros(3,3);
% newS(1:2,1:2)=newSigma;
% newS(3,3)=ha^2;
wmod(i)=sqrt(((2*pi)^3)*det(sigmaMobs(:,:,i)));
     
end
wmod=wmod/sum(wmod);

% tic
% %%%%%%%%%%%%%%%%%%%%
% tet=atan2(grx,gry);

% QQ(1,1,:)=cos(tet);
% QQ(1,2,:)=-sin(tet);
% QQ(2,1,:)=sin(tet);
% QQ(2,2,:)=cos(tet);
% newSigma=Q.*A.*Q';
% toc
