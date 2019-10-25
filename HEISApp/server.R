library(shiny)
library(shinydashboard)
library(data.table)
library(ggplot2)
app_server <- function(input, output,session) {
    # List the first level callModules here

    output$tblT2Stats <- renderDataTable({
        y <- input$slcT2Year
        vs <- input$slcT2Var
        gs <- input$slcT2Grp
        st <- input$slcT2Stat

        fn <- paste0("data/Y",substr(y,3,4),"Merged4CBN.rda")
        load(fn)

        fnc <- get(st)

        MD[,lapply(.SD,fnc), by=gs,.SDcols=vs]
    })

    output$pltT2barchart <- renderPlot({

        y <- input$slcT2Year
        vs <- input$slcT2Var
        gs <- input$slcT2Grp
        st <- input$slcT2Stat

        fn <- paste0("data/Y",substr(y,3,4),"Merged4CBN.rda")
        load(fn)

        fnc <- get(st)

        SD <- MD[,lapply(.SD,fnc), by=gs,.SDcols=vs]

        if(length(gs)>1){
            SD[,NewVar:=do.call(paste0,.SD),.SDcols=gs]
            ggplot(SD) +  geom_col(aes_string(x="NewVar",y=vs))

        }else{
            ggplot(SD) +  geom_col(aes_string(x=gs,y=vs))

        }
    })

    session$onSessionEnded(function() {
            stopApp()
        #    q("no")
    })

}
