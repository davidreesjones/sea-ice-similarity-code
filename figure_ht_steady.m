%% Plot the thickness growth over time

par_dim_init
par = par_non_dim_init(ks,kl,cs,cl,L,TB,Tl,C0,S0,m);

[fig,ax] = open_figure(fnum,single_col_width_large,single_col_height_large,fontsize);

tmax=20; % max value of tau

vS_rel=[0.1 0.4]; % relative salinities being considered.
for J=1:2
    par.S_rel=vS_rel(J);
    sol = q_calc(par);
    ht=0.001;
    sol1 = q_calc(par,ht);
    q0=sol.parameters;
    qh1=-(sol1.parameters-sol.parameters)/ht;

    tp=linspace(0,tmax,4e3);
    tp_a=linspace(0,tmax,4e2); % less points needed to plot analytical results (works better for dashed linestyle)

    sol_y0 = y_evolve(par,tmax,@(t) 0);
    [y0,y0p]=deval(sol_y0,tp);
    h0=sqrt(2*y0/par.L_Stefan);
    c=q0;
    d=qh1*sqrt(2/par.L_Stefan);
    ya0=(c/d)^2*real(1+lambertw(-exp(-tp_a*d^2/c/2-1))).^2;
    ha0=(q0/qh1)*real(1+lambertw(-exp(-tp_a*qh1^2/q0/par.L_Stefan-1)));

    switch J
        case 1

            plot(tp,h0,'Color',col1,'DisplayName',['Numerical ($\hat{S}=',num2str(par.S_rel),'$)'],'LineWidth',linewidth)
            plot(tp_a,ha0,'Color',col2,'LineStyle','--' ,'DisplayName','Analytical (approx.)','LineWidth',linewidth)
            h0_tmp=h0; %save to plot into inset
            ha0_tmp=ha0;
        otherwise

            plot(tp,h0,'Color',col4,'DisplayName',['Numerical ($\hat{S}=',num2str(par.S_rel),'$)'],'LineWidth',linewidth)
            plot(tp_a,ha0,'Color',col5,'LineStyle','--' ,'DisplayName','Analytical (approx.)','LineWidth',linewidth,'LineWidth',linewidth)
            plot(tp_a,sqrt(2*tp_a/par.L_Stefan),'Color',[0.7 0.7 0.7],'LineStyle','-.','DisplayName','$(2\tau/\hat{L})^{1/2}$')

    end

end

xlab=xlabel('$\tau$','interpreter','latex');
ylab=ylabel('$\hat{h}$','interpreter','latex','Rotation',0);
l=legend;
l.Location='SouthEast';
l.Interpreter='latex';
l.FontSize=fontsize;
set(gca,'XLim',[0 tmax],'YLim',[0 1],'YTick',0:0.2:1)

ax_inset=axes(fig);
ax_inset.Position=[0.25 l.Position(2)+l.Position(4)-0.2 0.2 0.2];
hold on;
set(gca,'DefaultLineLineWidth',1.5,'TickLabelInterpreter','latex','defaultAxesFontSize',fontsize);
box on;
set(gca,'FontSize',fontsize,'LineWidth',linewidth)
plot(tp,h0_tmp,'Color',col1,'DisplayName',['Numerical ($\hat{S}=',num2str(par.S_rel),'$)'],'LineWidth',linewidth)
plot(tp_a,ha0_tmp,'Color',col2,'LineStyle','--' ,'DisplayName','Analytical (approx.)','LineWidth',linewidth)

plot(tp,h0,'Color',col4,'DisplayName',['Numerical ($\hat{S}=',num2str(par.S_rel),'$)'],'LineWidth',linewidth)
plot(tp_a,ha0,'Color',col5,'LineStyle','--' ,'DisplayName','Analytical (approx.)','LineWidth',linewidth)

plot(tp_a,sqrt(2*tp_a/par.L_Stefan),'Color',[0.7 0.7 0.7],'LineStyle','-.','DisplayName','$(2\tau/\hat{L})^{1/2}$','LineWidth',linewidth)

set(gca,'XLim',[0 1],'YLim',[0 0.5],'YTick',[0 0.5],'XTick',[0 1])

% output eps file and pdf file depending on control flags
fig_name_stem=strcat('Fig',num2str(fnum),'_ht_steady');
if output_eps
    print(strcat('output-eps/',fig_name_stem,'.eps'),'-depsc')
end
if output_pdf
    exportgraphics(fig,strcat('output-pdf/',fig_name_stem,'.pdf'))
end