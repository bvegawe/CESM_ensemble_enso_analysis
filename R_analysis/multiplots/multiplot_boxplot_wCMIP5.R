######################################################
#  file: multiplot_boxplot.R
#  Ben Vega-Westhoff
#  Ryan Sriver
#   - plotting boxplots of stats in R
#       - load in all boxplot arrays
#       - plot those 4-to-a-figure, in paper format
#  Run in R (open R w/ >R on command line)
#  >source("multiplot_boxplot.R")
######################################################

library("stats")
library("magicaxis") #minor ticks
library("Hmisc") #minor ticks

#load in .RData stuff

multiplot_string = "boxplot_multiplot_wCMIP5.pdf"
stats = c("STD","Skewness","NinoCount","NinaCount")
y_axis_strings = c(expression(paste("St. d. (",""*degree,"C)",sep="")),
		"Skewness","Count","Count")
main_strings = c(expression(bold("St. d.")),expression(bold("Skewness")),
		expression(bold(paste("El Ni",tilde("n"),"o events",sep=""))),
		expression(bold(paste("La Ni",tilde("n"),"a events",sep=""))))
time_strings = c("Control","1940-1990","2040-2090","CMIP5 1940-'90","CMIP5 2040-'90")
used_ylim=c(c(0.3,1.4),c(-0.9,0.9),c(3,20),c(3,20))
dim(used_ylim) = c(2,4)

pdf(multiplot_string,14,4)
par(mfrow=c(1,4),oma=c(0,0,0,1),mar=c(7.2,8.8,3,0)+0.1,mgp=c(2,1,0),xpd=NA)
xlabel_y = c(0.2,-1.05,1.7,1.7)
ylabel_offset = c(5.1,4.5,4,4)
for (i in 1:length(stats)){
    load(paste(stats[i],"_boxplot_wCMIP5.RData",sep=""))
    bxp(box_stuff,notch=TRUE,outline=FALSE,
        #main=main_strings[i],font.main=4,
	boxwex=0.5,cex.axis=1.5,cex.main=2.5,cex.lab=1.5,cex.sub=1.5,
	boxlwd="3",medlwd="3",whisklwd="3",staplelwd="3",outlwd="3",
	yaxt="n",ylim=used_ylim[1:2,i],xaxt="n",
        border=c("black","black","black","blue","blue"))
    axis(2,cex.axis=2.5,las=2)
    axis(1,labels = FALSE,tcl=0.5)
    axis(4,labels=FALSE,tcl=0.5)
    mtext(y_axis_strings[i],cex=1.5,side=2,line=ylabel_offset[i])
    text(1:5,xlabel_y[i],cex=1.7,pos=2,offset=-0.6,srt=30,
	labels=time_strings,xpd=TRUE)
    mtext(main_strings[i],font=2,side=3,cex=1.85)
    minor.tick(nx=0,ny=2)
    points(c(2),ersst_val,cex=2.0,lwd=3,pch=4,type="o",col="red")
    #grid(ny = 0,lwd=2)
    #abline(v = c(1,2,3,4,5))
    #print(par("usr")[3]-0.25)
}
dev.off()


