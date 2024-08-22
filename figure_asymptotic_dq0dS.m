%% Plot sensivity of initial growth rate to salinity
fig = open_figure(fnum,single_col_width,single_col_height,fontsize);
par_dim_init; 
par = par_non_dim_init(ks,kl,cs,cl,L,TB,Tl,C0,S0,m);

vX=linspace(0.01,10,1e3); % corresponds to \theta_0 in paper
vTHB=1+1./vX;
vdqdS=(vTHB-1).*(-2-(2*vTHB-par.delta_k).*log(1-1./vTHB));

plot(vX,vdqdS,'Color',col1,'DisplayName','Asymptotic','LineWidth',linewidth); 
plot(vX,1-par.delta_k+zeros(size(vX)),'--k','DisplayName','$1-\Delta k$','LineWidth',linewidth)
set(gca,'YLim',[0.15,0.27],'YTick',0.15:0.05:.3)
xlab=xlabel('$\theta_0$','interpreter','latex','FontSize',fontsize);
ylab=ylabel('$\frac{\partial q_0}{\partial \hat{S}}$','interpreter','latex','FontSize',fontsize,'Rotation',0);
l=legend;
l.Location='SouthWest';
l.Interpreter='latex';
l.FontSize=fontsize;

% output eps file and pdf file depending on control flags 
fig_name_stem=strcat('Fig',num2str(fnum),'_asymptotic_dq0dS');
if output_eps
    print(strcat('output-eps/',fig_name_stem,'.eps'),'-depsc')
end
if output_pdf
    exportgraphics(fig,strcat('output-pdf/',fig_name_stem,'.pdf'))
end