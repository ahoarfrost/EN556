#figures for plate reader results
library(RColorBrewer)
library(ggplot2)

#define substratecolor palette for plots
substrateColors <- brewer.pal(n=7,name="Set2")

############ bulk ##############
bulk <- read.csv("plate_RatesWithFactorsBulk_EN556.csv",row.names=1,header=TRUE)
#change stn1-4 d2 to d5 so it matches stn5-8 bottom 
#for (i in 1:4) {
#    bulk[bulk$stn==paste("stn",i,sep="") & bulk$depthid=="d2","depthid"] <- "d5"
#}

#barplot max rates
png("figures/Bulk_MaxRateBarplot.png",width=1200,height=900)
plot <- ggplot(bulk,aes(x=substrate,y=max_rate)) + geom_bar(aes(fill=substrate),stat="identity") + facet_grid(depthid~stn) + geom_errorbar(aes(ymin=max_rate-max_sd,ymax=max_rate+max_sd),color="grey40",width=0.5) + scale_fill_manual(name=substrate,values=substrateColors) + theme_bw() + theme(text=element_text(size=36),axis.text.x=element_text(size=16,angle=30),legend.title=element_blank(),legend.text=element_text(size=42)) + coord_cartesian(ylim=c(0,150)) + labs(y="max rate (nmol/L/hr)",title="Bulk Max Hydrolysis")
print(plot)
dev.off()
#barplot avg rates
png("figures/Bulk_AvgRateBarplot.png",width=1200,height=900)
plot <- ggplot(bulk,aes(x=substrate,y=avg_potential_rate)) + geom_bar(aes(fill=substrate),stat="identity") + facet_grid(depthid~stn) + geom_errorbar(aes(ymin=avg_potential_rate-avg_sd,ymax=avg_potential_rate+avg_sd),color="grey40",width=0.5) + scale_fill_manual(name=substrate,values=substrateColors) + theme_bw() + theme(text=element_text(size=36),axis.text.x=element_text(size=16,angle=30),legend.title=element_blank(),legend.text=element_text(size=42)) + coord_cartesian(ylim=c(0,80)) + labs(y="avg rate (nmol/L/hr)",title="Bulk Avg Hydrolysis")
print(plot)
dev.off()

#maybe lv vs time plots with a shiny app?

######## GF figs ##########
gf <- read.csv("plate_RatesWithFactorsGF_EN556.csv",row.names=1)
#change stn1-4 d2 to d5 so it matches stn5-8 bottom 
#gf[gf$stn=="stn4" & gf$depthid=="d2","depthid"] <- "d5"

#max rates
png("figures/GF_MaxRateBarplot.png",width=800,height=600)
plot <- ggplot(gf,aes(x=substrate,y=max_rate)) + geom_bar(aes(fill=substrate),stat="identity") + facet_grid(depthid~stn) + geom_errorbar(aes(ymin=max_rate-max_sd,ymax=max_rate+max_sd),color="grey40",width=0.5) + scale_fill_manual(name=substrate,values=substrateColors) + theme_bw() + theme(text=element_text(size=36),axis.text.x=element_text(size=16,angle=30),legend.title=element_blank(),legend.text=element_text(size=42)) + labs(y="max rate (nmol/L/hr)",title="GF Max Hydrolysis")
print(plot)
dev.off()
#avg rates
png("figures/GF_AvgRateBarplot.png",width=800,height=600)
plot <- ggplot(gf,aes(x=substrate,y=avg_potential_rate)) + geom_bar(aes(fill=substrate),stat="identity") + facet_grid(depthid~stn) + geom_errorbar(aes(ymin=avg_potential_rate-avg_sd,ymax=avg_potential_rate+avg_sd),color="grey40",width=0.5) + scale_fill_manual(name=substrate,values=substrateColors) + theme_bw() + theme(text=element_text(size=36),legend.title=element_blank(),axis.text.x=element_text(size=16,angle=30),legend.text=element_text(size=42)) + labs(y="max rate (nmol/L/hr)",title="GF Avg Hydrolysis")
print(plot)
dev.off()

