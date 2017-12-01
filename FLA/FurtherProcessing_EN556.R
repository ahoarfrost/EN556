#FurtherProcessing_EN556

#take final rates (from bulk and GF), extract just kill-corrected mean and sd rate (and round to two decimal points),
#change manually inspected chromatograms to zero where appropriate
#add some factor labels, find timepoint with max rate for each incubation set, 
#save as FlaMaxRatesEN556_bulk.csv

master.bulk <- read.csv("FlaRatesFinalEN556_bulk.csv",row.names=1)
#add stn, depth id, site (stn.depthid), depth sampled (m), expt type (bulk), substrate, timepoint factor columns

#define new df with just mean kill-corrected rate and its sd
factors.bulk <- data.frame(mean.kcrate.nM.hr=round(master.bulk$mean.kcrate.nM.hr,2), sd.kcrate.nM.hr=round(master.bulk$sd.kcrate.nM.hr,2),row.names=row.names(master.bulk))

#stn
factors.bulk$stn <- factor(sub(pattern="stn([0-9]+)-d([0-9])-bulk-([a-z]+)-t([0-9])",replacement="\\1",row.names(factors.bulk)))
#depthid
factors.bulk$depthid <- factor(sub(pattern="stn([0-9]+)-d([0-9])-bulk-([a-z]+)-t([0-9])",replacement="d\\2",row.names(factors.bulk)))
#site (stn.depth id)
factors.bulk$site <- factor(sub(pattern="stn([0-9]+)-d([0-9])-bulk-([a-z]+)-t([0-9])",replacement="\\1.d\\2",row.names(factors.bulk)))
#depth sampled (m) (retrieved from cruise notebook)
#expt type
factors.bulk$expt <- factor(sub(pattern="stn([0-9]+)-d([0-9])-bulk-([a-z]+)-t([0-9])",replacement="bulk",row.names(factors.bulk)))
#substrate
factors.bulk$substrate <- factor(sub(pattern="stn([0-9]+)-d([0-9])-bulk-([a-z]+)-t([0-9])",replacement="\\3",row.names(factors.bulk)))
#timepoint
factors.bulk$timepoint <- factor(sub(pattern="stn([0-9]+)-d([0-9])-bulk-([a-z]+)-t([0-9])",replacement="t\\4",row.names(factors.bulk)))

#save factors.bulk as FlaRatesFinalWithFactorsEN556_bulk.csv
write.csv(factors.bulk,"FlaRatesFinalWithFactorsEN556_bulk.csv",row.names=TRUE)

#take factors from factors.bulk, extract only timepoint with maximum hydrolysis rate for each incubation set; save as FlaMaxRatesEN556_bulk.csv
maxes.bulk <- matrix(ncol=ncol(factors.bulk),dimnames=list(NULL,colnames(factors.bulk)))

#loop through each stn, then depth, then substrate, find max activity timepoint for that substrate, and rbind to maxes.bulk matrix
#for one stn...
for (stn in levels(factors.bulk$stn)) {
    #and one depth...
    for (dep in levels(factors.bulk$depthid)) {
        #and one substrate...
        for (sub in levels(factors.bulk$substrate)) {
            subset <- factors.bulk[factors.bulk$stn==stn&factors.bulk$depthid==dep&factors.bulk$substrate==sub,]
            #...find row with max activity
            m <- max(subset$mean.kcrate.nM.hr)
            maxsub <- subset[subset$mean.kcrate.nM.hr==m,]
            #if >1 row is max (e.g. rates are 0 at every timepoint), use first row
            if(nrow(maxsub)>1) {
                maxsub <- maxsub[1,]
            }
            
            #Add max to FLAmax
            maxes.bulk <- rbind(maxes.bulk,maxsub)
        }
    }
}

#remove row with NA (from creating matrix); (keep only rows where no missing data)
maxes.bulk <- maxes.bulk[complete.cases(maxes.bulk)==TRUE,]
#save as FlaMaxRatesEN556_bulk.csv
write.csv(maxes.bulk,"FlaMaxRatesFinalEN556_bulk.csv",row.names=TRUE)


###GF processing
gf <- read.csv("EN556_FLA_ratesFinalGF.csv",header=TRUE, row.names=1)

#add factors
gf_factors <- data.frame("cast_no"=rep("", nrow(gf)))
gf_factors$station_no <- gsub(pattern="stn([0-9])-d([0-9])-GF-([a-zA-Z]+)-t([0-9])",replacement="stn\\1",x=rownames(gf))
gf_factors$depth_no <- gsub(pattern="stn([0-9])-d([0-9])-GF-([a-zA-Z]+)-t([0-9])",replacement="d\\2",x=rownames(gf))
gf_factors$depth_m <- ""
gf_factors$substrate <- gsub(pattern="stn([0-9])-d([0-9])-GF-([a-zA-Z]+)-t([0-9])",replacement="\\3",x=rownames(gf))
gf_factors$timepoint <- gsub(pattern="stn([0-9])-d([0-9])-GF-([a-zA-Z]+)-t([0-9])",replacement="t\\4",x=rownames(gf))
#time elapsed
time <- read.csv("FlaTimepointsStdRefsEN556.csv", row.names=1)
newgf <- data.frame("sample"=row.names(gf))
newtime <- data.frame("time_elapsed_hr"=time$elapsed.time.hrs, "unit"=row.names(time))
newtime$sample <- gsub(pattern="stn([0-9])-d([0-9])-([a-zA-Z]+)-([a-zA-Z]+)-([0-9a-z])-t([0-9])",replacement="stn\\1-d\\2-\\3-\\4-t\\6",x=newtime$unit)
merged <- merge(newgf, newtime[,c("time_elapsed_hr","sample")], all=FALSE)
merged <- unique(merged)
gf_factors$time_elapsed_hr <- merged$time_elapsed_hr

gf_factors$rep1_rate <- gf$kcrate.1.nM.hr
gf_factors$rep2_rate <- gf$kcrate.2.nM.hr
gf_factors$average <- gf$mean.kcrate.nM.hr
gf_factors$std_dev <- gf$sd.kcrate.nM.hr

gf_factors$filter_um <- "3"

write.csv(gf_factors,"EN556_FLA_ratesFinalGF.csv",row.names=FALSE)

##max rates
maxes.gf <- matrix(ncol=ncol(factors.gf),dimnames=list(NULL,colnames(factors.gf)))

#loop through each stn, then depth, then substrate, find max activity timepoint for that substrate, and rbind to maxes.bulk matrix
#for one stn...
for (stn in levels(factors.gf$stn)) {
    #and one depth...
    for (dep in levels(factors.gf$depthid)) {
        #and one substrate...
        for (sub in levels(factors.gf$substrate)) {
            subset <- factors.gf[factors.gf$stn==stn&factors.gf$depthid==dep&factors.gf$substrate==sub,]
            #...find row with max activity
            m <- max(subset$mean.kcrate.nM.hr)
            maxsub <- subset[subset$mean.kcrate.nM.hr==m,]
            #if >1 row is max (e.g. rates are 0 at every timepoint), use first row
            if(nrow(maxsub)>1) {
                maxsub <- maxsub[1,]
            }
            
            #Add max to FLAmax
            maxes.gf <- rbind(maxes.gf,maxsub)
        }
    }
}

#remove row with NA (from creating matrix); (keep only rows where no missing data)
maxes.gf <- maxes.gf[complete.cases(maxes.gf)==TRUE,]
#save as FlaMaxRatesEN556_bulk.csv
write.csv(maxes.gf,"FlaMaxRatesEN556_gf.csv",row.names=TRUE)
