function sol = q_calc(par,h_tilde,g_tilde)
%q_calc Solves the BVP for temperature field in quasi-steady approximation
arguments
    par (1,1) struct; % contains dimensionless parameters
    h_tilde (1,1) double = 0; %\tilde{h} thickness [default = 0; for initial growth q0]
    g_tilde (1,1) double = 0; %\tilde{g} atmospheric temp bc [default = 0; constant bc];
end

% BVP Solver
ode_opt = odeset('RelTol',1e-4,'AbsTol',1e-7); %BVP solver options 
q_init = 1-h_tilde; % Initial guess for parameter
sol_init = bvpinit(linspace(0,1,10),@similarity_init,q_init); % Initial guess for temperature
sol = bvp4c(@similarity_ode, @similarity_bc, sol_init,ode_opt);

function dydz = similarity_ode(z,y,qh) % equation being solved
    chi=par.S_rel*(par.theta_B-1)/(par.theta_B-y(1));
    k=1-par.delta_k*chi;
    c=1-par.delta_c*chi+par.L_Stefan*chi/(par.theta_B-y(1));
    
    dydz = [y(2)/k
            -qh*(c/par.L_Stefan)*z*y(2)/k];
end
%-------------------------------------------
function res = similarity_bc(ya,yb,qh) % boundary conditions
res = [ya(1)-g_tilde
       yb(1)-1
       yb(2)-qh*(1-par.S_rel+par.theta_e)-h_tilde];
end
%-------------------------------------------
function yinit = similarity_init(z) % initial guess function
yinit = [z
         1];
end
%-------

end

