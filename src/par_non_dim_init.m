function par = par_non_dim_init(ks,kl,cs,cl,L,TB,Tl,C0,S0,m)
%par_non_dim_init Converts dimensional to dimensionless parameteres
%   Input: dimensional parameters (can be loaded using par_dim_init)
%   Output: structure par containing all the dimensionless parameters

par.delta_k=1-kl/ks;
par.delta_c=1-cl/cs;

T0=-m*C0;
DT=T0-TB;
assert(DT>0,'DT=T0-TB must be greater than 0');
par.theta_B=-TB/DT;
assert(par.theta_B>1,'theta_B must be greater than 1, check TB and T0=-m*C0')

par.theta_e=cl*(Tl-T0)/L;
par.L_Stefan=L/(cs*DT);
par.L0=L/cs/(-T0);

par.S_rel=S0/C0;
assert(par.S_rel<1,'S_rel=S0/C0 must be less than 1')
assert(par.S_rel>=0,'S_rel=S0/C0 must be non-negative')

end

