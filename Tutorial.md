# EN556 Script Tutorial

*Step by step instructions using example data.*  

*Today we'll just be going through processing raw GPC data and calculating std bins. 
Stay tuned for calculating rates!*


 1. ###Download scripts and accompanying files. Two ways:
   1. Clone from Github. This requires you to have a Github account and make light use of git. 
   I'll skip this for today, but a git/Github tutorial down the road may be of interest. Git/github 
   is great for version control, collaboration, backing up your work and reproducibility.
   
   2. Download as zip file from my Github without using Git: 
     1. Go to:  https://github.com/ahoarfrost/EN556
     2. On right side screen, click 'Download ZIP'
     3. On your local computer, unzip folder and rename to be what you want your working directory 
     to be. I'm calling my folder "Lab Demo" and putting it in my home directory, so my working 
     directory will be "~/LabDemo". 
     
 
 2. ###Download demo data
   1. Paste this url into your browser:
    `https://sakai.unc.edu/access/content/group/217ae9a8-94d3-453b-b967-e592ee526570/Adrienne%20Hoarfrost/DemoGpcData.zip`
    
   2. Enter your onyen and password when prompted. DemoGpcData.zip should now auto-download.  
   
   3. Unzip DemoGpcData.zip, move contents to "raw-gpc-data-asc" in your working directory.
   
  * You should now have the following files and folders in your working directory:
     * RawGpcProcess.R
     * CalculateStdBins.R
     * README.md
     * Tutorial.md
     * DemoGpcData 
        * raw-gpc-data-asc
        * stds-gpc2-052715
     
     
 3. ###Slant correct raw asc data - using RawGpcProcess.R
 
   1. In RStudio, define your working directory using setwd() as the expt folder containing all your downloaded data/scripts

       `setwd("~/LabDemo")`   
       
   2. Open RawGpcProcess.R in RStudio: File->Open File->navigate to RawGpcProcess.R
   
   3. Adjust ascDir (line 5), csvDir (line 6), and pngDir (line 7) within body RawGpcProcess.R. 
   
       `ascDir <- "DemoGpcData/raw-gpc-data-asc"`  
       `csvDir <- "DemoGpcData/slant-corrected-data-csv"`   
       `pngDir <- "DemoGpcData/slant-corrected-chroms-png"`

   
   4. Now, run the script! Two ways:
      1. `source("RawGpcProcess.R")`     #using code
      
      2. Press "Source" button in top right script console in RStudio.       #Keyboard shortcut: cmd+shift+S
 
   
 ####Voila!  Now you're ready to look at the pngs and see if anything needs to be rerun.

 *Now you should see two new folders, one containing your slant corrected data and the other 
containing your chromatograms. There should be an equal number of files in each folder*



 4. ###Try slant corrected raw GPC asc data for your standard runs in the folder stds-gpc2-052715
    * Don't forget to change either your working directory, or your ascDir/csvDir/pngDir!


 5. ###Calculating Std Bins using CalculateStdBins.R
 
   1. Open CalculateStdBins.R in RStudio
   
   2. If you don't already have ggplot installed, install it:
   
      `install.packages("ggplot2")`
   
   2. Change working directory to folder want to work in, parent or stds-gpc2-052715
   
      `setwd("~/LabDemo")`
      
   3.    Change csvDir (line 9), outputPath (line 11), and pngPath (line 12). 
   
      `csvDir <- "stds-gpc2-052715/slant-corrected-data-csv"`      
      `outputPath <- "stds-gpc2-052715/stds-gpc2-052715.csv"`   
      `pngPath <- "stds-gpc2-052715/stds-gpc2-052715.png"`   
       
   4. Run the script!
   
      `source("CalculateStdBins.R")`
      
   5. Check that your bins look good! Look at png, make sure dashed lines are at real intersections.
   
   
 6. ###Manual curation of chromatograms to get final csvs
   
   1. At this point, you can look at the pngs you've output and determine if you need to do any reruns. 
   
   2. Run any reruns on the GPC, and slant correct them and generate pngs of chromatograms using rawGpcProcess.R. 
     * Keep them separate from your originals in a way you understand (see my note on data organization below). 
   
   3. Once you have your *final* slant-corrected csvs you want to use for calculating rates, copy 
   paste those files into a folder called "csvs-for-rates" (see rates tutorial below).
      * *Keep notes on which version of GPC run you use for your rate calculations (original, 
      rerun1, rerun2, etc). This is probably easiest to do as a set of notes in a text file 
      or your lab notebook.*


