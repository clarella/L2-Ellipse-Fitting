function plotSet2(x,ima)
obs=ProcesaImageCA(ima);
for i=1:size(x,1)
    hold on,PlotElipse2(x(i,:))
end