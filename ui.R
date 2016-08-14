####################################################################################
# 08/09/16: Coursera 9. Developing Data Products - Course Project
# This is the ui file in a two-file packet
#
# Description:
# This is a simple app that can be used to teach a person about the 
# motion in time of a Damped Simple Harmonic Oscilator. The terms in the
# expression describing such motion can all be varied using sliders in the
# app, and additionally a measurement of the amplitude at any 
# point in time on the x-axis can be made using the measurement slider. 
# Red lines highlight the measurement location as measurements are made
####################################################################################

# setwd("~/R/coursework/9.DataProducts/Project/shinyApp/")

library(shiny)

shinyUI(fluidPage(
      titlePanel("Damped Simple Harmonic Oscilator Learing Module"),
            sidebarLayout(      
         
            # Define the sliders that will be used to vary the parameters in the expression
            # to product plots of differnt types of damped simple harmonic motion
                  sidebarPanel(
                        sliderInput(inputId = "amp", 
                              label = "Initial Amplitude, A_0", 
                              value = 1, min = 0.0, max = 3.0, step = 0.01), 
            
                        sliderInput(inputId = "k", 
                              label = "Damping Constant, k", 
                              value = 0.2, min = -0.5, max = 3.0, step = 0.01), 
            
                        sliderInput(inputId = "T", 
                              label = "Periodic Time for One Oscillation, [s] ", 
                              value = 1, min = 0.1, max = 5, step = 0.05),
            
                        sliderInput(inputId = "p", 
                              label = "Phase Offset, phi [Radians]", 
                              value = 0.0, min = 0.0, max = 2*pi, step = pi/50),
            
                        sliderInput(inputId = "measLoc", 
                              label = "Time for Amplitude Measurement [s]", 
                              value = 2.1, min = 0, max = 10, step = 0.01)
                  ),
      
                  mainPanel(
                  tabsetPanel(  
                        tabPanel("Simulation", 
                       
                        # Add a brief description of app and detail the expression that is being used to simulate the oscillation dats
                        withMathJax(),
                        helpText("The evolution of the amplitude over time, A(t), for a Damped Simple Harmonic Oscillator 
                                    can be describerd by the following expression: 
                                       $$ A(t) = A_0 e^{-k t} cos(\\omega t - \\phi), \\omega = 2\\pi/T $$ "),
                     
                        # Print the plot being returned from the server file
                        plotOutput("dshoPlot"),
                     
                        # Print measurement data being returned from the server file
                        h5('Selected time for measurement:', textOutput("measLoc")),
                        h5('Amplitude at selected time:', textOutput("amp_measLoc"))
                        ),
                        
                        tabPanel("About", 
                              h4("Application"),
                              p("This is a simple application that demonstrates the motion 
                                    in time of a Damped Simple Harmonic Oscilator. The terms in the
                                    expression describing such motion can all be varied using sliders
                                    to see their effect on the resultant motion over time.  Each time a slider is moved 
                                    the plot updates based on the new parameters.  The motion over time is 
                                    plotted with Amplitude on the y-axis and Time on the x-axis.  Additionally, envelope functions 
                                    are plotted above and below the oscillation curve to illustrate the damping effect"),  
                              
                              p("The user may measure the loocation of the oscillator relative to the center 
                                    of the oscillation at any point in time using the measurement slider.  Red lines 
                                    in the plot highlight the measurement location as the slider is moved and measurements are made
                                    along the curve that the oscillation follows over time"),
                                                            
                              p("The damped simple harmonic oscillator is a fundamental scientific model
                                    that is used to describe or approximate many phenomena in nature.  Understanding of 
                                    this model is a key fundamental requirement for practioners of the physical sciences.  
                                     See the Wikipedia page at the link below:"),
                               
                              a("https://en.wikipedia.org/wiki/Harmonic_oscillator"),
                              
                              h4("Mathematical Expression"),
                              p("A damped simple harmonic oscillator be describerd by the following expression:"), 
                              helpText('  $$ A(t) = A_0 e^{-k t} cos(2\\pi t /T - \\phi) $$ '), 
                              p("where A(t) is the aplitude of the oscillator at any given point in time, t is the time, A0 is the initial amplitude,
                                    k is the damping constant, T is the periodic time for one complete oscillation, and phi is a phase shift parameter.
                                    The first term in the cosine part of the expression is called the frequency, commonly referred to as 'omega'."),
                              
                              br(),
                              p('Developed as part of Coursera - Developing Data Products, August, 2016')
                        )     
                  )
                  )
            )
))