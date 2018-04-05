library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Type I and Type II errors"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel("Null Distribution",
      numericInput("mu1","Mean:", 6,min=3,max=8),
	numericInput("alpha","Significance Level:", 0.05,min=0.001,max=0.5,step=0.01),

	
	"Alternative Distribution",
      numericInput("mu2","Mean:", 8,min=4,max=10)

	
	),	
	
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("histPlot")
    )
  )
))