# Sea ice similarity paper code: Scripts to generate associated figures

## Reference: 
Software reproduces the calculations and figures in an accompanying paper. Please cite the accompanying paper: 

D. W. Rees Jones, in preparation. Thermodynamic growth of sea ice: assessing the role of salinity using a quasi-static modelling framework. A preprint is available on the arXiv: https://doi.org/10.48550/arXiv.2409.17696. Please contact author (contact details below) for a suitable reference to cite. 

## Instructions:
* To generate the figures in the paper, run `make_all_figures`. This executes all the individual figure scripts. 
* The source functions are provided `src/`:
  * Controls on figure style and properties: init_color.m, init_figure_settings.m and open_figure.m
  * Parameter set up: par_dim_init.m and par_non_dim_init.m
  * BVP solver (for solving heat equation): q_calc.m
  * IVP solver (for thickness evolution): y_evolve.m and y_evolve_approx.m (which solves and approximated version of the IVP)
  * PDE comparison data processing: process_pde_comparison.m
* The PDE data against which the proposed quasi-static model is tested is stored in `pde-run-data'

## Additional notes 
* This distribution was developed and tested on MATLAB2024a. 
Running these routines on different versions of MATLAB may lead to compatibility issues.

## Licence 

MIT Licence

Copyright (c) 2024

* David W. Rees Jones [david.reesjones@st-andrews.ac.uk]   
University of St Andrews,    
School of Mathematics and Statistics,   
Mathematical Institute,   
North Haugh,   
St Andrews,   
KY16 9SS,  
United Kingdom.     

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
