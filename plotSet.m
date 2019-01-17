function plotSet(x,ima)
obs=ProcesaImageCA(ima);
for i=1:size(x,1)
    hold on,PlotElipse(x(i,:))
end