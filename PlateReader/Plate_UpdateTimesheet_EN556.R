#update PlateTimesheet
#put files want process in RawDir folder
#make sure to set your working directory to the correct parent directory, the folder containing the RawDir folder

library(reshape2)

#Define the name of the folder where your .raw files are. 
RawDir <- "raw-for-rates"
#Define the name of your timesheet
timesheet <- "PlateTimesheet_EN556.csv"
#what timezone is the plate reader computer set on?
timezone <- "EST"

#if your timesheet already exists, load it in; if it doesn't, create a new data frame
if(file.exists(timesheet)) {
   Time <- read.csv(timesheet, header=TRUE, row.names=1,stringsAsFactors=FALSE)
   Time$TimeSampled <- strptime(x=Time$TimeSampled,tz=timezone,format="%m/%d/%Y %H:%M")
   Time$TimeSampled <- as.POSIXct(Time$TimeSampled, tz=timezone)
} else {
    Time <- data.frame(TimeSampled=as.POSIXct(character(),tz=timezone),ElapsedTime=numeric())
}

#sort files in 'raw for rates' folder into useful hierarchies
ExptList <- list()
RawNameList <- list.files(path=RawDir, pattern="*.raw")
RawNameListBulkGF <- RawNameList[grep(pattern="*GF|*bulk",RawNameList)]
RawNameListLV <- RawNameList[grep(pattern="*LV",RawNameList)]
for (file in RawNameListBulkGF) {
    #Takes the name of each raw file in your folder and defines the PartialName and FullName
    #partial=stn#-d#-bulk, full=stn#-d#-bulk-t#  
    PartialName <- sub("stn([1-9]+)-d([1-5])-([A-Za-z]+)-plate-t([0-9]).raw","stn\\1-d\\2-\\3",file)
    FullName <- sub("stn([1-9]+)-d([1-5])-([A-Za-z]+)-plate-t([0-9]).raw","stn\\1-d\\2-\\3-t\\4",file)
    
    #arranges files into useful hierarchy (all timepoints from one expt together), 
    #and reads in file, only columns 1-7 rows A-F, and renaming the columns/rows
    #a list of a list of data frames 
    ExptList[[PartialName]][[FullName]] = read.table(paste(RawDir,file,sep="/"), skip=4, na.strings=c("NA","LOW"),row.names=c("x1","x2","x3","live1","live2","live3"), col.names=c("a","b","L","p1","p2","p3","p4", rep("empty",5)), colClasses = c("NULL",rep("integer", 7), rep("NULL", 5)), nrows=6)
    
    #insert TimeSampled into timesheet from file info of time modified (should be time created since we never change the .raw data)
    TimeSampled <- file.info(paste(RawDir,file,sep="/"))["mtime"]
    Time[FullName,"TimeSampled"] <- TimeSampled$mtime
}
#update timesheet for LV .raw files
for (lv_file in RawNameListLV) {
    #Takes the name of each raw file in your folder and defines the PartialName and FullName
    #partial=stn#-d#-bulk, full=stn#-d#-bulk-t#  
    PartialName <- sub("stn([1-9]+)-d([1-5])-LV-([A-Za-z0-9]+)-subt([0-9])-t([0-9]).raw","stn\\1-d\\2-LV-\\3-subt\\4",lv_file)
    FullName <- sub("stn([1-9]+)-d([1-5])-LV-([A-Za-z0-9]+)-subt([0-9])-t([0-9]).raw","stn\\1-d\\2-LV-\\3-subt\\4-t\\5",lv_file)
    
    #arranges files into useful hierarchy (all timepoints from one expt together), 
    #and reads in file, only columns 1-7 rows A-F, and renaming the columns/rows
    #a list of a list of data frames 
    ExptList[[PartialName]][[FullName]] = read.table(paste(RawDir,lv_file,sep="/"), skip=4, na.strings=c("NA","LOW"),row.names=c("x1","x2","x3","live1","live2","live3"), col.names=c("a","b","L","p1","p2","p3","p4", rep("empty",5)), colClasses = c("NULL",rep("integer", 7), rep("NULL", 5)), nrows=6)
    
    #insert TimeSampled into timesheet from file info of time modified (should be time created since we never change the .raw data)
    TimeSampled <- file.info(paste(RawDir,lv_file,sep="/"))["mtime"]
    Time[FullName,"TimeSampled"] <- TimeSampled$mtime
}


#Calculate Elapsed Time on PlateTimesheet.csv
#Loop through each ExptList[[PartialName]] grouping (all timepoints for one incubation set),
#Extract TimeSampled from each timepoint and subtract t0 TimeSampled from each
for (inc_ix in 1:length(ExptList)) {
    #find TimeSampled from t0 row in PlateTimesheet
    t0Name <- names(ExptList[[inc_ix]][grep("*-t0",names(ExptList[[inc_ix]]))])
    t0time <- Time[t0Name,"TimeSampled"]
    #Subtract t0 TimeSampled from each timepoint TimeSampled and insert into PlateTimesheet
    for (p in 1:length(ExptList[[inc_ix]])) {
        #find timepoint TimeSampled
        name <- names(ExptList[[inc_ix]][p])
        time <- Time[name,"TimeSampled"]
        #calculate elapsed time and insert into PlateTimesheet
        elapsed <- as.numeric(difftime(time, t0time, units="hours"))
        Time[name,"ElapsedTime"] <- elapsed
    }
}

#save new PlateTimesheet
write.csv(Time,file=timesheet)