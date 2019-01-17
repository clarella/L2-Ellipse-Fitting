function observation=ProcesaImageCA(B)
d=1;scale=1;
B=imresize(B,scale);
B1 =conv2(double(B),ones(3,3));
M=edge(B,'canny');
%% To subsample and reduce timing

MM=zeros(size(M));
MM(1:d:end,1:d:end)=1;
M=M.*MM;
%%%%%%%%%%%%%%trying something
 FY = (conv2(conv2(double(B1),[1;-1],'same'),[1,1],'same'));
 FX = (conv2(conv2(double(B1),[1,-1],'same'),[1,1],'same'));
[x,y]=find(M>0);
if length(x)<1
    figure(),imshow(edge(B,'canny'))
    sum(sum(M));
     fprintf('there is no data')
    pause
end
p=1;
for i=1:length(x)
        xx(p)=x(i);
        yy(p)=y(i);
        U(p,:)=[FX(x(i),y(i)),FY(x(i),y(i))]/normaCA([FX(x(i),y(i)),FY(x(i),y(i))]);
        V1(p,:)=[U(p,2),-U(p,1)]; % vector
        V2(p,:)=[V1(p,2),-V1(p,1)]; %nornal
        tet1(p)=rad2deg(atan(((V2(p,2))/V2(p,1)))); %% angle
 if sign(V2(p,1))<0
     tet1(p)=tet1(p)+180;
 end
if (sign(V2(p,1)))>=0 & (sign(V2(p,2)))<0
     tet1(p)=tet1(p)+360;
end
if tet1(p)>360
     tet1(p)=tet1(p)-360;
 end 

    p=p+1; % in case I want to reduce the number ob observations
end
size(U)

observation=[yy',xx',V1(:,1),V1(:,2),tet1'];
% 
% size(xx)
%   figure(3),quiver(yy(1:100:900)',xx(1:100:900)',V1((1:100:900),1),V1((1:100:900),2),'b')
% hold on,quiver(yy(1:100:900)',xx(1:100:900)',V2((1:100:900),1),V2((1:100:900),2),'r')
% figure(), plot(tet1,'*')
