library(shiny)
library(shinydashboard)
header <- dashboardHeader(title = "مرکز پژوهش‌ها: داشبورد اطلاعات هزینه و درآمد "
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
                          # )
)

sidebar <- dashboardSidebar(
    sidebarMenu(dir="rtl",align="right",
        menuItem("آماره‌های ویژگی‌های افراد", tabName = "indivdemostats", icon = icon("user")),
        menuItem("آماره‌های ویژگی‌های خانوارها", tabName = "hhdemostats", icon = icon("users")),
        menuItem("آماره‌های ویژگی‌های مسکن", tabName = "housestats", icon = icon("home"))
    )
)

body <- dashboardBody(dir="rtl",
    tabItems(
        # First tab content
        tabItem(tabName = "indivdemostats",
                h2("آماره‌های افراد در اینجا!")
        ),

        # Second tab content
        tabItem(tabName = "hhdemostats",
                fluidRow(
                    box(status = "primary",solidHeader = TRUE,
                        title = "انتخاب سال",
                        selectInput(inputId="slcT2Year",label="سال",
                                    choices=list(1396,1397))
                    ),
                    box(status = "primary", solidHeader =TRUE,
                        title = "انتخاب متغیرها",
                        selectInput("slcT2Var","متغیرها",
                                    list(`Education`=list("HLiterate","HStudent","HEduYears"),
                                         `Activity`=list("UHnemployed","HEmployed"),
                                         "Size","NKids","NInfants"),
                                    selected="HEduYears",
                                    multiple=TRUE)
                    ),
                    box(status="primary", solidHeader = TRUE,
                        title = "دسته‌بندی با",
                        selectInput("slcT2Grp","دسته‌بندی با",
                                    list("HSex","Region","ProvinceCode"),
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

        tabItem(tabName = "housestats",
                h2("آماره‌های ویژگی‌های مسکن در اینجا!"))
    )
)

dashboardPage(header, sidebar, body)


