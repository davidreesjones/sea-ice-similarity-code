%% Comparison between PDE and QS models with a step change in forcing at specifed time (tau)
% Loads pre-calculated data from pde-run-data directory
% The QS model data is calculated as part of this script. 
% The PDE data was generated using the code for 'CICE-type fixed salinity models' connected to the paper:
% Rees Jones, D. W., and M. G. Worster (2014), 
% A physically based parameterization of gravity drainage for sea-ice modeling, 
% J. Geophys. Res. Oceans, 119, 5599–5621, doi:10.1002/ 2013JC009296.

[fig,ax] = open_figure(fnum,full_col_width,full_col_height,fontsize,linewidth,1,3);

for I=1:3
    axes(ax{I})
    N=2; % switches at tau = 2

    filename=['run_tau_switch_',num2str(round(N)),'.mat'];
    load(filename);
    fix_TB_1=-10;
    fix_TB_2=-20;
    [dxc,yc,fix_tau_switch,xp,fit0,fit1]=process_pde_comparison(N);
    par.theta_e=par.theta_l/par.L_Stefan;
    sol_warm=y_evolve(par,tau_max);
    TB_warm=fix_TB_1;
    DT=-TB_warm/par.theta_B;
    TB_cold=fix_TB_2;
    theta_cold=(TB_cold-TB_warm)/DT;
    sol_cold=y_evolve(par,tau_max,@(t) theta_cold);
    tp=linspace(0,tau_max,1e3);
    [y_cold,yp_cold]=deval(sol_cold,tp);
    [y_warm,yp_warm]=deval(sol_warm,tp);

    switch I
        case 1
            plot(out_tau1,out_y1,'Color',col1,'DisplayName','PDE','LineWidth',linewidth)
            plot(sol_y0.x,sol_y0.y,'--','Color',col2,'DisplayName','QS','LineWidth',linewidth)
            plot(tp,y_warm,'--','Color',[0.3 0.3 0.3],'DisplayName','Fix 1','LineWidth',linewidth)
            plot(tp,y_cold,'-.','Color',[0.3 0.3 0.3],'DisplayName','Fix 2','LineWidth',linewidth)
            ax_inset=axes(fig);
            ax_inset.Position=[0.5 0.1 0.2 .2];
            hold on;
            set(gca,'DefaultLineLineWidth',1.5,'TickLabelInterpreter','latex','defaultAxesFontSize',fontsize);
            box on;
            set(gca,'FontSize',fontsize,'LineWidth',linewidth)
            plot(out_tau1,out_y1,'Color',col1,'DisplayName','PDE','LineWidth',linewidth)
            plot(sol_y0.x,sol_y0.y,'--','Color',col2,'DisplayName','QS','LineWidth',linewidth)
            plot(tp,y_warm,'--','Color',[0.3 0.3 0.3],'DisplayName','Fix 1','LineWidth',linewidth)
            plot(tp,y_cold,'-.','Color',[0.3 0.3 0.3],'DisplayName','Fix 2','LineWidth',linewidth)
            set(ax_inset,'XLim',[1.9 2.2],'Ylim',[1.4 1.7])
            set(ax_inset,'Position',[0.19 0.24 0.1 0.2])
        case 2
            plot(xp-fix_tau_switch,differentiate(fit1,xp),'Color',col1,'DisplayName','PDE','LineWidth',linewidth)
            plot(xp-fix_tau_switch,differentiate(fit0,xp),'--','Color',col2,'DisplayName','QS','LineWidth',linewidth)
            plot(tp-fix_tau_switch,yp_warm,'--','Color',[0.3 0.3 0.3],'DisplayName','Fix 1','LineWidth',linewidth)
            plot(tp-fix_tau_switch,yp_cold,'-.','Color',[0.3 0.3 0.3],'DisplayName','Fix 2','LineWidth',linewidth)

            ax_inset2=axes(fig);
            ax_inset2.Position=[0.5 0.1 0.2 .2];
            hold on;
            set(gca,'DefaultLineLineWidth',1.5,'TickLabelInterpreter','latex','defaultAxesFontSize',fontsize);
            box on;
            set(gca,'FontSize',fontsize,'LineWidth',linewidth)
            plot(xp-fix_tau_switch,differentiate(fit1,xp),'Color',col1,'DisplayName','PDE','LineWidth',linewidth)
            plot(xp-fix_tau_switch,differentiate(fit0,xp),'--','Color',col2,'DisplayName','QS','LineWidth',linewidth)
            set(ax_inset2,'XLim',[0 .5],'YLim',[0 2]);
            set(ax_inset2,'Position',[0.49 0.24 0.1 0.2])
        case 3
            vN=[1 2 4 6 10];
            vtau=zeros(size(vN));
            vdxc=zeros(size(vN));
            vyc=zeros(size(vN)); 
            vdeltay=zeros(size(vN));
            for N=vN
                [dxc,yc,fix_tau_switch,xp,fit0,fit1]=process_pde_comparison(N);
                vtau(N==vN)=fix_tau_switch;
                vdxc(N==vN)=dxc;
                vyc(N==vN)=yc;
                vdeltay(N==vN)=max(abs(fit0(xp)-fit1(xp)));
            end
            plot(vyc,vdxc,'s','Color',col1,'DisplayName','$\Delta \tau_s$','LineWidth',linewidth)
            plot([0.5,10],[0.5,10]*vdxc(3)/vyc(3),'--','Color',col1,'DisplayName','$\propto \hat{y}(\tau_s)$','LineWidth',linewidth)
            plot(vyc,vdeltay,'o','Color',col2,'DisplayName','$\Delta \hat{y}_s$','LineWidth',linewidth)
            plot([0.5,10],[0.5,10]*vdeltay(3)/vyc(3),'LineStyle','-.','Color',col2,'DisplayName','$\propto \hat{y}(\tau_s)$','LineWidth',linewidth)
    end

