
function [sigmaMobs,wmod]=ComputeSigmaPart2(tet,h,ha,d)
Q=zeros(3,3,size(tet,1));
sigmaMobs=Q;
sigmaMobs(3,3,:)=ha^2;
A=Q(1:2,1:2,:);
A(1,1,:)=(h)^2;
A(2,2,:)=(h)^2;
Q(1,1,:)=cos(tet);
Q(1,2,:)=-sin(tet);
Q(2,1,:)=sin(tet);
Q(2,2,:)=cos(tet);
 for i=1:length(tet)
sigmaMobs(1:2,1:2,i)=Q(1:2,1:2,i)*A(:,:,i)*Q(1:2,1:2,i)';
wmod(i)=sqrt(((2*pi)^3)*det(sigmaMobs(:,:,i)));    
end
wmod=wmod/sum(wmod);

