function [x1,xmo,COSTFinal]=EllipseFittingCA(q)
%%q is the number of the image from 4Occluded that we are going to try
%%(from 1 to 50)
%%This program was made in 2019 and it replicates the algorithm in the paper
%% 'Robust ellipse fitting with GMM'
close all
load 4Occluded.mat %datase
%%Variables
% Ima : Image from 4Occluded.mat (EllipseImageCell{1,4}
% hmax; Max bandwith for the annealing strategy
hmax=20;
% hmin=1; Min Bandwith for the annealing
hmin=7;
% beta=0.6; Rate of change for the bandwith
%Starting point (ellipse) 
xo=[randi([100 200],1),randi([100 200],1),80,80,0];
d2=1;

%% Algorithm Steps
%%1) Input image and get the 3D observations
Ima=EllipseImageCell{q,4};
%Ima=mean(imread('5.jpg'),3);
obs=ProcesaImageCA(Ima);
c=2;
for i=1:5
    xo(i,:)=[randi([50 250],1),randi([50 250],1),40,50,0];
[x1(i,:),xmo(i,:),COSTFinal(i,:)]=ToOptimizeCirclePart2(5,obs,hmax,hmin,xo(i,:),d2,c);
end
[w,ww]=min(COSTFinal(i,:));
c=2;
[xf,xmo2,COSTFinal]=ToOptimizeCirclePart2(6,obs,5,1,x1(ww,:),d2,c);
% figure(99)
% plot(obs(:,1),obs(:,2),'*')
% hold on, plotSet(x1,Ima) %red (solutions)
% hold on, plotSet2(xo,Ima) %green (initial points)
%%%% 
figure(101)
plot(obs(:,1),obs(:,2),'*')
hold on, U=PlotElipse2(xmo2) %best solution from previous
hold on,U=PlotElipse(xf) %red solution

