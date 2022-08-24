
library(shiny)
library(shinythemes)
library(lubridate)
ui <- fluidPage(
    theme=shinytheme("cerulean"),
    # Application title
    titlePanel("Pregnancy Due Date Calculator"),

    sidebarLayout(
        sidebarPanel(
            dateInput("lmp", "Indicate the first day of your last period?", value=Sys.Date(), format="dd-mm-yyyy"
            ),
            actionButton("Enter", label = "Check", class="btn-success")
        ),
            
        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                tabPanel("EDD", textOutput("edd"))
        ))
    )
)

server <- function(input, output){
    df <- eventReactive(input$Enter,{
    data.frame(A = as.character(format((input$lmp %m-% months(3) %m+%years(1) + days(7)), "%A %B %d, %Y")))
       
    })
output$edd <- renderText(
   paste ("Your Estimated Date of Delivery is:  ","  ",df()
    ))
}
# Run the application 
shinyApp(ui = ui, server = server)
