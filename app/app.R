##
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(icd)

D <- read.table("/cloud/project/2018_I9gem.txt", 
                quote="\"", comment.char="", 
                stringsAsFactors=FALSE)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Converts from ICD9 to ICD10 codes"),
    
    # Sidebar with a slider input for number of bins 
    tabsetPanel(id = "inTabset",
                
                tabPanel("Upload Data",
                         sidebarPanel(
                             helpText("Input an excel file here (.xlsx). We assume the data are in the 
                                  first sheet with titles in the first row. This method does
                                  not work with missing data."),
                             br(),
                             
                             fileInput("file1", "Choose Excel File",
                                       accept = c(
                                           "xls",
                                           "xlsx")
                             ),
                             br(),
                             
                             helpText("In the next tab we will input more information to build
                                  the graph."),
                             actionButton("Tab2", "Go on to the next tab")
                         )),
                
                tabPanel("General Inputs",
                         value = "panel2",
                         
                         sidebarPanel(
                             
                             helpText("Input the type of codes."),
                             
                             radioButtons("parentOrChild", label = h3("Select parent or child maches"),
                                          choices = list("Parent" = 1, "Child" = 0), 
                                          selected = 2),
                             
                             radioButtons("typeOfcode", label = h3("Select the type of Code"),
                                          choices = list("Short" = 1, "Long" = 0), 
                                          selected = 2),
                             actionButton("Tab3", "Go on to the next tab")
                         )),
                
                tabPanel("Matching Variables Info",
                         value = "panel3",
                         sidebarPanel(
                             helpText("Choose variables below to be randomized, then input labels, 
                                  weights, and minimum and maximum for the y-axis for that 
                                  variable. After you've finished hit the Go button to
                                  see the plot. The black line in the plot is the mean difference
                                  for each arm."),
                             
                             br(),
                             
                             actionButton("go", "Go", width = "150px", style = "background-color:red"),
                             br(),
                             
                             helpText("Once suitable weights are found, hit this button to share
                                  the inputs with others."),
                             
                             bookmarkButton(id = "bookmark1", width = "150px"),
                             
                             uiOutput("VarsInput")
                         )),
                
                tabPanel("Download",
                         sidebarPanel(
                             helpText("Use this page to download the matches, and all inputs
                                  used to make them."), 
                             textInput("FN", label = h3("File name:"), 
                                       value = "File name"),
                             textInput("YN", label = h3("Your name:"), 
                                       value = "Your name"),
                             radioButtons('format', 'Document format', c('PDF', 'Word'),
                                          inline = TRUE),
                             downloadButton('downloadReport',"Share matching graph")
                         )),
                
                tabPanel("Matches",
                         sidebarPanel(
                             helpText("Below find the row numbers of the matches. If there 
                                  are an odd number of matching units, the leftover 
                                  is listed first."), 
                             br(),
                             
                             helpText("Check the box below and choose the 
                                  column with labels if you prefer information
                                  that way."),
                             
                             checkboxInput("labs", "Label of your choice"),
                             
                             conditionalPanel(
                                 condition = "input.labs == true",
                                 uiOutput("ID")
                             ),
                             
                             conditionalPanel(
                                 condition = "input.labs == false",
                                 verbatimTextOutput("MA")
                             ),
                             
                             conditionalPanel(
                                 condition = "input.labs == true",
                                 verbatimTextOutput("MAL")
                             )
                         )),
                
                tabPanel("Randomization",
                         sidebarPanel(
                             helpText("A statistician should be consulted prior to randomization.
                                  This app is no replacement, it only facilitates randomization."), 
                             br(),
                             br(),
                             
                             helpText("Seeds force computers to generate the same random numbers. 
                                  Statisticians generate a random seed for each trial that is 
                                  recorded for reproducibility. If your trial needs a seed
                                  please click the box below. If this trial has a seed 
                                  please input it."),
                             
                             checkboxInput("seed", "Generate a seed for this trial"),
                             
                             br(),
                             
                             conditionalPanel(
                                 condition = "input.seed == false",
                                 uiOutput("IS")
                             ),
                             
                             conditionalPanel(
                                 condition = "input.seed == true",
                                 verbatimTextOutput("DS")
                             ),
                             
                             br(),
                             
                             helpText("Input labels for each arm below."),
                             textInput("Arm1", label = h3("First Arm"), 
                                       value = "Treatment"),
                             textInput("Arm2", label = h3("Second Arm"), 
                                       value = "Control"),
                             
                             br(),
                             
                             helpText("Push the button to randomize."),
                             actionButton("rand", "Randomize", width = "150px"),
                             br(),
                             dataTableOutput("Rands")
                             
                         )),
                
                tabPanel("Download Final Plot",
                         sidebarPanel(
                             helpText("This page downloads the final graph to be used 
                                  in publications. Use matches in previous tab to 
                                  randomize. After, input results below. If there 
                                  are any leftovers they are first."), 
                             textInput("FN1", label = h3("File name:"), 
                                       value = "File name"),
                             helpText("Use this button when finished inputting.
                                  A label must be choosen in the 'Matches' tab
                                  for this to work."),
                             downloadButton('downloadReport1',"Final randomization graph"),
                             uiOutput("RanInput")
                         )),
                
                # Show a plot of the generated distribution
                mainPanel(
                    plotOutput("zoom", height = "35px", click = "plot_dblclick"),
                    plotOutput("plot", height = "350px", 
                               brush =  brushOpts(id = "brush", direction = "x"))
                    
                )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    observeEvent(input$Tab2, {
        updateTabsetPanel(session, "inTabset",
                          selected = "panel2")
    })
    
    observeEvent(input$Tab3, {
        updateTabsetPanel(session, "inTabset",
                          selected = "panel3")
    })
    
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        
        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
