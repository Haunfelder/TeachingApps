library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Influential Observation"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      numericInput("x",
                  "X Value:",
                  min = -9,
                  max = 9,
			step=0.1,
                  value = 1.3),
	numericInput("y",
                  "Y value:",
                  min = -50,
                  max =-20,
			step=0.1,
                  value = -37.3)
	),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))