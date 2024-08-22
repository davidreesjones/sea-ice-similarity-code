%% Plot thickness (squared) variation with time dependent forcing. 
par_dim_init
par = par_non_dim_init(ks,kl,cs,cl,L,TB,Tl,C0,S0,m);

[fig,ax] = open_figure(fnum,full_col_width,full_col_height,fontsize,linewidth,1,3);

v_omega=[1 10 100];
v_Dg=[0.5 0.5 0.5];
v_tmax=[20 20 1];

for I=1:3
    axes(ax{I})
    
    omega=v_omega(I);
    Dg=v_Dg(I);
    tmax=v_tmax(I);

    tp=linspace(0,tmax,4e3);
    sol_y = y_evolve(par,tmax,@(t) Dg*sin(omega*t));
    [y,yp]=deval(sol_y,tp);
   
    [sol_ya,q0,qh1,qg1] = y_evolve_approx(par,tmax,@(t) Dg*sin(omega*t));
    [ya,ypa]=deval(sol_ya,tp);

    c=q0;
    d=qh1*sqrt(2/par.L_Stefan);
    ya0=(c/d)^2*real(1+lambertw(-exp(-tp*d^2/c/2-1))).^2;

    %ya0-qg1*par.theta_B*Df/omega*(cos(omega*tp)-1)

    plot(tp,y,'Color',col1,'DisplayName','Num. (full)','LineWidth',linewidth)
    plot(tp,ya,'Color',col2,'LineStyle','--','DisplayName','Num. (approx.)','LineWidth',linewidth)
    plot(tp,ya0+qg1*Dg/omega*(cos(omega*tp)-1),'Color',col3,'LineStyle','-.','DisplayName','Analyt. (approx.)','LineWidth',linewidth)
    
    plot(tp,ya0,'Color',[0.5 0.5 0.5],'DisplayName','Steady','LineWidth',linewidth)


    xlab=xlabel('$\tau$','interpreter','latex','FontSize',fontsize);
    if I==1
        ylab=ylabel('$\hat{y}$','interpreter','latex','FontSize',fontsize,'Rotation',0);
    end
end
axes(ax{1})
set(gca,'XLim',[0 20],'YLim',[0 5])
text(1,4.5,['(a) $\omega=',num2str(v_omega(1)),'$'],'interpreter','latex','FontSize',fontsize)

axes(ax{2})
set(gca,'XLim',[10 11],'YLim',[2.9 3.2])
text(10.06,3.17,['(b) $\omega=',num2str(v_omega(2)),'$'],'interpreter','latex','FontSize',fontsize)
axes(ax{3})

set(gca,'XLim',[0.9 1],'YLim',[.6 .7])
text(.906,.69,['(c) $\omega=',num2str(v_omega(3)),'$'],'interpreter','latex','FontSize',fontsize)

l=legend;
l.Interpreter='latex';
l.Location="south";
l.FontSize=fontsize;

% output eps file and pdf file depending on control flags 
fig_name_stem=strcat('Fig',num2str(fnum),'_yt_sinusoidal');
if output_eps
    print(strcat('output-eps/',fig_name_stem,'.eps'),'-depsc')
end
if output_pdf
    exportgraphics(fig,strcat('output-pdf/',fig_name_stem,'.pdf'))
end