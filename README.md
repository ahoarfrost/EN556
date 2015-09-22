# EN556
Data processing and analysis for EN556 Arnosti lab cruise to North Atlantic

##Overview
There are three scripts (file extension ".R") in this project. 
All together, they take you from raw asc GPC output to slant corrected data, calculates standard bins and calcualtes rates. 

There are three scripts to this processing: 
1. RawGpcProcess.R - takes .asc files, slant correct them, save as slant-corrected .csv files; also auto-generates a chromatogram image and saves as a png
2. CalculateStdBins.R - takes a destination folder containing the slant corrected std data as input, generates a csv file with std bin cutoff data; also outputs a png visualizing the cutoffs so you can check them manually.
3. FlaRates_EN556.R - takes 


There are also several additional files with necessarily input into the scripts:
1. FLAElapsedTimeEN556.csv - contains sample unique ID, time sampled, and elapsed time (calculated from time sampled)
2. 

You will start with the raw data in .asc format. 
These are chromatogram reads of fluorescence over run time on the GPC.


