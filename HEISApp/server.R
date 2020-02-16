library(shiny)
library(shinydashboard)
library(data.table)
library(ggplot2)
library(shinyTree)
library(shiny.i18n)
library(DT)
i18n <- Translator$new(translation_csvs_path = "./translations/")
i18n$set_translation_language("fa")

app_server <- function(input, output,session) {
    # List the first level callModules here

    output$treeExp <- renderTree({
        list(
            G01 = list(
                G011 = list(
                    G0111 = list(
                        G0111__1_2 = list(
                            I011111="011111",
                            I011112="011112",
                            I011113="011113",
                            I011114="011114",
                            I011115="011115",
                            I011116="011116",
                            I011117="011117",
                            I011118="011118",
                            I011121="011121",
                            I011122="011122",
                            I011123="011123",
                            I011124="011124",
                            I011125="011124"
                        ),
                        G0111__4_5 = list(
                            I011141="011141",
                            I011142="011142",
                            I011143="011143",
                            I011144="011144",
                            I011151="011151",
                            I011152="011152",
                            I011153="011153",
                            I011154="011154",
                            I011155="011155",
                            I011156="011156"
                        ),
                        G01116="G01116",
                        G01117="G01117"
                    ),
                    G011__2_3="G011__2_3",
                    G0114="G0114",
                    G0115="G0115",
                    G0116="G0116",
                    G0117="G0117",
                    G0118="G0118",
                    G0119="G0119"
                ),
                G012="G012"
            ),
            G02="G02",
            G03="G03",
            G04="G04",
            G05="G05",
            G06="G06",
            G07="G07",
            G08="G08",
            G09="G09",
            G10="G10",
            G11="G11",
            G12="G12"
        )
    })

    output$sel_names <- renderPrint({
        tree <- input$treeExp
        req(tree)
        get_selected(tree)
    })
    output$sel_slices <- renderPrint({
        tree <- input$treeExp
        req(tree)
        get_selected(tree, format = "slices")
    })
    output$sel_classid <- renderPrint({
        tree <- input$treeExp
        req(tree)
        get_selected(tree, format = "classid")
    })
    output$tblT2Stats <- renderDataTable({
        y <- input$slcT2Year
        vs <- input$slcT2Var
        gs <- input$slcT2Grp
        st <- input$slcT2Stat

        fn <- paste0("data/Y",substr(y,3,4),"Merged4CBN.rda")
        load(fn)

        fnc <- get(st)
        vss <- vs
        for(v in names(MD)){
            vss[vss==i18n$t(v)]=v
        }
        SD <- MD[,lapply(.SD,fnc), by=gs,.SDcols=vss]
        setnames(SD,vss,vs)
        SD
    })

    output$pltT2barchart <- renderPlot({

        y <- input$slcT2Year
        vs <- input$slcT2Var
        gs <- input$slcT2Grp
        st <- input$slcT2Stat

        fn <- paste0("data/Y",substr(y,3,4),"Merged4CBN.rda")
        load(fn)

        fnc <- get(st)

        vs[vs==i18n$t("HLiterate")]="HLiterate"
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
