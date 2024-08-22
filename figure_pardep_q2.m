%% Plot  parametric sensitivity to scaled atmospheric temperature factor
par_dim_init
par = par_non_dim_init(ks,kl,cs,cl,L,TB,Tl,C0,S0,m);

[fig,ax] = open_figure(fnum,full_col_width,full_col_height,fontsize,linewidth,1,2);

vS=linspace(0.0001,0.8,10);
vX=linspace(2,10,10); %X corresponds to \theta_0
[MS,MX]=meshgrid(vS,vX);
MQ0=zeros(size(MS));
MDQDG=zeros(size(MS));

vG=linspace(0,1.0,40); %\hat{g} in paper
vQ=zeros(size(vG));

sol = q_calc(par);
% finite difference approximation to sensivity
gt=0.001; %finite difference size
sol1 = q_calc(par,0,gt);
q0=sol.parameters;
qg1=-(sol1.parameters-sol.parameters)/gt;

for I=1:numel(vG)
    sol = q_calc(par,0,vG(I));
    vQ(I)=sol.parameters;
end

axes(ax{1})
plot(vG,vQ,LW{:},'Color',col1,'DisplayName','Numerical')
plot(vG,q0-qg1*vG,'--',LW{:},'Color',col2,'DisplayName','Linear (1)')
plot(vG,q0-q0*vG,'-.',LW{:},'Color',col3,'DisplayName','Linear (2)')

xlab1=xlabel('$\hat{g}$','interpreter','latex');
ylab1=ylabel('$q$','interpreter','latex','Rotation',0);
l=legend;
l.Location='NorthEast';
l.Interpreter='latex';
l.FontSize=fontsize;
set(gca,'YLim',[0 1.05],'YTick',0:0.2:1)
text(.02,0.04*1.05/0.8,'(a)','interpreter','latex','FontSize',fontsize)

for I=1:numel(MS)
    par.theta_B=1+1/MX(I);
    par.L_Stefan=par.L0/MX(I);
    par.S_rel=MS(I);

    sol = q_calc(par);
    gt=0.001;
    sol1 = q_calc(par,0,gt);
    q0=sol.parameters;
    qg1=-(sol1.parameters-sol.parameters)/gt;

    MQ0(I)=q0;
    MDQDG(I)=qg1;

end

colormap(cm_main)

axes(ax{2});

contourf(MX,MS,MDQDG,0.8:0.0025:3,'LineStyle','none')
text(2.2,0.04,'(b)','interpreter','latex','FontSize',fontsize)
cbar=colorbar;
cbar.Location='north';
cbar.TickLabelInterpreter='latex';
cbar.FontSize=fontsize;
cbar.Label.String='$q_2$';
cbar.Label.Interpreter='latex';
cbar.Label.FontSize=fontsize;
cbar.Label.Rotation=0;

xlab=xlabel('$\theta_0$','interpreter','latex','FontSize',fontsize);

ylab=ylabel('$\hat{S}$','interpreter','latex','FontSize',fontsize,'Rotation',0);
set(gca,'YTick',0:0.25:0.75,'YLim',[0 0.8])

% output eps file and pdf file depending on control flags
fig_name_stem=strcat('Fig',num2str(fnum),'_pardep_q2');
if output_eps
    print(strcat('output-eps/',fig_name_stem,'.eps'),'-depsc')
end
if output_pdf
    exportgraphics(fig,strcat('output-pdf/',fig_name_stem,'.pdf'))
end