end
axes(ax{1})
set(gca,'XLim',[0 8],'YLim',[0 10])
%text(1,4.5,['(a) $\omega=',num2str(v_omega(1)),'$'],'interpreter','latex','FontSize',fontsize)
xlab=xlabel('$\tau$','interpreter','latex','FontSize',fontsize);
ylab=ylabel('$\hat{y}$','interpreter','latex','FontSize',fontsize,'Rotation',0);
title('(a) Thickness','interpreter','latex','FontSize',fontsize)

l=legend;
l.Interpreter='latex';
l.Location="northwest";
l.FontSize=fontsize;


axes(ax{2})
set(gca,'XLim',[0 6],'YLim',[0 2])
%text(10.06,3.17,['(b) $\omega=',num2str(v_omega(2)),'$'],'interpreter','latex','FontSize',fontsize)
xlab=xlabel('$\tau-\tau_s$','interpreter','latex','FontSize',fontsize);
ylab=ylabel('$\frac{d\hat{y}}{d\tau}$','interpreter','latex','FontSize',fontsize,'Rotation',0);
title('(b) Growth rate','interpreter','latex','FontSize',fontsize)


axes(ax{3})
set(gca,'XScale','log','YScale','log')
set(gca,'XLim',[0.5 10],'YLim',[0.9*min(vdxc(1),vdeltay(1)),3])
title('(c) Lag, thickness difference','interpreter','latex','FontSize',fontsize)
l2=legend;
l2.Interpreter='latex';
l2.Location="northwest";
l2.FontSize=fontsize;
xlab=xlabel('$\hat{y}(\tau_s)$','interpreter','latex','FontSize',fontsize);
%ylab=ylabel('$\Delta \tau_s$','interpreter','latex','FontSize',fontsize,'Rotation',0);
ylab.Position(1)=ylab.Position(1)+0.05;

% output eps file and pdf file depending on control flags 
fig_name_stem=strcat('Fig',num2str(fnum),'_yt_PDE');
if output_eps
    print(strcat('output-eps/',fig_name_stem,'.eps'),'-depsc')
end
if output_pdf
    exportgraphics(fig,strcat('output-pdf/',fig_name_stem,'.pdf'))
end