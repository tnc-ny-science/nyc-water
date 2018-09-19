# This is the user-interface definition of a Shiny web application.

library(shiny)

shinyUI(fluidPage(
  
  # Google analytics tag
  # tags$head(includeScript("google-analytics.js")),

  # Google analytics tag
  tags$head(HTML(
    "<script>
    (function(i,s,o,g,r,a,m){
    i['GoogleAnalyticsObject']=r;i[r]=i[r]||
    function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();
    a=s.createElement(o), m=s.getElementsByTagName(o)[0];
    a.async=1;
    a.src=g;m.parentNode.insertBefore(a,m)
    })
    (window, document, 'script',
    '//www.google-analytics.com/analytics.js','ga');
    
    ga('create', 'UA-58304245-2', 'auto');
    ga('send', 'pageview');
    
    </script>"
  )),
  
  # Application title
  titlePanel("NYC DEP Harbor Water Quality Data Visualization"),

  # Sidebar with widgets for subsetting the data 
  sidebarLayout(
    sidebarPanel(
      
      # select site 
      selectInput("site",
                  "Sampling Station",
                  choices=list(
                    "AC1: Alley Creek & Northern Blvd."="AC1",
                    "AC2: Alley Creek Outfall"="AC2",
                    "BB2: Head of Bergen Basin"="BB2",
                    "BB4: Mouth of Bergen Basin"="BB4",
                    "BR1: 233rd St & Bronx River"="BR1",
                    "BR3: Westchester Ave & Bronx River"="BR3",
                    "BR5: Mouth of Bronx River"="BR5",
                    "CIC2: Cropsy Ave & Coney Island Creek"="CIC2",
                    "CIC3: Coney Island Creek"="CIC3",
                    "E10: Hart Island"="E10",
                    "E11: Little Neck Bay"="E11",
                    "E12: Eastchest Bay Buoy N6"="E12",
                    "E13: Westerchester Creek Buoy N2"="E13", 
                    "E14: Mouth of Bronx River Buoy N2"="E14",
                    "E15: Flushing Bay South Buoy N2"="E15",
                    "E2: E. 23rd Street"="E2",
                    "E4: Hell Gate"="E4",
                    "E6: Flushing Bay"="E6",
                    "E7: Whitestone Bridge"="E7",
                    "E8: Throg's Neck Bridge"="E8",
                    "EJ1: Barbadoes Basin Head"="EJ1",
                    "EJ2: Barbardoes Basin Mouth"="EJ2",
                    "EJ3: Vernam Basin"="EJ3",
                    "EJ4: Brant Point Wildlife Sanctuary"="EJ4",
                    "EJ5: Thursby Basin Park"="EJ5",
                    "EJ6: Dubos Point"="EJ6",
                    "EJ7: Rockaway Community Park"="EJ7",
                    "EJ8: Bayswater Park"="EJ8",
                    "EJ9: Bayswater State Park"="EJ9",
                    "F1: Head of Fresh Creek"="F1",
                    "F5: Mouth of Fresh Creek"="F5",
                    "FB1: Flushing Bay North"="FB1",
                    "FLC1: Flushing Creek"="FLC1",
                    "FLC2: Mouth of Flushing Creek"="FLC2",
                    "G2: Gowanus Canal"="G2",
                    "GB1: Gravesend Bay"="GB1",
                    "GC3: Union Street Bridge"="GC3",
                    "GC4: Carroll Street Bridge"="GC4",
                    "GC5: 3rd Street Bridge"="GC5",
                    "GC6: 9th Street Bridge"="GC6",
                    "GHC: Grass Hassock Channel" = "GHC",
                    "H3: E. 155th Street"="H3",
                    "HC1: Hendrix Creek Head"="HC1",
                    "HC2: Hendrix Creek by 26th Ward Outfall"="HC2",
                    "HC3: Hendrix Creek under Belt Pkwy"="HC3",
                    "HOB: Head of Bay" = "HOB",
                    "HR03: Conner Street Pump Station"="HR03",
                    "HR1: Batown Av. Br. & Hutchinson River Pkwy"="HR1",
                    "HR2: Boston Rd. & Conner Av."="HR2",
                    "J1: Rockaway Inlet"="J1",
                    "J10: Paerdegat Basin"="J10",
                    "J11: Sheepshead Bay"="J11",
                    "J12: Grassy Bay"="J12",
                    "J13: (Unspecified location)" = "J13",
                    "J14: West of Broad Channel"="J14",
                    "J15: Pumpkin Patch Channel" = "J15",
                    "J16: Horse Channel"="J16",
                    "J17: (Unspecified location)" = "J17",
                    "J2: Mill Basin"="J2",
                    "J3: Canarsie Pier"="J3",
                    "J5: Railroad Trestle"="J5",
                    "J7: Bergen Basin"="J7",
                    "J8: Spring Creek"="J8",
                    "J9A: Fresh Creek Buoy C21"="J9A",
                    "JA1: Jamaica Bay WWTP Outfall"="JA1",
                    "K1: St. George"="K1",
                    "K2: Shooters Island"="K2",
                    "K3: A&K Railroad Bridge"="K3",
                    "K4: Fresh Kills"="K4",
                    "K5: Tottenville"="K5",
                    "K5A: Raritan River"="K5A",
                    "K6: Old Orchard Light"="K6",
                    "LN1: Little Neck Bay South"="LN1",
                    "N1: Mt. St. Vincent"="N1",
                    "N16: Rockaway Point"="N16",
                    "N3B: W. 125th Street"="N3B",
                    "N3C: Whale Creek" = "N3C",
                    "N4: W. 42nd Street"="N4",
                    "N5: Pier A - The Battery"="N5",
                    "N6: Bell Buoy 31"="N6",
                    "N7: Robbins Reef"="N7",
                    "N8: The Narrows Buoy 28"="N8",
                    "N9: Steeplechase Pier"="N9",
                    "N9A: Coney Is. Outfall"="N9A",
                    "NC0: English Kills"="NC0",
                    "NC1: Maspeth Creek"="NC1",
                    "NC2: Amoco Tank Farm"="NC2",
                    "NC3: Whale Creek"="NC3",
                    "NCO: English Kills" = "NCO",
                    "NR1: North River WWTP"="NR1",
                    "PB2: Middle of Paerdegat  Basin"="PB2",
                    "PB3: Mouth of Paerdegat Basin"="PB3",
                    "SP1: Spring Creek Head"="SP1",
                    "SP2: Spring Creek under Belt Pkwy."="SP2",
                    "TB1: Thurston Basin"="TB1",
                    "TB2: Thurston Basin Mouth"="TB2",
                    "WC1: WC Bruckner & Cross Bx. Exps."="WC1",
                    "WC2: South Bound Hutchinson Pkwy"="WC2",
                    "WC3: Buoy 10"="WC3"
                  )),
      
      # select variable 
      selectInput("parameter",
                  "Water quality parameter",
                  choices=list(
                    "Dissolved oxygen, top (mg/L)" = "DO_top_mgL",
                    "Dissolved oxygen, bottom (mg/L)" = "DO_bot_mgL",
                    "Fecal coliform, top" = "fecal_col_top",
                    "Fecal coliform, bottom" = "fecal_col_bot",
                    "Enterococcus, top" = "entero_top",
                    "Enterococcus, bottom" = "enter_bot"
                  )),
      
      # select date range 
      dateRangeInput("date",
                  "Date range",
                  start="2012-01-01",
                  end=Sys.Date(),
                  format = "yyyy-mm-dd")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",     
        
        ################# 
        # Main data tab #
        #################
        tabPanel(title="Data",
                           
          plotOutput("plot01", width=800), 
    
          h6("Red lines indicate NYS DEC or EPA Water Quality Standards"),
          
          br(),
          h4("Summary Statistics"),
          verbatimTextOutput("summary_stats"),
          h6("'Min.'= minimum, '1st Qu.' = 1st quartile, '3rd Qu.' = 3rd quartile, 'Max.' = maximum, 'NA's' = # of missing values"),
          
          br(),
          h4("Percentage of Samples that Violate Bathing Standards:"),
          verbatimTextOutput("bath_viol"),
          
          br(),
          h4("Percentage of Samples that Violate Fishing/Boating Standards:"),
          verbatimTextOutput("fish_viol"),
          
          br(),
          h4("Percentage of Samples that Violate Fish Survival Standardss:"),
          verbatimTextOutput("fish_surviv"),
          
          br(),
          h4("NYS DEC/EPA Water Quality Standards"),
          img(src="WQ_standards.png", width=800)
        ),
        
        ####### 
        # Map #
        ####### 
        tabPanel(title="Map",
         img(src="harbor_sampling_map.jpg", height=600, width=800)
        ),
        
        ########
        # Info #
        ######## 
        tabPanel(title="Info",
          HTML("<strong>Data source:</strong>"),
          HTML("<a href='http://www.nyc.gov/html/dep/html/harborwater/harbor_water_sampling_results.shtml'>NYC Dept. of Environmental Protection Harbor Water Quality Survey</a>"),
          br(),
          HTML("<strong>Data downloaded:</strong> 8/28/2018"),
          br(),
          br(),
          HTML("Data visualizations are for exploratory purposes."),
          br(),
          HTML("Data should be further QA/QCed for in-depth analyses."),
          br(),
          br(),
          HTML("<strong>Please direct any comments, questions, or error reports to:</strong>"),
          br(),
          HTML("Mike McCann, Ph.D."),
          br(),
          HTML("michael.mccann@tnc.org")
        )
      )
    )
  )
))
