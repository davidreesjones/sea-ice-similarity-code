function [fig,ax] = open_figure(fnum,width,height,fontsize,linewidth,subplot_M,subplot_N)
%OPEN_FIGURE opens figure with user-specified options
%   subplot_M and subplot_N control the subplot (tiledlayout)
arguments
    fnum
    width (1,1) double = 10;
    height (1,1) double = 5;
    fontsize (1,1) int32 = 10;
    linewidth (1,1) double = 1.0;
    subplot_M (1,1) double = 1;
    subplot_N (1,1) double = 1;
end
fig=figure(fnum);
set(fig,'Units','centimeters','Position',[0 0 width height]); clf;
if subplot_M*subplot_N>1
    tiledlayout(subplot_M,subplot_N,'Padding','compact','TileSpacing','compact');
    for I=1:subplot_M*subplot_N
        nexttile
        ax{I}=gca;
        hold on;
        set(gca,'DefaultLineLineWidth',1.5,'TickLabelInterpreter','latex','defaultAxesFontSize',fontsize);
        box on;
        set(gca,'FontSize',fontsize,'LineWidth',linewidth)
    end  
else
    ax=gca;
    hold on;
    set(gca,'DefaultLineLineWidth',1.5,'TickLabelInterpreter','latex','defaultAxesFontSize',fontsize);
    box on;
    set(gca,'FontSize',fontsize,'LineWidth',linewidth)
end
    
end
