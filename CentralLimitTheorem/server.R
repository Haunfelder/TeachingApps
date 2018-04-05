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
	
cltnorm=function(n,nsim){
	avg=rep(0,nsim)
	for(i in 1:nsim){
		samp=rnorm(n,6,2)
		avg[i]=mean(samp)
	}	
	hist(avg,breaks=30,freq=FALSE,xlim=c(2,10),col=3)
	abline(v=6,col=4,lty=2,lwd=3)
	x=seq(1,12,1/1000)
	y=dnorm(x,6,2)
	lines(x,y,col=2)
}

cltgamma=function(n,nsim){
	avg=rep(0,nsim)
	for(i in 1:nsim){
		samp=rgamma(n,0.5,0.2)
		avg[i]=mean(samp)
	}
	hist(avg,breaks=20,freq=FALSE,col=3,xlim=c(0,8))
	abline(v=2.5,col=4,lty=2,lwd=3)
	x=seq(0,10,1/1000)
	y=dgamma(x,0.5,1/5)
	lines(x,y,col=2)
}


cltunif=function(n,nsim){
	avg=rep(0,nsim)
	for(i in 1:nsim){
		samp=runif(n,1,10)
		avg[i]=mean(samp)
	}
	hist(avg,breaks=30,freq=FALSE,col=3,xlim=c(1,10))
	abline(v=5.5,col=4,lty=2,lwd=3)
	x=seq(1,10,1/1000)
	y=dunif(x,1,10)
	lines(x,y,col=2)
}
	# autoInvalidate <- reactiveTimer(2000, session)
	ind=which(c("Normal","Uniform","Skewed") %in% input$dist)
	#mean=rep(0,20)
	#i=1
	if(ind==1){
		
	#	observe({
	#i=i+1
	#if(i==11){autoInvalidate=NULL}
	#	autoInvalidate()		
	#	x=seq(1,12,1/1000)
	#	y=dnorm(x,6,2)
	#	plot(x,y,cex=0,xlab="Random Variable X",ylab="Density",ylim=c(0,0.30))
	#	lines(x,y,col=2)
	#	abline(v=6,col=4,lty=2,lwd=3)

	
		
		#x=rnorm(input$n,6,2)
		#points(x,rep(0,input$n))
		#abline(v=mean(x),col=3,lwd=3)
		#points(mean(x),0.02,pch=19,col=3,cex=2)
		
			#points(x,rep(0,input$n),col="white")
	#		x=rnorm(input$n,6,2)
	#		points(x,rep(0,input$n))
			#abline(v=mean(x),col=3,lwd=3)
	#		mean[i]=mean(x)
	#		points(mean[1:i],rep(0.02,i),pch=19,col=3,cex=2)
	#		text(8,0.2,bquote(.(i)))
	
	
		#}		
	#})

		cltnorm(input$n,10000)
	}

		
	if(ind==2){cltunif(input$n,10000)}
	if(ind==3){cltgamma(input$n,10000)}

  })
})