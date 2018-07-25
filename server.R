
library(shiny)
library(ISLR)
#cleaning wage data marital status and job class
Wage$maritl<-gsub("1. Never Married","Never Married",Wage$maritl )
Wage$maritl<-gsub("2. Married","Married",Wage$maritl )
Wage$maritl<-gsub("3. Widowed","Widowed",Wage$maritl )
Wage$maritl<-gsub("4. Divorced","Divorced",Wage$maritl )
Wage$maritl<-gsub("5. Separated","Separated",Wage$maritl )
Wage$jobclass<-gsub("1. Industrial","Industrial",Wage$jobclass )
Wage$jobclass<-gsub("2. Information","Information",Wage$jobclass )

# Define server logic
shinyServer(function(input, output) {

model_l<-  reactive({

    Wage1<-Wage[(Wage$year==input$year1) & (Wage$maritl==input$maritl1) & (Wage$jobclass==input$jobclass1),]
    xfit<-seq(min(Wage1$wage),max(Wage1$wage),length=40) 
    yfit<-dnorm(xfit,mean=mean(Wage1$wage),sd=sd(Wage1$wage)) 
    h<-hist(Wage1$wage,breaks = 20,col="green",main="Distribution of the wage data based on user's input",
            xlab = "Wage",ylab = "Frequency")
    yfit <- yfit*diff(h$mids[1:2])*length(Wage1$wage) 
    lines(xfit, yfit, col="blue", lwd=2)
    abline(v = mean(Wage1$wage), col = "red", lwd = 2)
  })

output$sum <- renderPrint({
  Wage1<-Wage[(Wage$year==input$year1) & (Wage$maritl==input$maritl1) & (Wage$jobclass==input$jobclass1),]
  summary(Wage1$wage)
})  

output$distPlot <- renderPlot({


    # drawing histogram
    Wage1<-Wage[(Wage$year==input$year1) & (Wage$maritl==input$maritl1) & (Wage$jobclass==input$jobclass1),]
    h<-hist(Wage1$wage,breaks = 20,col="green",main="Distribution of the wage data based on user's input",
            xlab = "Wage",ylab = "Frequency")
    summary(Wage1$wage)
    #call function to draw density and mean line on the histogram.
     model_l()

  })

})
