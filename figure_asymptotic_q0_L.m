%% Plot initial growth rate as function of Stefan number (\hat{L})
par_dim_init
par = par_non_dim_init(ks,kl,cs,cl,L,TB,Tl,C0,S0,m);
vL=logspace(4,log10(4)); %increase first arg to increase largest L, improving asymptotic estimate
vq=zeros(size(vL));
par.S_rel=0; % force zero salinity
par.theta_e=0;
for L=vL
    par.L_Stefan=L;
    sol = q_calc(par);
    vq(L==vL)=sol.parameters;
end
fig = open_figure(fnum,single_col_width,single_col_height,fontsize);

plot(1./vL,vq,'Color',col1,'DisplayName','Numerical','LineWidth',linewidth)
plot(1./vL,1-1/3./vL,'Color',col2,'LineStyle','--' ,'DisplayName','Linear','LineWidth',linewidth)

plot(1./vL,1-1/3./vL+(7/45)./vL.^2,'Color',col3,'LineStyle','-.','DisplayName','Quadratic','LineWidth',linewidth)
xlab=xlabel('$1/\hat{L}$','interpreter','latex');
ylab=ylabel('$q_0$','interpreter','latex','Rotation',0);
l=legend;
l.Location='NorthEast';
l.Interpreter='latex';
l.FontSize=fontsize;

% output eps file and pdf file depending on control flags
fig_name_stem=strcat('Fig',num2str(fnum),'_asymptotic_q0_L');
if output_eps
    print(strcat('output-eps/',fig_name_stem,'.eps'),'-depsc')
end
if output_pdf
    exportgraphics(fig,strcat('output-pdf/',fig_name_stem,'.pdf'))
end