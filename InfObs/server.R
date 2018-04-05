library(shiny)

# Define server logic required to draw a line of best fit
shinyServer(function(input, output) {

  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot

  output$distPlot <- renderPlot({
	set.seed(502)
	n=30
	bounds=c(-1,runif(1,0,5))
    	b1=3
	b1.blah=runif(1,-7,7)
	b0=runif(1,-50,50)
    	x=runif(n, bounds[1],bounds[2])
	y=b0+b1*x
	y.rand=y+rnorm(n,0,3.5)
	x.d=cbind(rep(1,n),x)
	ynew=c(y.rand,input$y)
	xnew=c(x,input$x)

    # draw the histogram with the specified number of bins
	plot(x,y.rand,xlim=c(-1.5,9),ylim=c(-52,-30))
	abline(b0,b1,col=1)
	points(input$x,input$y,cex=2,col=2,pch=19)
	x.dnew=rbind(x.d,c(1,input$x))
	betanew=solve(t(x.dnew) %*% x.dnew)%*%t(x.dnew)%*%c(y,input$y)
	sbnew=(sum((ynew-x.dnew%*%betanew)^2)/(n-2))*solve(t(x.dnew) %*% x.dnew)
	abline(betanew[1,1],betanew[2,1],col=2,lty=2)
	lev=diag(x.dnew%*%solve(t(x.dnew) %*% x.dnew)%*%t(x.dnew))[n+1]
	p.val=2*(1-pt(betanew[2,1]/sqrt(sbnew[2,2]),n-2))
	text(5,-42, paste("Slope p-value=",prettyNum(p.val)))
	text(5,-44, paste("Leverage=",round(lev,3)))
	model=lm(ynew~xnew)
	dff=dffits(model)[n+1]
	cooks=cooks.distance(model)[n+1]
	dfbs=dfbetas(model)[n+1,]
	text(5,-46, paste("DFFITS=",round(dff,3)))
	text(5,-48, paste("Cook's Distance=",round(cooks,3)))
	text(5,-50, paste("DFBETA0=",round(dfbs[1],3)))
	text(5,-52, paste("DFBETA1=",round(dfbs[2],3)))
	
		
  })
})