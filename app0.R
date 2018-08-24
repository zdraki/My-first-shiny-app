library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(    
  
  titlePanel("Telephones by region and year"),
  
  sidebarLayout(      
    
    
    sidebarPanel(
      
      checkboxGroupInput("variable", "Variables to show:",
                         c("year" = "Year",
                           "region" = "Region"
                         ), selected ='Region'),
      
      selectInput("region", "Region:", 
                  choices=colnames(WorldPhones)),
      selectInput("year", "Year:", 
                  choices=rownames(WorldPhones)),
      hr(),
      helpText("Data from AT&T (1961) The World's Telephones.")
    ),
    
    
    mainPanel(
      plotOutput("phonePlot")  
    )
    
  )
)


# Define server logic required to draw a histogram
library(shiny)

library(datasets)
summary(WorldPhones)
WorldPhones

server <- function(input, output) {
  
  
  output$phonePlot <- renderPlot({
    
    if (input$variable=="Year") {
      #selectedData <- WorldPhones[input$region]
      barplot(WorldPhones[input$year,], 
              main=input$year,
              ylab="Number of Telephones",
              xlab="Region", col='blue')
      
    }
    
    else{
      #selectedData <- WorldPhones[, c(input$year)]
      barplot(WorldPhones[,input$region], 
              main=input$region,
              ylab="Number of Telephones",
              xlab="Year", col='blue')
    }
  })
}



# Run the application 
shinyApp(ui = ui, server = server)

