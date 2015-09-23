# EN556
Data processing and analysis for EN556 Arnosti lab cruise to North Atlantic

##Overview
There are three scripts (file extension ".R") in this project.  
All together, they take you from raw asc GPC output to hydrolysis rates, calculating std 
bins along the way. 


**There are three scripts to this processing:**
 1. RawGpcProcess.R - takes .asc files, slant corrects them, save slant-corrected data in 
 csv format; also auto-generates a chromatogram image and saves as a png
 2. CalculateStdBins.R - takes a destination folder containing the slant corrected std 
 data as input, calculates what time in run std bin cutoffs are and saves as a csv file; 
 also outputs a png visualizing the cutoffs so you can check them manually.
 3. FlaRates_EN556.R - takes a complete set of slant-corrected data (for one substrate, all
 timepoints for all reps, and all kill controls), and calculates hydrolysis rates at each timepoint;
 saves rate output in csv MasterList.

