%% Initialization
clear

%% Set up path and directory structure
restoredefaultpath
addpath('src/','pde-run-data/')
output_eps = true; % true means that EPS files are generated
output_pdf = true; % true means that PDF files are generated
if ~exist('output-eps/','dir') & output_eps
    mkdir 'output-eps/'
end
if output_eps
    addpath('output-eps/')
end
if ~exist('output-pdf/','dir') & output_pdf
    mkdir 'output-pdf/'
    addpath('output-pdf/')
end
if output_pdf
    addpath('output-pdf/')
end

%% Initialize figure settings
init_figure_settings
init_color

%% Generate figures
fnum=1; figure_thermal_properties;
fnum=2; figure_asymptotic_q0_L;
fnum=3; figure_asymptotic_dq0dS;
fnum=4; figure_asymptotic_q0_S;
fnum=5; figure_pardep_q0;
fnum=6; figure_pardep_qh;
fnum=7; figure_pardep_q1;
fnum=8; figure_ht_steady;
fnum=9; figure_pardep_q2;
fnum=10; figure_yt_sinusoidal
fnum=11; figure_yt_varS
fnum=12; figure_yt_PDE