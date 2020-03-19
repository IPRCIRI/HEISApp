library(shiny)
library(shinydashboard)
library(data.table)
library(ggplot2)
library(shinyTree)
library(shiny.i18n)
i18n <- Translator$new(translation_csvs_path = "./translations/")
i18n$set_translation_language("fa")

varlist <- list(`Education`=list(i18n$t("HLiterate"),"HStudent","HEduYears"),
                `Activity`=list("UHnemployed","HEmployed"),
                "Size","NKids","NInfants")
for(n in names(varlist)){
    names(varlist)[names(varlist)==n] <- i18n$t(n)
}
header <- dashboardHeader(title = i18n$t("title")
                          # ,dropdownMenu(type = "messages",
                          #   messageItem(
                          # 	from = "Sales Dept",
                          # 	message = "Sales are steady this month."
                          #   ),
                          #   messageItem(
                          # 	from = "New User",
                          # 	message = "How do I register?",
                          # 	icon = icon("question"),
                          # 	time = "13:45"
                          #   ),
                          #   messageItem(
                          # 	from = "Support",
                          # 	message = "The new server is ready.",
                          # 	icon = icon("life-ring"),
                          # 	time = "2014-12-01"
                          #   )
                          #)
)

 sidebar <- dashboardSidebar(
     sidebarMenu(dir="rtl",align="right",
        menuItem(i18n$t("indivdemostats"), tabName = "indivdemostats", icon = icon("user")),
        menuItem(i18n$t("hhdemostats"), tabName = "hhdemostats", icon = icon("users")),
        menuItem(i18n$t("housestats"), tabName = "housestats", icon = icon("home")),
        menuItem(i18n$t("indivincome"), tabName = "indivincome", icon = icon("home")),
        menuItem(i18n$t("hhincome"), tabName = "hhincome", icon = icon("home")),
        menuItem(i18n$t("hhexpstats"), tabName = "hhexpstats", icon = icon("home"))
     )
)

body <- dashboardBody(dir="rtl",
    tabItems(
        # First tab content
        tabItem(tabName = "indivdemostats",
                h2("آماره های افراد در اینجا")
        ),


        # First tab content
        tabItem(tabName = "hhdemostats",
                fluidRow(
                    box(status = "primary",solidHeader = TRUE,
                        title = "انتخاب سال",
                        selectInput(inputId="slcT2Year",label="سال",
                                    choices=list(1390,1391,1392,1393,
                                                 1394,1395,1396,1397))
                    ),
                    box(status = "primary", solidHeader =TRUE,
                        title = "انتخاب متغیرها",
                        selectInput("slcT2Var","متغیرها",
                                    varlist,
                                    selected="HEduYears",
                                    multiple=TRUE)
                    ),
                    box(status="primary", solidHeader = TRUE,
                        title = "دسته بندی با",
                        selectInput("slcT2Grp","دسته بندی با",
                                    list("HSex","Region","ProvinceCode",
                                    "HMarritalState","HActivityState",
                                    "HEduLevel"),
                                    selected = "Region",
                                    multiple = TRUE)
                    ),
                    box(status="primary", solidHeader = TRUE,
                        title = "آماره",
                        selectInput("slcT2Stat","آماره",
                                    list("mean","median","min","max",
                                         "var","sd","range","sum","IQR"),
                                    selected = "mean",
                                    multiple = FALSE)
                    ),
                    box(status = "primary",solidHeader = TRUE,
                        dataTableOutput("tblT2Stats")),
                    box(status = "primary",solidHeader = TRUE,
                        plotOutput("pltT2barchart"))

                )

        ),

        tabItem(tabName = "hhexpstats",
                textInput(inputId="searchinput",label="جستجو",value=""),
                shinyTree("treeExp",
                          checkbox = TRUE,
                          search = "searchinput",
                          dragAndDrop = FALSE,
                          wholerow = TRUE,
                          multiple = TRUE),
                hr(),
                "Currently Selected:",
                verbatimTextOutput("sel_names"),
                verbatimTextOutput("sel_slices"),
                verbatimTextOutput("sel_classid")
        ),


        tabItem(tabName = "housestats",
                h2("آماره های مسکن در اینجا")),



       # Forth tab content
        tabItem(tabName = "Expendituresstats",
                h2("آماره های هزینه ها در اینجا")),


       # Fifth tab content
        tabItem(tabName = "Incomesstats",
                h2("آماره های درامدها در اینجا"))
)
)
dashboardPage(header, sidebar, body)
