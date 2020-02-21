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
                        G01111 = list(
                            I011111="011111",
                            I011112="011112",
                            I011113="011113",
                            I011114="011114",
                            I011115="011115",
                            I011116="011116",
                            I011117="011117",
                            I011118="011118"
                        ),
                        G01112 = list(
                          I011121="011121",
                          I011122="011122",
                          I011123="011123",
                          I011124="011124",
                          I011125="011125"
                        ),
                        G01114 = list(
                            I011141="011141",
                            I011142="011142",
                            I011143="011143",
                            I011144="011144"
                        ),
                        G01115 = list(
                          I011151="011151",
                          I011152="011152",
                          I011153="011153",
                          I011154="011154",
                          I011155="011155",
                          I011156="011156"
                        ),
                        G01116= list(
                          I011161="011161",
                          I011162="011162",
                          I011163="011163",
                          I011164="011164",
                          I011165="011165",
                          I011166="011166"
                        ),
                        G01117=list(
                          I011171="011171",
                          I011172="011172",
                          I011173="011173",
                          I011174="011174",
                          I011175="011175"
                        )
                    ),
                    G0112 = list(
                      G01121 = list(
                        I011211="011211",
                        I011212="011212",
                        I011213="011213",
                        I011214="011214",
                        I011215="011215",
                        I011216="011216",
                        I011217="011217",
                        I011218="011218"
                         ),
                      G01122 = list(
                        I011221="011221",
                        I011222="011222",
                        I011223="011223",
                        I011224="011224"
                        ),
                      G01123= list(
                        I011231="011231",
                        I011232="011232",
                        I011233="011233",
                        I011234="011234",
                        I011235="011235",
                        I011236="011236",
                        I011237="011237",
                        I011238="011238",
                        I011239="011239"
                      ),
                      G01124=list(
                        I011241="011241",
                        I011244="011244",
                        I011247="011247"
                      )
                    ),
                    G0113 = list(
                      G01131 = list(
                        I011311="011311",
                        I011312="011312",
                        I011313="011313",
                        I011314="011314",
                        I011315="011315",
                        I011316="011316",
                        I011317="011317",
                        I011318="011318",
                        I011319="011319"
                      ),
                      G01132 = list(
                        I011321="011321"
                      )
                    ),
                    G0114 = list(
                      G01141 = list(
                        I011411="011411",
                        I011412="011412",
                        I011413="011413",
                        I011414="011414"
                      ),
                      G01142 = list(
                        I011421="011421",
                        I011422="011422",
                        I011423="011423",
                        I011424="011424",
                        I011425="011425",
                        I011426="011426",
                        I011427="011427",
                        I011428="011428",
                        I011429="011429"
                      ),
                      G01143= list(
                        I011431="011431",
                        I011432="011432",
                        I011433="011433",
                        I011434="011434"
                      ),
                      G01144=list(
                        I011441="011441",
                        I011442="011442",
                        I011443="011443"
                      )
                    ),
                    G0115="G0115",
                    G0116="G0116",
                    G0117="G0117",
                    G0118="G0118",
                    G0119="G0119"
                ),
                G012=list(
                  G0121 = list(
                    G01211 = list(
                      I012111="012111",
                      I012112="012112",
                      I012113="012113",
                      I012114="012114"
                    )
                    ),
                    G0122 = list(
                    G01221 = list(
                      I011221="011221",
                      I011222="011222",
                      I011223="011223",
                      I011224="011224",
                      I011225="011225",
                      I011216="011226",
                      I011218="011228"
                )
                    )
                )
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

        fn <- paste0("data/Y",substr(y,3,4),"MergedData.rda")
        load(fn)

        fnc <- get(st)
        vss <- vs
        for(v in names(MergedData)){
            vss[vss==i18n$t(v)]=v
        }
        SD <- MergedData[,lapply(.SD,fnc), by=gs,.SDcols=vss]
        setnames(SD,vss,vs)
        SD
    })

    output$pltT2barchart <- renderPlot({

        y <- input$slcT2Year
        vs <- input$slcT2Var
        gs <- input$slcT2Grp
        st <- input$slcT2Stat

        fn <- paste0("data/Y",substr(y,3,4),"MergedData.rda")
        load(fn)

        fnc <- get(st)

        vs[vs==i18n$t("HLiterate")]="HLiterate"
        SD <- MergedData[,lapply(.SD,fnc), by=gs,.SDcols=vs]

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
