-The code in this folder produces all the figures in the main text except for Figs 1,2, and 3. 
-Basic naming conventions: any .m file ending in "figurescript" produces the figure simply by running
 that script. Some figurescripts load in previously generated data, for example in
 "fitness_value_kappa_1_figurescript.m", it requires the data generated from running "fitnessMax_script_pq.m",
 located in the folder "Fitness maximizer (Fig 7)". The data generated for the manuscript is already
 loaded into the respective folders.
-"crop.m" is written by Andy Bliss Sept 8th, 2006. Revised May 31, 2012. This function cuts out whitespace
 in the resulting Matlab figure.
- All other Matlab functions are written by Keith Paarporn