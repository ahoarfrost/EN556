#Calculating Std Bins!
## Takes slant corrected csv files for the stds, contained in a folder csvDir, and 
##calculates the intersections (std bin starts) of the std curves. 
## Outputs std bins as table in csv file, and visualization bins as png

##set your working directory to be your folder containing std data folder, e.g. ~/EN556/

#folder in which to look for std slant corrected csv files
csvDir <- "stds-gpc2-052715/slant-corrected-data-csv"   
#filename want output std bin info file to be, in csv format
outputPath <- "stds-gpc2-052715/stds-gpc2-052715.csv"
#filename want std bin visualization to be, in png format
pngPath <- "stds-gpc2-052715/stds-gpc2-052715.png"

#make list files std csvs
StdFileList <- list.files(path=csvDir, pattern="*.csv")

#read in csvs for each std curve. Each data frame has two columns, time and SlantCorrectedReads. These are for filenames which start with the std name '150kD','10kD',etc.
kD150 <- read.csv(file=paste(csvDir,"/",StdFileList[grep(pattern="150kD*",x=StdFileList)],sep=""),header=T) 
kD10 <- read.csv(file=paste(csvDir,"/",StdFileList[grep(pattern="10kD*",x=StdFileList)],sep=""),header=T)
kD4 <- read.csv(file=paste(csvDir,"/",StdFileList[grep(pattern="4kD*",x=StdFileList)],sep=""),header=T)  
GAL <- read.csv(file=paste(csvDir,"/",StdFileList[grep(pattern="GAL*",x=StdFileList)],sep=""),header=T)
FLA <- read.csv(file=paste(csvDir,"/",StdFileList[grep(pattern="FLA*",x=StdFileList)],sep=""),header=T)

#Make data frame where the first column is time and each subsequent column is the slant corrected mV reads for that std
StdData <- data.frame(time=kD150$time,kD150=kD150$SlantCorrectedReads,kD10=kD10$SlantCorrectedReads,kD4=kD4$SlantCorrectedReads,gal=GAL$SlantCorrectedReads,fla=FLA$SlantCorrectedReads)
#normalize curves to same magnitude 
maxes <- c(max(StdData$kD150),max(StdData$kD10),max(StdData$kD4),max(StdData$gal),max(StdData$fla))
m <- max(maxes)
multiples <- m/maxes
#multiply correct multiple to SlantCorrectedReads column of each std so are all same magnitude
for (i in 1:length(multiples)) {
    StdData[i+1] <- mapply("*",multiples[i],StdData[i+1])
}

#make a copy (for plotting later)
StdData1 <- StdData

#set start point of bin150, 6min before the peak starts
#find where peak starts by first time where change in y exceeds 1/250th of the peak kD150 fluorescence)
a <- which(diff(StdData$kD150)>(maxes[1]/250))
print("bin150 read number:")
print(min(a)-72) 
print("bin150 time")
print(StdData$time[min(a)-72]) 

StdBins <- data.frame(bin=c("150kD","10kD","4kD","Gal","FLA"),read.number=c(min(a)-72), time=c(StdData$time[min(a)-72]))

#To avoid noise in steps below, remove anything below 1/10 of maximum intensity, make 0
StdData2 <- as.matrix(StdData)
StdData2 <- ifelse(StdData2[,2:6]<m/10,0,StdData2[,2:6])
StdData[,2:6] <- StdData2

#Find points of intersection between 150+10, 10+4, 4+gal, gal+fla
for (j in 3:length(StdData)) {
  above <- StdData[j] > StdData[j-1]
  above <- as.vector(above)
  #find intersect point
  int.point <- which(diff(above)==1) + 1
  ypoint <- mean(c(StdData[,j][int.point],StdData[,j-1][int.point]))
  xpoint <- StdData$time[int.point]
  print("ypoint:")
  print(ypoint)
  print("xpoint:")
  print(xpoint)
  StdBins[j-1,"read.number"] <- int.point
  StdBins[j-1,"time"] <- StdData$time[int.point]
}

print(StdBins)
#export Std Bins csv
#make sure you defined your outputPath!
write.csv(StdBins,file=outputPath,quote=FALSE,row.names=FALSE)

#visualize bins, save as png; make sure it looks right!
png(filename=pngPath)
library(ggplot2)
plot <- ggplot(StdData1,aes(x=time,y=kD150))+geom_point()+ylab("mV")+geom_point(data=StdData1,aes(x=time,y=kD10)) + geom_point(data=StdData1,aes(x=time,y=kD4)) + geom_point(data=StdData1,aes(x=time,y=gal)) + geom_point(data=StdData1,aes(x=time,y=fla))
plot1 <- plot + geom_vline(xintercept=StdBins$time,color="red",linetype="dashed")
print(plot1)
dev.off()
