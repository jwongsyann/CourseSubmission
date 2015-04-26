shinyUI(pageWithSidebar(
        headerPanel("Analyzing the Trends in Bond Issuances for East Asian Countries"),
        sidebarPanel(   
                h3('Select Inputs Here'),
                selectInput("mkt", "Country",
                                   c("Hong Kong" = "HK",
                                     "Korea" = "KR",
                                     "Thailand" = "TH",
                                     "Singapore" = "SG",
                                     "China" = "CN",
                                     "Indonesia" = "ID",
                                     "Japan" = "JP",
                                     "Vietnam" = "VN",
                                     "Malaysia" = "MY",
                                     "Philippines" = "PH"),
                            selected="HK",
                            multiple=FALSE),
                selectInput("entype", "Entity Type",
                            c("Government" = "Government",
                              "Corporate" = "Corporate",
                              "All Entities" = "Total"),
                            selected="govt",
                            multiple=FALSE),
                selectInput("curn", "Currency Type",
                            c("Local Currency" = "LCY",
                              "US Dollar" = "USD"),
                            selected="USD",
                            multiple=FALSE),
                submitButton("Submit")
        ),
        mainPanel(
                h3("Selection Chosen"),
                h5("You selected the bond issuances for"),
                verbatimTextOutput("entype"),
                h5("in"),
                verbatimTextOutput("mkt"),
                h5("in"),
                verbatimTextOutput("curn"),
                plotOutput("newPlot")
        )
))

