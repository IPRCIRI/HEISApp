library(shiny)
library(shinydashboard)
header <- dashboardHeader(title = "مرکز پژوهش‌ها: داشبورد اطلاعات هزینه و درآمد ")

sidebar <- dashboardSidebar(
    sidebarMenu(dir="rtl",align="right",
        menuItem("آماره‌های ویژگی‌های خانوارها", tabName = "hhdemostats", icon = icon("users")),
        menuItem("آماره‌های ویژگی‌های افراد", tabName = "indivdemostats", icon = icon("user")),
        menuItem("آماره‌های ویژگی‌های مسکن", tabName = "housestats", icon = icon("home")),
        menuItem("آماره‌های هزینه ها", tabName = "Expendituresstats", icon = icon("money")),
        menuItem("آماره‌های درآمدها", tabName = "Incomesstats", icon = icon("calendar"))
    )
)

body <- dashboardBody(dir="rtl",
    tabItems(


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
                                    list(`Education`=list("HLiterate","HStudent","HEduYears"),
                                         `Activity`=list("UHnemployed","HEmployed",
                                                         "Income without Work","Student",
                                                         "HouseKeeper","Other"),
                                         `Dimension`=list("Size","NKids","NInfants"),
                                         `Time`=list("Month","Quarter")),
                                    selected="Size",
                                    multiple=TRUE)
                    ),
                    box(status="primary", solidHeader = TRUE,
                        title = "دسته‌بندی با",
                        selectInput("slcT2Grp","دسته‌بندی با",
                                    list("HSex","Region","ProvinceCode",
                                         "HMarritalState","HActivityState",
                                         "HEduLevel"),
                                    selected = "Region",
                                    multiple = TRUE)
                    ),
                    box(status="primary", solidHeader = TRUE,
                        title = "آماره",
                        selectInput("slcT2Stat","آماره",
                                    list("mean","median","min","max"),
                                    selected = "mean",
                                    multiple = FALSE)
                    ),
                    box(status = "primary",solidHeader = TRUE,
                        dataTableOutput("tblT2Stats")),
                    box(status = "primary",solidHeader = TRUE,
                        plotOutput("pltT2barchart"))

                )

        ),

        # Second tab content
        tabItem(tabName = "indivdemostats",
                h2("آماره‌های افراد در اینجا!")
        ),

       # Third tab content
        tabItem(tabName = "housestats",
                h2("آماره‌های ویژگی‌های مسکن در اینجا!")),


       # Forth tab content
        tabItem(tabName = "Expendituresstats",
                h2("آماره‌های هزینه ها در اینجا!")),


       # Fifth tab content
        tabItem(tabName = "Incomesstats",
                h2("آماره‌های درامدها در اینجا!"))
)
)
dashboardPage(header, sidebar, body)


