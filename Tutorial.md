# EN556 Script Tutorial

*Step by step instructions using example data.*  

*Today we'll just be going through processing raw GPC data and calculating std bins. 
Stay tuned for calculating rates!*


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
   
   

*Now you have all your data slant-corrected, you have std bins, and you're ready to calculate a rate! Stay tuned.*

 

##A note on data organization

I like to have a project folder (e.g. EN556). Within this, I'll have GpcOriginal folders 
containing raw-asc, -csv, and -png folders with the corresponding GPC data. Then I'll have 
another folder, GpcReruns1, with another set of -asc, -csv, and -png folders. I might have 
GpcReruns2 and GpcReruns3 too. Then, I'll keep my scripts in the main EN556 folder, and 
adjust my ascDirs, csvDirs, pngDirs, etc. to reflect these paths. 
   
   