library(ggplot2)
library(plyr)
library(zoo)

dat<-readHTMLTable("http://asianbondsonline.adb.org/spreadsheets/RG-LCY_Bond_Market_USD.xls")
dat<-data.frame(dat)
names(dat)<-gsub("NULL.","",names(dat))

for (i in 3:ncol(dat)) {
        dat[,i]<-as.character(dat[,i])
        dat[,i]<-as.numeric(dat[,i])
}

dat$Date<-as.Date(as.yearmon(dat$Date))

dat<-melt(dat,id.vars=c("Date","Market"),variable.name="Entity")

dat$Currency<-rep("USD",nrow(dat))

dat$Currency[grep("LCY",dat$Entity)]<-"LCY"

dat$Entity<-as.character(dat$Entity)

dat$Entity[grep("Government",dat$Entity)]<-"Government"

dat$Entity[grep("Corporate",dat$Entity)]<-"Corporate"

dat$Entity[grep("Total",dat$Entity)]<-"Total"

library(shiny)
shinyServer(
        function(input, output) {
                output$mkt<-renderPrint({input$mkt})
                output$curn<-renderPrint({input$curn})
                output$entype<-renderPrint({input$entype})
                output$newPlot<-renderPlot({
                        mkt<-input$mkt
                        curn<-input$curn
                        entype<-input$entype
                        if (entype=="Total") {
                                plotdat<-dat[dat$Market==mkt & dat$Currency==curn,]
                                ggplot(plotdat,aes(Date,value,color=Entity))+geom_line()+ylab("Billion") +xlab("Year")
                        } else {
                                plotdat<-dat[dat$Market==mkt & dat$Entity==entype & dat$Currency==curn,]
                                ggplot(plotdat,aes(Date,value))+geom_line()+ylab("Billion") +xlab("Year")        
                        }
                })
        }
)