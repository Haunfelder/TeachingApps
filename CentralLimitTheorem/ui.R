library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Central Limit Theorem"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("dist",
                  "Distribution:",
                  choices=c("Normal","Uniform","Skewed"),selected="Normal"),
	numericInput("n","Sample Size:", 5,min=5,max=1000,step=5)
	
	),
	
	
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("histPlot")
    )
  )
))