#further processing for EN556 plate reader (all 8 stns)

######################## bulk ##########################
bulk1 <- read.csv("EN556_plate_ratesBulk_stn1to2.csv",header=TRUE,row.names=1)
bulk2 <- read.csv("EN556_plate_ratesBulk_stn3to8.csv",header=TRUE,row.names=1)
bulk <- rbind(bulk1,bulk2)
#if rate is below 0, change to zero
for (row in 1:nrow(bulk)) { 
    if (bulk[row,"average"]<0) {
        bulk[row,"average"] = 0
        bulk[row,"std_dev"] = 0
    }
}
#add factors
bulk_factors <- data.frame("cast_no"=rep("", nrow(bulk)))
bulk_factors$station_no <- gsub(pattern="stn([0-9])-d([0-9])-bulk-([a-zA-Z0-9]+)",replacement="stn\\1",x=rownames(bulk))
bulk_factors$depth_no <- gsub(pattern="stn([0-9])-d([0-9])-bulk-([a-zA-Z0-9]+)",replacement="d\\2",x=rownames(bulk))
bulk_factors$depth_m <- ""

substrates <- gsub(pattern="stn([0-9])-d([0-9])-bulk-([a-zA-Z0-9]+)",replacement="\\3",x=rownames(bulk))
substrates <- gsub("a", "a-glu", substrates)
substrates <- gsub("b", "b-glu", substrates)
substrates <- gsub("p1", "AAF", substrates)
substrates <- gsub("p2", "AAPF", substrates)
substrates <- gsub("p3", "QAR", substrates)
substrates <- gsub("p4", "FSR", substrates)
bulk_factors$substrate <- substrates 

bulk_final <- cbind(bulk_factors, bulk)

#bulk_factors$site <- gsub(pattern="stn([0-9])-d([0-9])-bulk-([a-zA-Z0-9]+)",replacement="stn\\1.d\\2",x=rownames(bulk))
#save as factorsbulk

write.csv(bulk_final, "EN556_plate_RatesWithFactorsBulk.csv",row.names=TRUE)

######################## gf ##########################
gf <- read.csv("EN556_plate_ratesGF.csv",row.names=1)
#if rate below zero, change to zero
for (row in 1:nrow(gf)) { 
    if (gf[row,"average"]<0) {
        gf[row,"average"] = 0
        gf[row,"std_dev"] = 0
    }
}
#add factors
gf_factors <- data.frame("cast_no"=rep("", nrow(gf)))
gf_factors$station_no <- gsub(pattern="stn([0-9])-d([0-9])-GF-([a-zA-Z0-9]+)",replacement="stn\\1",x=rownames(gf))
gf_factors$depth_no <- gsub(pattern="stn([0-9])-d([0-9])-GF-([a-zA-Z0-9]+)",replacement="d\\2",x=rownames(gf))
gf_factors$depth_m <- ""

substrates <- gsub(pattern="stn([0-9])-d([0-9])-GF-([a-zA-Z0-9]+)",replacement="\\3",x=rownames(gf))
substrates <- gsub("a", "a-glu", substrates)
substrates <- gsub("b", "b-glu", substrates)
substrates <- gsub("p1", "AAF", substrates)
substrates <- gsub("p2", "AAPF", substrates)
substrates <- gsub("p3", "QAR", substrates)
substrates <- gsub("p4", "FSR", substrates)
gf_factors$substrate <- substrates

filter_um <- rep("3", nrow(gf))

gf_final <- cbind(gf_factors, gf)
gf_final$filter_um <- filter_um

#save as factorsgf
write.csv(gf_final, "EN556_plate_RatesWithFactorsGF.csv",row.names=TRUE)

######################## lv ##########################
lv <- read.csv("EN556_plate_ratesLV.csv",row.names=1)
#if rate below zero, change to zero
for (row in 1:nrow(lv)) { 
    if (lv[row,"average"]<0) {
        lv[row,"average"] = 0
        lv[row,"std_dev"] = 0
    }
}

#add factors
lv_factors <- data.frame("cast_no"=rep("",nrow(lv)))
lv_factors$station_no <- gsub(pattern="stn([0-9])-d([0-9])-LV-([a-z0-9]+)-subt([0-9])-([a-zA-Z0-9]+)",replacement="stn\\1",x=rownames(lv))
lv_factors$depth_no <- gsub(pattern="stn([0-9])-d([0-9])-LV-([a-z0-9]+)-subt([0-9])-([a-zA-Z0-9]+)",replacement="d\\2",x=rownames(lv))
lv_factors$depth_m <- ""

substrates <- gsub(pattern="stn([0-9])-d([0-9])-LV-([a-z0-9]+)-subt([0-9])-([a-zA-Z0-9]+)",replacement="\\5",x=rownames(lv))
substrates <- gsub("a", "a-glu", substrates)
substrates <- gsub("b", "b-glu", substrates)
substrates <- gsub("p1", "AAF", substrates)
substrates <- gsub("p2", "AAPF", substrates)
substrates <- gsub("p3", "QAR", substrates)
substrates <- gsub("p4", "FSR", substrates)
lv_factors$substrate <- substrates

#this is the subtimepoint that LVs were sampled (not the plate reader timepoint when plate was read)
lv_factors$timepoint <- gsub(pattern="stn([0-9])-d([0-9])-LV-([a-z0-9]+)-subt([0-9])-([a-zA-Z0-9]+)",replacement="t\\4",x=rownames(lv)) 
lv_factors$time_elapsed_hr <- ""

lv_factors$treatment <- gsub(pattern="stn([0-9])-d([0-9])-LV-([a-z]+)([0-9]+)-subt([0-9])-([a-zA-Z0-9]+)",replacement="\\3",x=rownames(lv))
lv_factors$meso_no <- gsub(pattern="stn([0-9])-d([0-9])-LV-([a-z0-9]+)-subt([0-9])-([a-zA-Z0-9]+)",replacement="\\3",x=rownames(lv))

lv_final <- cbind(lv_factors, lv)

#save as factorslv
write.csv(lv_final, "EN556_plate_RatesWithFactorsLV.csv",row.names=FALSE)

#create summary for amend and unamend at each site
#summary <- matrix(dimnames=list(NULL,c("mean","sd",colnames(subsub[,6:11]))),ncol=8)
#for (site in levels(as.factor(lv$site))) {
#    sitesub <- lv[lv$site==site,]
#    for (subtime in levels(as.factor(lv$subt))) {
#        subtsub <- sitesub[sitesub$subt==subtime,]
#        for (sub in levels(as.factor(lv$substrate))) {
#            subsub <- subtsub[subtsub$substrate==sub,]
#            #take new average and mean and insert that in new df
#                
#            }
#        }
#    }
#}
