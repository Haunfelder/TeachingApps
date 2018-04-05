library(shiny)

# Define server logic required to draw a line of best fit
shinyServer(function(input, output,session) {

  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot

  output$histPlot <- renderPlot({
	x=seq(0,15,0.01)
	plot(x,dnorm(x,input$mu1,1),type="l",lwd=2,col=2)	
	lines(x,dnorm(x,input$mu2,1),lwd=2,col=2)
	abline(v=qnorm(1-input$alpha,input$mu1,1),lty=2)
	polygon(c(x[which(x>qnorm(1-input$alpha,input$mu1,1))[1]],x[x>qnorm(1-input$alpha,input$mu1,1)]),c(0,dnorm(x,input$mu1,1)[x>qnorm(1-input$alpha,input$mu1,1)]),col=2)
	polygon(c(x[x<qnorm(1-input$alpha,input$mu1,1)],x[which(x<qnorm(1-input$alpha,input$mu1,1))[length(which(x<qnorm(1-input$alpha,input$mu1,1)))]]),c(dnorm(x,input$mu2,1)[x<qnorm(1-input$alpha,input$mu1,1)],0),col=3)
	legend(10,0.35,c("Type I Error","Type II Error",paste("Type II Error=",round(pnorm(qnorm(1-input$alpha,input$mu1,1),input$mu2,1),3) ,sep="")),pch=c(15,15,0),col=c(2,3,0))
	text(12,0.2,bquote(H[O]:mu<=.(input$mu1)))
	text(12,0.18,bquote(H[A]:mu>.(input$mu1)))
  })
})