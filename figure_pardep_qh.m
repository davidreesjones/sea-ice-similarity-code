%% Plot sensitivity to initial growth rate as a function of scaled thickness \hat{h}
par_dim_init
par = par_non_dim_init(ks,kl,cs,cl,L,TB,Tl,C0,S0,m);

vH=linspace(0,1.0,10); %\hat{h} in paper
vQ=zeros(size(vH));

sol = q_calc(par);
% estimate slope with simple finite difference
ht=0.001; % finite difference size
sol1 = q_calc(par,ht);
q0=sol.parameters;
qh1=-(sol1.parameters-sol.parameters)/ht;

for I=1:numel(vH)    
    sol = q_calc(par,vH(I));
    vQ(I)=sol.parameters;   
end
fig = open_figure(fnum,single_col_width,single_col_height,fontsize);

plot(vH,vQ,LW{:},'Color',col1,'DisplayName','Numerical')
plot(vH,q0-qh1*vH,'--',LW{:},'Color',col2,'DisplayName','Linear (1)')
plot(vH,q0-vH/(1-par.S_rel+par.theta_e),'-.',LW{:},'Color',col3,'DisplayName','Linear (2)')

xlab=xlabel('$\hat{h}$','interpreter','latex');
ylab=ylabel('$q$','interpreter','latex','Rotation',0);
l=legend;
l.Location='NorthEast';
l.Interpreter='latex';
l.FontSize=fontsize;

% output eps file and pdf file depending on control flags 
fig_name_stem=strcat('Fig',num2str(fnum),'_pardep_qh');
if output_eps
    print(strcat('output-eps/',fig_name_stem,'.eps'),'-depsc')
end
if output_pdf
    exportgraphics(fig,strcat('output-pdf/',fig_name_stem,'.pdf'))
end