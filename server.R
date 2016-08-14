####################################################################################
# 08/09/16: Coursera 9. Developing Data Products - Course Project
# This is the server file in a two-file packet
#
# Description:
# This is a simple app that can be used to teach a person about the 
# motion in time of a Damped Simple Harmonic Oscilator. The terms in the
# expression describing such motion can all be varied using sliders in the
# app, and additionally a measurement of the amplitude at any 
# point in time on the x-axis can be made using the measurement slider. 
# Red lines highlight the measurement location as measurements are made
####################################################################################


library(shiny)

shinyServer(function(input, output) {

      # set up the time date for the x-axis
      t <- seq(1, 10, by=0.01)
      
      # Calculate the damped oscillation and the envelope functions based on the input sliders 
      y <- reactive({ input$amp * exp(-input$k * t) * cos(2*pi*t/input$T - input$p) })
      y_env <- reactive({ input$amp * exp(-input$k * t) })
      
      amp_measLoc <- reactive({ input$amp * exp(-input$k * input$measLoc)*cos(2*pi*input$measLoc/input$T - input$p) })
      
      # Create the Plot - Oscillation Curve, Upper and lower Envelope Functions, and Identify Measurement Location
      output$dshoPlot <- renderPlot({
            
            # Plot the oscillation
            plot(t, as.numeric(y()),col='blue', type='l', lwd=2, xlab = "Time, t [s]", ylab = "Amplitude, A(t)")
            
            # Plot the upper and lower envelope functions
            lines(t, y_env(), col='green', lwd=2)
            lines(t,-y_env(), col='green', lwd=2)    
            
            # render the origin line, and the identification marker lines to the measurement location
            lines(c(input$measLoc,input$measLoc), c(0,amp_measLoc()), col='red', lwd=3)
            lines(c(0,input$measLoc), c(0,0), col='red', lwd=3)
            lines(c(0,10), c(0,0), lty=2) 
      })
      
      # return the measurement location and the amplitude at that location
      output$measLoc <- renderPrint({ input$measLoc })
      output$amp_measLoc <- renderPrint({ round(amp_measLoc(), 3) })    
      
})
