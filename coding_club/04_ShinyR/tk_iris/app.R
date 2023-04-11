# Packages ----
library(shiny)    # Required to run any Shiny app
library(ggplot2)  # For creating pretty plots
library(dplyr)    # For filtering and manipulating data
library(agridat)  # The package where the data comes from

# Loading data ----
Iris <- as.data.frame(iris)
#dim(Iris)
#head(Iris)
#unique(Iris$Species)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("The Iris Species"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(position = "right",
        sidebarPanel(
          
            # input data for histogram
            h4("Inputs for histogram"), 
            selectInput("Species", 
                        "1. Select specie", 
                        choices = c("Setosa" = "setosa",
                                    "Versicolor" = "versicolor",
                                    "Virginica" = "virginica"), 
                        selected = "-"),
            br(),  # break
            
            # color selection for the bins
            selectInput("col", 
                        "2. Select histogram colour", 
                        choices = c("palegreen","lightblue","pink","grey"), 
                        selected = "palegreen"),
            br(),  # break
            
            # number of bins selection
            sliderInput("bins", 
                        "3. Select number of histogram bins", 
                        min=1, 
                        max=25, 
                        value= c(10)),
            br(),  # break
            
            textInput("text", 
                      "4. Enter some text to be displayed", ""),
            
            
        ),
       

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("myViz"),
           tableOutput("myStatsTable"),
           textOutput("myText"),
           
           # hyperlink block
           tags$div(style="color:red",
                    tags$p("Visit author at:"),
                    tags$a(href = "https://sites.google.com/view/tarristique", 
                           "tarristique")
           )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    # creating plot output
    output$myViz <- renderPlot(ggplot(Iris, aes(x = Sepal.Length)) + 
                                 geom_histogram(bins = input$bins, 
                                                fill = input$col, 
                                                group = input$Species,
                                                data = Iris[Iris$Species == input$Species,],
                                                colour = "black") +
                                 labs(x = "Sepal Length", y = "Species"))
    
    # creating statistics table  
    output$myStatsTable <- renderTable(Iris %>%
                                    filter(Species == input$Species) %>%
                                    summarise("Mean" = mean(Sepal.Length), 
                                              "Median" = median(Sepal.Length),
                                              "STDEV" = sd(Sepal.Length), 
                                              "Min" = min(Sepal.Length),
                                              "Max" = max(Sepal.Length)))
    
    # making text output
    output$myText <- renderText(input$text)
    
}

# Run the application 
shinyApp(ui = ui, server = server)

# Run the application from GitHub
# runGitHub(repo = "tk_iris_app", username = "TK51")
