%% Plot parametric dependence of initial growth rate
par_dim_init
par = par_non_dim_init(ks,kl,cs,cl,L,TB,Tl,C0,S0,m);

vS=linspace(0.0001,0.8,10);
vX=linspace(2,10,10); %X corresponds to theta_0
[MS,MX]=meshgrid(vS,vX);
MQs=zeros(size(MS));
MQf=zeros(size(MS));
MQa=zeros(size(MS));

for I=1:numel(MS)
    par.theta_B=1+1/MX(I);
    par.L_Stefan=par.L0/MX(I);
    par.S_rel=MS(I);
    sol = q_calc(par);
    MQf(I)=sol.parameters;

    par_simplified=par;
    par_simplified.theta_e=0;
    par_simplified.delta_c=0;
    sol = q_calc(par_simplified);
    MQs(I)=sol.parameters;

    MQa(I)=1-(1/par.L_Stefan)/3+(7/45)*(1/par.L_Stefan).^2+par.S_rel*(par.theta_B-1)*(-2-(2*par.theta_B-par.delta_k)*log(1-1/par.theta_B));

end

[fig,ax] = open_figure(fnum,full_col_width,full_col_height,fontsize,linewidth,1,3);
for I=1:3
    axes(ax{I})
    switch I
        case 1
            contourf(MX,MS,MQf,0.8:0.0025:2,'LineStyle','none')
            title('Full numerics','interpreter','latex','FontSize',fontsize)
            text(2.2,0.04,'(a)','interpreter','latex','FontSize',fontsize)
        case 2
            contourf(MX,MS,MQs,0.8:0.0025:2,'LineStyle','none')
            title('Simplified numerics','interpreter','latex','FontSize',fontsize)
            text(2.2,0.04,'(b)','interpreter','latex','FontSize',fontsize)

        case 3
            contourf(MX,MS,MQa,0.8:0.0025:2,'LineStyle','none')
            title('Asymptotics','interpreter','latex','FontSize',fontsize)
            text(2.2,0.04,'(c)','interpreter','latex','FontSize',fontsize)

    end
    clim([0.9 1.4]);
    xlab=xlabel('$\theta_0$','interpreter','latex','FontSize',fontsize);
    if I==1
        ylab=ylabel('$\hat{S}$','interpreter','latex','FontSize',fontsize,'Rotation',0);
        set(gca,'YTick',0:0.25:0.75,'YLim',[0 0.8])
    else
        set(gca,'YTickLabel',[],'YLim',[0 0.8])
    end
end
colormap(cm_main)
cbar=colorbar;
cbar.Layout.Tile = 'East';
cbar.TickLabelInterpreter='latex';
cbar.FontSize=fontsize;
cbar.Label.String='$q_0$';
cbar.Label.Interpreter='latex';
cbar.Label.FontSize=fontsize;
cbar.Label.Rotation=0;

% output eps file and pdf file depending on control flags
fig_name_stem=strcat('Fig',num2str(fnum),'_pardep_q0');
if output_eps
    print(strcat('output-eps/',fig_name_stem,'.eps'),'-depsc')
end
if output_pdf
    exportgraphics(fig,strcat('output-pdf/',fig_name_stem,'.pdf'))
end