########## LV figs ###########
lv <- read.csv("plate_RatesWithFactorsLV_EN556.csv",row.names=1)

#change stn1-4 d2 to d5 so it matches stn5-8 bottom 
#lv[lv$stn=="stn4" & lv$depthid=="d2","depthid"] <- "d5"

#timeplot max rates
png("figures/LV_Timeplot.png",width=1200,height=1000)
a <- ggplot(lv, aes(x=subt,y=avg_potential_rate,group=substrate)) + facet_grid(treatment~site) + geom_path(aes(color=substrate),stat="identity") 
b <- a + geom_point(aes(color=substrate),size=5,alpha=0.7) + geom_errorbar(aes(ymin=max_rate-max_sd,ymax=max_rate+max_sd, color=substrate),width=0.4,alpha=0.7,size=1) 
c <- b + theme_bw() + scale_color_manual(name=substrate,values=substrateColors) +  theme(text=element_text(size=36),legend.title=element_blank(),axis.text.x=element_text(size=16,angle=30),legend.text=element_text(size=42)) + labs(y="max rate (nmol/L/hr)",title="LV Hydrolysis (Avg=dots;Max=errorbars)")
print(c)
dev.off()

#stacked barchart max rates
png("figures/LV_MaxRateBarplot.png",width=1200,height=1100)
plot <- ggplot(lv, aes(x=subt,y=max_rate,group=substrate)) + facet_grid(treatment~site) + geom_bar(aes(fill=substrate),stat="identity",position="stack") + scale_fill_manual(name=substrate,values=substrateColors) + theme_bw() + theme(text=element_text(size=36),legend.title=element_blank(),axis.text.x=element_text(size=24,angle=30),legend.text=element_text(size=42)) + labs(y="max rate (nmol/L/hr)",title="LV Max Hydrolysis")
print(plot)
dev.off()
#stacked barchart avg rates
png("figures/LV_AvgRateBarplot.png",width=1200,height=1100)
plot <- ggplot(lv, aes(x=subt,y=avg_potential_rate,group=substrate)) + facet_grid(treatment~site) + geom_bar(aes(fill=substrate),stat="identity",position="stack") + scale_fill_manual(name=substrate,values=substrateColors) + theme_bw() + theme(text=element_text(size=36),legend.title=element_blank(),axis.text.x=element_text(size=24,angle=30),legend.text=element_text(size=42)) + labs(y="max rate (nmol/L/hr)",title="LV Avg Hydrolysis")
print(plot)
dev.off()

###combine all amend and all unamend for a particular subt to get lv summary
#split lv into list of dfs by for each site & subtimepoint
new <- split(lv, list(lv$site, lv$subt,lv$substrate))
lv_summary <- data.frame()
for (df in new) {
    #combine amend rows, take avg of each substrate
    df_amend <- df[grep("^amend",df$treatment),]
    df_amend$treatment <- "amend"
    sums_amend <- df_amend[1,]
    sums_amend[,c("max_rate","max_sd","avg_potential_rate","avg_sd")] <- colMeans(df_amend[,c("max_rate","max_sd","avg_potential_rate","avg_sd")])
    
    df_unamend <- df[grep("unamend",df$treatment),]
    df_unamend$treatment <- "unamend"
    sums_unamend <- df_unamend[1,]
    sums_unamend[,c("max_rate","max_sd","avg_potential_rate","avg_sd")] <- colMeans(df_unamend[,c("max_rate","max_sd","avg_potential_rate","avg_sd")])
    
    sums <- rbind(sums_amend,sums_unamend)
    row.names(sums) <- gsub("amend([0-9])","amend",row.names(sums))
    lv_summary <- rbind(lv_summary,sums)
}

