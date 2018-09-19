# This is the server logic for a Shiny web application.

library(shiny)
library(ggplot2)
library(dplyr)

######################
# get the data ready #
######################

# import your data 
dat <- read.csv("harbor_sampling_all_yrs.csv")

# convert date to a true date 
dat$date <- as.Date(as.character(dat$date), "%m/%d/%Y")

# make sure numbers are numeric
dat$DO_top_mgL <- as.numeric(as.character(dat$DO_top_mgL))
dat$DO_bot_mgL <- as.numeric(as.character(dat$DO_bot_mgL))
dat$fecal_col_top <- as.numeric(as.character(dat$fecal_col_top))
dat$fecal_col_bot <- as.numeric(as.character(dat$fecal_col_bot))
dat$entero_top <- as.numeric(as.character(dat$entero_top))
dat$enter_bot <- as.numeric(as.character(dat$enter_bot))
dat$secchi_ft <- as.numeric(as.character(dat$secchi_ft))

shinyServer(function(input, output) {

  #dat <- reactive({
  #  dat %>% filter(site==input$site) %>% filter(date>input$date[1]) %>% filter(date<input$date[2])
  #})
  
  #output$counter <- renderText({
  #  if(!file.exists("counter.Rdata"))
  #    counter <- 0
  #  else 
  #    load(file="counter.Rdata")
  #  counter <- counter+1 
  #  save(counter, file="counter.Rdata")
  #  paste0("Page Hits: ", counter)
  #})
  
  
  output$summary_stats <- renderPrint({
    
    # filter data so it's the selected site
    dat <- dat %>% filter(site==input$site)
    
    # filter data so it's the selected date range 
    dat <- dat %>% filter(date>input$date[1]) %>% filter(date<input$date[2])
    
    summary(dat[,input$parameter])
  
  })
  
  
  output$stat_mean <- renderPrint({
    
    # filter data so it's the selected site
    dat <- dat %>% filter(site==input$site)
    
    # filter data so it's the selected date range 
    dat <- dat %>% filter(date>input$date[1]) %>% filter(date<input$date[2])
    
    mean(dat[,input$parameter], na.rm=T)
    
  })
  
  output$bath_viol <- renderPrint({
    # filter data so it's the selected site
    dat <- dat %>% filter(site==input$site)
    
    # filter data so it's the selected date range 
    dat <- dat %>% filter(date>input$date[1]) %>% filter(date<input$date[2])
    
    if(input$parameter=="DO_top_mgL"){
      perc_viol <- round(sum(dat[,input$parameter] < 5, na.rm=T)/ sum(!is.na(dat[,input$parameter])) * 100, digits=2)
    }
    if(input$parameter=="DO_bot_mgL"){
      perc_viol <- round(sum(dat[,input$parameter] < 5, na.rm=T)/ sum(!is.na(dat[,input$parameter])) * 100, digits=2)
    }
    if(input$parameter=="fecal_col_top"){
      perc_viol <- round(sum(dat[,input$parameter] > 200, na.rm=T)/ sum(!is.na(dat[,input$parameter])) * 100, digits=2)
    }
    if(input$parameter=="fecal_col_bot"){
      perc_viol <- round(sum(dat[,input$parameter] > 200, na.rm=T)/ sum(!is.na(dat[,input$parameter])) * 100, digits=2)
    }
    if(input$parameter=="entero_top"){
      perc_viol <- round(sum(dat[,input$parameter] > 35, na.rm=T)/ sum(!is.na(dat[,input$parameter])) * 100, digits=2)
    }
    if(input$parameter=="entero_bot"){
      perc_viol <- round(sum(dat[,input$parameter] > 35, na.rm=T)/ sum(!is.na(dat[,input$parameter])) * 100, digits=2)
    }
    perc_viol
  })
  
  output$fish_viol <- renderPrint({
    # filter data so it's the selected site
    dat <- dat %>% filter(site==input$site)
    
    # filter data so it's the selected date range 
    dat <- dat %>% filter(date>input$date[1]) %>% filter(date<input$date[2])
    
    if(input$parameter=="DO_top_mgL"){
      perc_viol <- round(sum(dat[,input$parameter] < 4, na.rm=T)/ sum(!is.na(dat[,input$parameter])) * 100, digits=2)
    }
    if(input$parameter=="DO_bot_mgL"){
      perc_viol <- round(sum(dat[,input$parameter] < 4, na.rm=T)/ sum(!is.na(dat[,input$parameter])) * 100, digits=2)
    }
    if(input$parameter=="fecal_col_top"){
      perc_viol <- round(sum(dat[,input$parameter] > 2000, na.rm=T)/ sum(!is.na(dat[,input$parameter])) * 100, digits=2)
    }
    if(input$parameter=="fecal_col_bot"){
      perc_viol <- round(sum(dat[,input$parameter] > 2000, na.rm=T)/ sum(!is.na(dat[,input$parameter])) * 100, digits=2)
    }
    if(input$parameter=="entero_top"){
      perc_viol <- NA
    }
    if(input$parameter=="entero_bot"){
      perc_viol <- NA
    }
    perc_viol
  })
  
  output$fish_surviv <- renderPrint({
    # filter data so it's the selected site
    dat <- dat %>% filter(site==input$site)
    
    # filter data so it's the selected date range 
    dat <- dat %>% filter(date>input$date[1]) %>% filter(date<input$date[2])
    
    if(input$parameter=="DO_top_mgL"){
      perc_viol <- round(sum(dat[,input$parameter] < 3, na.rm=T)/ sum(!is.na(dat[,input$parameter])) * 100, digits=2)
    }
    if(input$parameter=="DO_bot_mgL"){
      perc_viol <- round(sum(dat[,input$parameter] < 3, na.rm=T)/ sum(!is.na(dat[,input$parameter])) * 100, digits=2)
    }
    if(input$parameter=="fecal_col_top"){
      perc_viol <- NA
    }
    if(input$parameter=="fecal_col_bot"){
      perc_viol <- NA
    }
    if(input$parameter=="entero_top"){
      perc_viol <- NA
    }
    if(input$parameter=="entero_bot"){
      perc_viol <- NA
    }
    perc_viol  
  })

  output$plot01 <- renderPlot({
    
    # filter data so it's the selected site
    dat <- dat %>% filter(site==input$site)
    
    # filter data so it's the selected date range 
    dat <- dat %>% filter(date>input$date[1]) %>% filter(date<input$date[2])
    
    # plot the data - generic plot 
    p <- ggplot(data=dat, aes_string(x="date", y=input$parameter)) + geom_point() + geom_line()
    p <- p + xlab("Date")
    p <- p + scale_y_continuous(limits=c(0,NA))
    p <- p + scale_x_date(limits=c(input$date[1],input$date[2]))
    p <- p + theme_bw()
    
    # if statements to change labeling 
    if(input$parameter=="DO_top_mgL"){
      p <- p + ylab("Dissolved oxygen, top (mg/L)")
      p <- p + geom_hline(yintercept=3, colour="red", linetype="dashed")
      p <- p + geom_hline(yintercept=4, colour="red", linetype="dashed")
      p <- p + geom_hline(yintercept=5, colour="red", linetype="dashed")
    }
    if(input$parameter=="DO_bot_mgL"){
      p <- p + ylab("Dissolved oxygen, bottom (mg/L)")
      p <- p + geom_hline(yintercept=3, colour="red", linetype="dashed")
      p <- p + geom_hline(yintercept=4, colour="red", linetype="dashed")
      p <- p + geom_hline(yintercept=5, colour="red", linetype="dashed")
    }
    if(input$parameter=="fecal_col_top"){
      p <- p + ylab("Fecal coliform, top (#/100 mL)")
      p <- p + geom_hline(yintercept=200, colour="red", linetype="dashed")
      p <- p + geom_hline(yintercept=200, colour="red", linetype="dashed")

    }
    if(input$parameter=="fecal_col_bot"){
      p <- p + ylab("Fecal coliform, bottom (#/100 mL)")
      p <- p + geom_hline(yintercept=200, colour="red", linetype="dashed")
      p <- p + geom_hline(yintercept=200, colour="red", linetype="dashed")
    }
    if(input$parameter=="entero_top"){
      p <- p + ylab("Enterococcus, top (#/100 mL)")
      p <- p + geom_hline(yintercept=35, colour="red", linetype="dashed")
    }
    if(input$parameter=="enter_bot"){
      p <- p + ylab("Enterococcus, bottom (#/100 mL)")
      p <- p + geom_hline(yintercept=35, colour="red", linetype="dashed")
    }
    
    # plot it 
    p 
    
  })
  
})
