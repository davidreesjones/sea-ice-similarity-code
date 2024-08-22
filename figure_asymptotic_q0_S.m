%% Plot initial growth rate vs relative salinity
fig = open_figure(fnum,single_col_width*1.3,single_col_height,fontsize);

par_dim_init
par = par_non_dim_init(ks,kl,cs,cl,L,TB,Tl,C0,S0,m);
par.L_Stefan=1e3;
par.theta_e=0;
par.delta_c=0;
vS_rel=linspace(0.01,0.8,40);
vq=zeros(size(vS_rel));
for S_rel=vS_rel
    par.S_rel=S_rel;
    sol = q_calc(par);
    vq(S_rel==vS_rel)=sol.parameters;
end

plot(vS_rel,vq-1,'Color',col1,LW{:},'DisplayName',['$\Delta k=',num2str(par.delta_k,2),'$ (full)'] )
plot(vS_rel,vS_rel*(par.theta_B-1)*(-2-(2*par.theta_B-par.delta_k)*log(1-1/par.theta_B)),'--','Color',col1,LW{:},'DisplayName',['$\Delta k=',num2str(par.delta_k,2),'$ (asymp.)']);
plot(vS_rel,(1-par.delta_k*vS_rel)./(1-vS_rel)-1,'Color',col2,LW{:},'DisplayName','Zero-layer (full)')
plot(vS_rel,vS_rel*(1-par.delta_k),'--','Color',col2,LW{:},'DisplayName','Zero-layer (asymp.)')
set(gca,'YLim',[0 0.24],'YTick',0:0.05:.25)

par.delta_k=0.13/0.054/2.03;
vq2=zeros(size(vS_rel));
for S_rel=vS_rel
    par.S_rel=S_rel;
    sol = q_calc(par);
    vq2(S_rel==vS_rel)=sol.parameters;
end
plot(vS_rel,vq2-1,'-.','Color',col1,LW{:},'DisplayName',['$\Delta k=',num2str(par.delta_k,2),'$ (full)'])
 
xlab=xlabel('$\hat{S}$','interpreter','latex');
ylab=ylabel('$q_0-1$','interpreter','latex','Rotation',0);
l=legend;
l.Location='NorthWest';
l.Interpreter='latex';
l.FontSize=fontsize;

% output eps file and pdf file depending on control flags 
fig_name_stem=strcat('Fig',num2str(fnum),'_asymptotic_q0_S');
if output_eps
    print(strcat('output-eps/',fig_name_stem,'.eps'),'-depsc')
end
if output_pdf
    exportgraphics(fig,strcat('output-pdf/',fig_name_stem,'.pdf'))
end