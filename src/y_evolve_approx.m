function [sol_y,q0,qh1,qg1] = y_evolve_approx(par,tmax,g_tau)
%y_evolve solves the IVP for ice thickness in scaled coordinates
arguments
    par (1,1) struct; % contains dimensionless parameters
    tmax (1,1) double; % length of integration rune
    g_tau (1,1) function_handle = @(t) 0; %time-dependent boundary temperature [default = 0; for initial growth q0]
end

% Use finite difference approximation to estimate sensitivity to \hat{h}
% and \hat{g}
sol = q_calc(par);
ht=0.001;
sol1 = q_calc(par,ht,0);
qh1=-(sol1.parameters-sol.parameters)/ht;
gt=0.001;
sol2 = q_calc(par,0,gt);
qg1=-(sol2.parameters-sol.parameters)/gt;
q0=sol.parameters;

ode_opt = odeset('RelTol',1e-6,'AbsTol',1e-9); 
sol_y=ode45(@yt_ode,[0 tmax],0,ode_opt);

    function dytdt=yt_ode(t,yt) % approximate ode
        h_tilde=sqrt(2*yt/par.L_Stefan);
        dytdt=q0-qh1*h_tilde-qg1*g_tau(t);
    end


end

