library(shiny)

# Define server logic required to draw a line of best fit
shinyServer(function(input, output) {

  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
	
	dataInput=reactive({
		bounds=c(-1,runif(1,0,5))
		b1=runif(1,-7,7)
		b0=runif(1,-50,50)
		x=runif(100, bounds[1],bounds[2])
		y=b0+b1*x
		y.rand=y+rnorm(100,0,runif(1,1,10))
		x.d=cbind(rep(1,100),x)
		return(data.frame(x.d=x.d,y.rand=y.rand,x=x,y=y))
	})


  output$distPlot <- renderPlot({
	#set.seed(500+input$reset)
	
	
	
    # draw the histogram with the specified number of bins
	plot(dataInput$x,dataInput$y.rand,col=input$reset*0+1)
	x.d=dataInput$x.d
	y=dataInput$y
	y.rand=dataInput$y.rand
	x=dataInput$x
	abline(input$intercept,input$slope,col=2)
	if(input$done!=input$reset){
		y.hat=(as.numeric(input$intercept)+as.numeric(input$slope)*x)
		beta=solve(t(x.d)%*%x.d)%*% t(x.d)%*%y.rand
		mse=sum((y.rand-x.d%*%beta)^2)/98
		mse.guess=sum((y.rand-y.hat)^2)/98
		if(b1>0){
		text(min(x)+1,max(y.rand),paste("MSE=",as.character(round(mse,3))))
		text(min(x)+1,max(y.rand)-2,paste("MSE(Guess)=",as.character(round(mse.guess,3))))
		text(min(x)+1,max(y.rand)-4,paste("Score=",as.character(round(mse/mse.guess,2)*100)))
		}else{
		text(min(x)+1,min(y.rand)+4,paste("MSE=",as.character(round(mse,3))))
		text(min(x)+1,min(y.rand)+2,paste("MSE(Guess)=",as.character(round(mse.guess,3))))
		text(min(x)+1,min(y.rand),paste("Score=",as.character(round(mse/mse.guess,2)*100)))
		}
		abline(b0,b1,col=3,lty=2)
	}
		
  })
})