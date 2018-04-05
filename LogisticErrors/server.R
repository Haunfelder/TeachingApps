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
	set.seed(10)
x=rnorm(40,25,10)
logodds=-2.5-exp(1)+0.3*x+rnorm(40,0,0.5)



##Logistic Regression
samp=function(prob){
sample(c(0,1),size=1,prob=c(1-prob,prob))
}


y=unlist(lapply(1/(1+exp(-logodds)),samp))
plot(x,y,xlab="X",ylab="Y",main="Plot of X vs. Y",yaxt="n")

model2=glm(y~x,family="binomial")


x2=seq(min(x)-1,max(x)+1,0.1)
lines(x2,1/(1+exp(-(coef(model2)[1]+coef(model2)[2]*x2))))


p0=input$p0
lines(c(min(x)-1, (log(p0/(1-p0))-coef(model2)[1])/coef(model2)[2]), c(p0,p0),lty=2)
lines(c((log(p0/(1-p0))-coef(model2)[1])/coef(model2)[2],(log(p0/(1-p0))-coef(model2)[1])/coef(model2)[2]),c(0,max(y)+1),lty=2)
axislabels=sort(c(seq(0,1,0.1),p0))
axislabels[axislabels==p0]=expression(p[0])
axis(2,sort(c(seq(0,1,0.1),p0)),labels=axislabels)
text(25,0.6,paste("p0=",p0))
text(25,0.4,"Success")
text(10,0.4,"Failure")

cols=rep(0,length(x))
cols[(1/(1+exp(-predict(model2))))<p0 & y==0]=1
cols[(1/(1+exp(-predict(model2))))<p0 & y==1]=2
cols[(1/(1+exp(-predict(model2))))>p0 & y==0]=3
cols[(1/(1+exp(-predict(model2))))>p0 & y==1]=4
points(x,y,col=cols)



		
  })
})