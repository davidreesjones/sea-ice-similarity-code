%% Plot parametric dependence of sensivity factors
par_dim_init
par = par_non_dim_init(ks,kl,cs,cl,L,TB,Tl,C0,S0,m);

vS=linspace(0.0001,0.8,10);
vX=linspace(2,10,10); %X corresponds to theta_0
[MS,MX]=meshgrid(vS,vX);
MQ0=zeros(size(MS));
MDQDH=zeros(size(MS));

for I=1:numel(MS)
    par.theta_B=1+1/MX(I);
    par.L_Stefan=par.L0/MX(I);
    par.S_rel=MS(I);
    
    sol = q_calc(par);
    ht=0.001; % finite difference
    sol1 = q_calc(par,ht);
    q0=sol.parameters;
    qh1=-(sol1.parameters-sol.parameters)/ht;
    
    MQ0(I)=q0;    
    MDQDH(I)=qh1;

end

[fig,ax] = open_figure(fnum,full_col_width,full_col_height,fontsize,linewidth,1,3);
colormap(cm_main)
for I=1:2
    axes(ax{I})
    switch I
        case 1
            contourf(MX,MS,MQ0,0.8:0.0025:2,'LineStyle','none')
            text(2.2,0.04,'(a)','interpreter','latex','FontSize',fontsize)
            cbar=colorbar;
            cbar.Location='north';
            cbar.TickLabelInterpreter='latex';
            cbar.FontSize=fontsize;
            cbar.Label.String='$q_0$';
            cbar.Label.Interpreter='latex';
            cbar.Label.FontSize=fontsize;
            cbar.Label.Rotation=0;
        case 2
            contourf(MX,MS,MDQDH,0.8:0.0025:3,'LineStyle','none')
            text(2.2,0.04,'(b)','interpreter','latex','FontSize',fontsize)
                    cbar=colorbar;
            cbar.Location='north';
            cbar.TickLabelInterpreter='latex';
            cbar.FontSize=fontsize;
            cbar.Label.String='$q_1$';
            cbar.Label.Interpreter='latex';
            cbar.Label.FontSize=fontsize;
            cbar.Label.Rotation=0;
    end
    xlab=xlabel('$\theta_0$','interpreter','latex','FontSize',fontsize);
    set(gca,'XTick',2:2:10)
    if I==1
        ylab=ylabel('$\hat{S}$','interpreter','latex','FontSize',fontsize,'Rotation',0);
        set(gca,'YTick',0:0.25:0.75,'YLim',[0 0.8])
    else
        set(gca,'YTickLabel',[],'YLim',[0 0.8])
    end

    
end

axes(ax{3})
par_dim_init
par = par_non_dim_init(ks,kl,cs,cl,L,TB,Tl,C0,S0,m);


vS_rel=linspace(0.001,0.8,20);
vq=zeros(size(vS_rel));
ind=0;
for ht=0:0.2:1
    ind=ind+1;
    for S_rel=vS_rel
        par.S_rel=S_rel;
        sol = q_calc(par,ht);
        vq(S_rel==vS_rel)=sol.parameters;
    end
    
    h=plot(vS_rel,vq,LW{:},'DisplayName',['$\hat{h}=',num2str(ht),'$']);
    
    if mod(ind,2)==0
        h.LineStyle='--';
    end
    switch ind
        case {1,2}
            h.Color=newcolors(1,:);
        case {3,4}
            h.Color=newcolors(2,:);
        case {5,6}
            h.Color=newcolors(3,:);
    end
    hold on
end
text(0.03,-0.13,'(c)','interpreter','latex','FontSize',fontsize)
l=legend;
l.Interpreter='latex';
l.Location="bestoutside";
l.FontSize=fontsize;
xlab=xlabel('$\hat{S}$','interpreter','latex','FontSize',fontsize);
ylab=ylabel('$q$','interpreter','latex','FontSize',fontsize,'Rotation',0);
set(gca,'XTick',0:0.25:0.75,'XLim',[0 0.8])

% output eps file and pdf file depending on control flags 
fig_name_stem=strcat('Fig',num2str(fnum),'_pardep_q1');
if output_eps
    print(strcat('output-eps/',fig_name_stem,'.eps'),'-depsc')
end
if output_pdf
    exportgraphics(fig,strcat('output-pdf/',fig_name_stem,'.pdf'))
end