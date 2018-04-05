library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Line of Best Fit"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      numericInput("slope",
                  "Slope:",
                  min = -9,
                  max = 9,
			step=0.1,
                  value = 0),
	numericInput("intercept",
                  "Intercept:",
                  min = -80,
                  max =80,
			step=1,
                  value = 0),
	actionButton("done",label="Guess"),
	actionButton("reset",label="Reset")
	),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))