##A note on data organization

I like to have a project folder (e.g. EN556, or LabDemo). Within this, I'll have GpcOriginal folders 
containing raw-asc, -csv, and -png folders with the corresponding GPC data (in the case of this demo, 
that would be DemoGpcData). Then I'll have another folder, GpcReruns1, with another set of -asc, -csv, 
and -png folders. I might have GpcReruns2 and GpcReruns3 too. When I know which run of a sample I want
to use as my final csv, I record that in the appropriate column of FlaMasterList, and copy (not cut!) 
that csv to the "csvs-for-rates" in my main working directory. Rates will be calculated on whatever csvs
are in that folder. 


   
 7. ###Calculate Hydrolysis Rates using FlaRatesEN556_bulk.R and FlaRatesEN556_GF.R
 
   1. Update your scripts and reference data from my Github. 
   
     1. If you've already cloned the repository using Git, this is easy. *copy paste this into Terminal/Command Line:*   
     
            `git pull`
            
        * This will update any files that I've changed since the last time you pulled or cloned the library
   
     2. If you just downloaded the zip file (a la step 1)ii) ), you'll have to download again,
      unzip and copy everything into your working directory again
        * When asked 'file already exists, do you want to replace it?' say yes. 
   
   2. You should now have the following additional scripts and reference files in your wd:
   
     * FlaRatesEN556_bulk.R    
        *This script calculates rates for bulk water incubations*
     * FlaRatesEN556_GF.R       
        *This script calculates rates for gravity filtration incubations*
     * FlaTimepointsStdRefsEN556.csv  
        *This reference file is manually created. You enter sampling times for each sample ID
        (from the lab notebook), the elapsed time calculated manually/with excel, and the std
        bins file (copy paste the file name) you want to use to calculate rates for that file.*
     * HydrolysisCutsInfo.csv   
        *This reference file has the info about substrate mw, # of cuts
       to get to a particular std bin, etc. need to calculate rates. This never changes.*
     * VolumesFilteredEN556_GF.csv      
        *This reference file has volume filtered for GF incubations at a particular stn-depth. 
       Recorded manually from sampling sheets.*
 
     
   3. In your main working directory (~/LabDemo), create new folder: "csvs-for-rates"
   
   4. Copy (not cut!) paste final csvs you want to calculate rates for into "csvs-for-rates" folder.
      For this demo, this is all the contents in DemoGpcData/slant-corrected-data-csv.
   
   5. Copy (not cut!) paste all stdbins.csvs want to use from the stds folders into main directory (LabDemo).
      For this demo that's only one, stdbins-gpc2-052715.csv.
   
   6. Make sure your working directory in R is set to your main folder (in this example, `setwd("~/LabDemo"`) 
   
   7. Open FlaRatesEN556_bulk.R in RStudio.   
   
   8. Check lines 1:24. Are file names correct, the substrate names you're using correct?
   
   9. Source FlaRatesEN556.R!
      * Press "Source" Button, or:
      * copy paste `source("FlaRatesEN556_bulk.R")`
      
      Now there will be a new file in your working directory, FlaMasterListEN556_bulk.csv. (If
      this file already existed, it will add on to the existing file). Now if you open 
      FlaMasterListEN556_bulk.csv, you should see rates for bulk incubations.
      
   10. Open FlaRatesEN556_GF.R in RStudio
   
   11. Check lines 1:32. Are file names correct, substrate names using correct, filter fraction correct?
   
   12. Source FlaRatesEN556_GF.R
      * Press "Source" Button, or:
      * copy paste `source("FlaRatesEN556_GF.R")`

    Now if you open FlaMasterListEN556_GF.csv, you will see those rates in the appropriate columns as well.


#Have Fun!
   
   