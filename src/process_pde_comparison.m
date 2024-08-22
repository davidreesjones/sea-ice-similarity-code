function [dxc,yc,fix_tau_switch,xp,fit0,fit1]=process_pde_comparison(N)
filename=['run_tau_switch_',num2str(round(N)),'.mat'];
load(filename)
xp=linspace(fix_tau_switch,tau_max,1e3);

x1=out_tau1(out_tau1>fix_tau_switch);
y1=out_y1(out_tau1>fix_tau_switch);
fit1=fit(x1',y1','smoothingspline');
d1p=differentiate(fit1,xp);

x0=sol_y0.x(sol_y0.x>fix_tau_switch);
y0=sol_y0.y(sol_y0.x>fix_tau_switch);
fit0=fit(x0',y0','smoothingspline');
d0p=differentiate(fit0,xp);

ic=find(d1p>d0p,1,'first');

dxc=xp(ic)-fix_tau_switch;
set(gca,"XLim",[0 2*dxc])
yc=feval(fit0,xp(ic));
end