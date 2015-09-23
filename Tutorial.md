# EN556 Script Tutorial

**Step by step instructions using example data.**

 1. ###Download scripts and accompanying files. Two ways:
   1. Clone from Github. This requires you to have a Github account and make light use of git. I'll skip this for today, but a git/Github tutorial down the road may be of interest. Git/github is great for version control, collaboration, backing up your work and reproducibility.
   
   2. Download as zip file from my Github without using Git: 
     1. Go to:  https://github.com/ahoarfrost/EN556
     2. On right side screen, click 'Download ZIP'
     3. On your local computer, unzip folder and move its contents into your working directory. 
     
 
 2. ###Download demo data
   1. Paste this url into your browser:
    `https://sakai.unc.edu/access/content/group/217ae9a8-94d3-453b-b967-e592ee526570/Adrienne%20Hoarfrost/DemoGpcData.zip`
    
   2. Enter your onyen and password when prompted. DemoGpcData.zip should now auto-download.  
   
   3. Unzip DemoGpcData.zip, move contents to "raw-gpc-data-asc" in your working directory.
   
 * You should now have the following files and folders in your working directory:
     * RawGpcProcess.R
     * CalculateStdBins.R
     * FlaRates_EN556.R
     * FLAMasterListEN556.csv
     * FLAElapsedTimeEN556.csv
     * hydrolysis-cuts-info.csv
     * README.md
     * Tutorial.md
     * raw-gpc-data-asc
     * stds-gpc2-052715
     
     
 3. ###Slant correct raw asc data - using RawGpcProcess.R 
 
   1. In RStudio, define your working directory using setwd() as the expt folder containing all your downloaded data/scripts

       `setwd("~/LabDemo")`