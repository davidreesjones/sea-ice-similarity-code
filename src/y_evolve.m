function sol_y = y_evolve(par,tmax,g_tau,S_tau)
%y_evolve solves the IVP for ice thickness in scaled coordinates
arguments
    par (1,1) struct; % contains dimensionless parameters
    tmax (1,1) double; % length of integration rune
    g_tau (1,1) function_handle = @(t) 0; %time-dependent boundary temperature [default = 0; for initial growth q0 and fixed-boundary-temperature runs]
    S_tau (1,1) function_handle = @(t) par.S_rel; %time-dependent salinity [default = par.S_rel; for initial growth q0 and fixed-salinity runs]
end

    ode_opt = odeset('RelTol',1e-6,'AbsTol',1e-9);
    sol_y=ode45(@yt_ode,[0 tmax],0,ode_opt);

    function dytdt=yt_ode(t,yt) % full ODE
        par.S_rel=S_tau(t);
        h_tilde=sqrt(2*yt/par.L_Stefan);
        sol = q_calc(par,h_tilde,g_tau(t));
        dytdt=sol.parameters;
    end


end