#stacked barchart avg rates
png("figures/LV_AvgRateSummaryBarplot.png",width=1000,height=800)
plot <- ggplot(lv_summary, aes(x=subt,y=avg_potential_rate,group=substrate)) + facet_grid(treatment~site) + geom_bar(aes(fill=substrate),stat="identity",position="stack") + scale_fill_manual(name=substrate,values=substrateColors) + theme_bw() + theme(text=element_text(size=36),legend.title=element_blank(),axis.text.x=element_text(size=24,angle=90),legend.text=element_text(size=42)) + labs(y="max rate (nmol/L/hr)",title="LV Avg Hydrolysis (Summary)")
print(plot)
dev.off()
#same plot, diff y axis for lower 
png("figures/LV_AvgRateSummaryBarplot_LowYaxis.png",width=1000,height=800)
plot <- ggplot(lv_summary, aes(x=subt,y=avg_potential_rate,group=substrate)) + facet_grid(treatment~site) + geom_bar(aes(fill=substrate),stat="identity",position="stack") + scale_fill_manual(name=substrate,values=substrateColors) + theme_bw() + theme(text=element_text(size=36),legend.title=element_blank(),axis.text.x=element_text(size=24,angle=90),legend.text=element_text(size=42)) + labs(y="max rate (nmol/L/hr)",title="LV Avg Hydrolysis (Summary)") + coord_cartesian(ylim=c(0,250))
print(plot)
dev.off()

#stacked barchart max rates
png("figures/LV_MaxRateSummaryBarplot.png",width=1000,height=800)
plot <- ggplot(lv_summary, aes(x=subt,y=max_rate,group=substrate)) + facet_grid(treatment~site) + geom_bar(aes(fill=substrate),stat="identity",position="stack") + scale_fill_manual(name=substrate,values=substrateColors) + theme_bw() + theme(text=element_text(size=36),legend.title=element_blank(),axis.text.x=element_text(size=24,angle=90),legend.text=element_text(size=42)) + labs(y="max rate (nmol/L/hr)",title="LV Max Hydrolysis (Summary)")
print(plot)
dev.off()
#same plot, diff y axis for lower 
png("figures/LV_MaxRateSummaryBarplot_LowYaxis.png",width=1000,height=800)
plot <- ggplot(lv_summary, aes(x=subt,y=max_rate,group=substrate)) + facet_grid(treatment~site) + geom_bar(aes(fill=substrate),stat="identity",position="stack") + scale_fill_manual(name=substrate,values=substrateColors) + theme_bw() + theme(text=element_text(size=36),legend.title=element_blank(),axis.text.x=element_text(size=24,angle=90),legend.text=element_text(size=42)) + labs(y="max rate (nmol/L/hr)",title="LV Max Hydrolysis (Summary)") + coord_cartesian(ylim=c(0,350))
print(plot)
dev.off()

##unstacked bar charts for each site
for (site in levels(lv_summary$site)) {
    site_df <- lv_summary[lv_summary$site==site,]
    png(paste("figures/LV_",gsub(".","_",site,fixed=TRUE),"_AvgRate_DodgeBarplot.png", sep=""),width=1000,height=800)
    plot <- ggplot(site_df, aes(x=substrate,y=avg_potential_rate,group=substrate)) + facet_grid(treatment~subt) + geom_bar(aes(fill=substrate),stat="identity",position="dodge") + geom_errorbar(aes(ymin=avg_potential_rate-avg_sd,ymax=avg_potential_rate+avg_sd),color="grey40",width=0.5) + scale_fill_manual(name=substrate,values=substrateColors) + theme_bw() + theme(text=element_text(size=36),legend.title=element_blank(),axis.text.x=element_text(size=24,angle=90),legend.text=element_text(size=42)) + labs(y="max rate (nmol/L/hr)",title=paste(site,"LV Avg Hydrolysis"))
    print(plot)
    dev.off()
}
