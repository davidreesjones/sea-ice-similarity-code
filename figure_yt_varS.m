%% Plot thickness (squared) variation with time dependent salinity
par_dim_init
par = par_non_dim_init(ks,kl,cs,cl,L,TB,Tl,C0,S0,m);

tmax=20;
tplot=linspace(0,tmax,1e3);
S1=0.9; % fixed salinity example 1
S2=0.1; % fixed salinity example 2
par.S_rel=S2;
sol_y = y_evolve(par,tmax);
y_S2=deval(sol_y,tplot);
par.S_rel=S1;
sol_y = y_evolve(par,tmax);
y_S1=deval(sol_y,tplot);

% time dependent salinity calculations with various relaxation timescales
td=1;
sol_y = y_evolve(par,tmax,@(t) 0 ,@(t) S2+(S1-S2)*exp(-t/td));
y_td1=deval(sol_y,tplot);
td=10;
sol_y = y_evolve(par,tmax,@(t) 0 ,@(t) S2+(S1-S2)*exp(-t/td));
y_td10=deval(sol_y,tplot);
td=100;
sol_y = y_evolve(par,tmax,@(t) 0 ,@(t) S2+(S1-S2)*exp(-t/td));
y_td100=deval(sol_y,tplot);
td=1000;
sol_y = y_evolve(par,tmax,@(t) 0 ,@(t) S2+(S1-S2)*exp(-t/td));
y_td1000=deval(sol_y,tplot);

[fig,ax] = open_figure(fnum,single_col_width_large,single_col_height_large,fontsize);

xlab=xlabel('$\tau$','interpreter','latex');
ylab=ylabel('$\hat{y}$','interpreter','latex','Rotation',0);
set(gca,'XLim',[0 tmax],'YLim',[0 5],'YTick',0:1:5)

ax_inset=axes(fig);
ax_inset.Position=[.45 .2 .4 .3];
hold on;
set(gca,'DefaultLineLineWidth',1.5,'TickLabelInterpreter','latex','defaultAxesFontSize',fontsize);
box on;
set(gca,'FontSize',fontsize,'LineWidth',linewidth)

for nplot=1:2
    switch nplot
        case 1
            axes(ax)
        case 2
            axes(ax_inset)
    end

td=1;
plot(tplot,y_td1,'DisplayName',['$\tau_d=',num2str(td),'$'],'Color',newcolors(1,:),'LineWidth',linewidth)

td=10;
plot(tplot,y_td10,'DisplayName',['$\tau_d=',num2str(td),'$'],'Color',newcolors(2,:),'LineWidth',linewidth)

td=100;
plot(tplot,y_td100,'DisplayName',['$\tau_d=',num2str(td),'$'],'Color',newcolors(3,:),'LineWidth',linewidth)

td=1000;
plot(tplot,y_td1000,'DisplayName',['$\tau_d=',num2str(td),'$'],'Color',newcolors(3,:)/2,'LineWidth',linewidth)
    
plot(tplot,y_S2,'--k','DisplayName',['$\hat{S}=',num2str(S2),'$'],'LineWidth',linewidth)
plot(tplot,y_S1,'-.k','DisplayName',['$\hat{S}=',num2str(S1),'$'],'LineWidth',linewidth)

end
set(ax,'XLim',[0 20],'YLim',[0 4.3]);
set(ax_inset,'XLim',[0 1.5],'YLim',[0 1]);
set(ax_inset,'Position',[.45 .2 .4 .32]);
l=legend(ax,'Location','NorthWest','Interpreter','latex');

% output eps file and pdf file depending on control flags 
fig_name_stem=strcat('Fig',num2str(fnum),'_yt_varS');
if output_eps
    print(strcat('output-eps/',fig_name_stem,'.eps'),'-depsc')
end
if output_pdf
    exportgraphics(fig,strcat('output-pdf/',fig_name_stem,'.pdf'))
end