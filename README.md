# EN556
Data processing and analysis for EN556 Arnosti lab cruise to North Atlantic

## Overview
This project

There are three R scripts used to process FLA data in this project.  
All together, they take you from raw asc GPC output to hydrolysis rates, calculating std
bins along the way.

There are several scripts used to process monomeric-substrate data from the plate reader as well.


### There are three scripts to FLA processing:
 1. **RawGpcProcess.R** - takes .asc files, slant corrects them, save slant-corrected data in
 csv format; also auto-generates a chromatogram image and saves as a png
 2. **CalculateStdBins.R** - takes a destination folder containing the slant corrected std
 data as input, calculates what time in run std bin cutoffs are and saves as a csv file;
 also outputs a png visualizing the cutoffs so you can check them manually.
 3. **FlaRates_EN556.R** - takes a complete set of slant-corrected data (for one substrate, all
 timepoints for all reps, and all kill controls), and calculates hydrolysis rates at each timepoint;
 saves rate output in csv MasterList.


## Monomeric Substrates - Plate Reader processing scripts :

  1. Plate_UpdateTimesheet_EN556.R
    * This script will update the timesheet with the time sampled and elapsed time since t0 for every file in there
    '''
    #Set your working directory to be the folder that contains the folder of raw rates.
    #Change line 8 of script to match the folder name that contains .raw files - I call mine "raw-for-rates"
    RScript source("Plate_UpdateTimesheet_EN556") #run script
    '''
  2.
