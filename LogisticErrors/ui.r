library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Logistic Regression Errors"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      numericInput(p0,
                  "P0=",
                  min = 0,
                  max = 1,
			step=0.05,
                  value = 0.5)
		),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))