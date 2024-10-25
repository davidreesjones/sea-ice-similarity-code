function sol = hinf_calc(par)
%q_calc Solves the BVP for temperature field in quasi-steady approximation
arguments
    par (1,1) struct; % contains dimensionless parameters
end

% BVP Solver
ode_opt = odeset('RelTol',1e-4,'AbsTol',1e-7); %BVP solver options 
sol_init = bvpinit(linspace(0,1,10),@similarity_init); % Initial guess for temperature
sol = bvp4c(@similarity_ode, @similarity_bc, sol_init,ode_opt);
sol.hinf=sol.y(2,end);

    function dydz = similarity_ode(z,y) % equation being solved
    chi=par.S_rel*(par.theta_B-1)/(par.theta_B-y(1));
    k=1-par.delta_k*chi;
    
    dydz = [y(2)/k
            0];
end
%-------------------------------------------
function res = similarity_bc(ya,yb) % boundary conditions
res = [ya(1)
       yb(1)-1];
end
%-------------------------------------------
function yinit = similarity_init(z) % initial guess function
yinit = [z
         1];
end
%-------

end

