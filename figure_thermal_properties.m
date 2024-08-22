%% Plot thermal properties as a function of relative depth at different relative salinties 
par_dim_init
[fig,ax] = open_figure(fnum,full_col_width,full_col_height,fontsize,linewidth,1,2);

v_z=linspace(0,1,1e3);
v_theta=linspace(1,0,1e3);

S_rel= 0:0.2:0.8; % \hat{S} in paper

axes(ax{1})
linestyleorder(["-","--","-."])
colororder(newcolors_2(end:-1:1,:))

for S0=S_rel*C0
par = par_non_dim_init(ks,kl,cs,cl,L,TB,Tl,C0,S0,m); 
v_X = par.S_rel *( par.theta_B-1)./(par.theta_B-v_theta);
v_k = 1- v_X * par.delta_k ;
v_c = 1- v_X * par.delta_c + (par.L_Stefan)./(par.theta_B-v_theta).*v_X;
plot(ax{1},v_k,v_z,LW{:});
plot(ax{2},v_c,v_z,LW{:},'DisplayName',['$\hat{S}=',num2str(par.S_rel),'$']);
end

axes(ax{1})
xlab=xlabel('$k$','interpreter','latex','FontSize',fontsize);
ylab=ylabel('$\zeta$','interpreter','latex','FontSize',fontsize,'Rotation',0);
ax{1}.XLim = [0.4 1.05];
text(.42,0.92,'(a)','interpreter','latex','FontSize',fontsize)


axes(ax{2})
l=legend;
l.Interpreter='latex';
l.Location="northeast";
l.FontSize=fontsize;
xlab=xlabel('$c$','interpreter','latex','FontSize',fontsize);
text(5,0.92,'(b)','interpreter','latex','FontSize',fontsize)


% output eps file and pdf file depending on control flags 
fig_name_stem=strcat('Fig',num2str(fnum),'_thermal_properties');
if output_eps
    print(strcat('output-eps/',fig_name_stem,'.eps'),'-depsc')
end
if output_pdf
    exportgraphics(fig,strcat('output-pdf/',fig_name_stem,'.pdf'))
end