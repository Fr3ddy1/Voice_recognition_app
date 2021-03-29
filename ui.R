shinyUI(

  #fluidPage(
  dashboardPage(title="Voice recognition app",

                #//////////////#
                #/// HEADER ///#
                #//////////////#

                dashboardHeader(title = "Voice recognition", titleWidth = 188

                ),#final dashboardheader

                #///////////////#
                #/// SIDEBAR ///#
                #///////////////#

                dashboardSidebar(

                                 sidebarMenu(id = "tabs",

                                             menuItem(tags$span(id="menu1","Welcome"), icon = icon("door-open"),tabName = "welcome"),
                                             menuItem(tags$span(id="menu2","Filter"), icon = icon("filter"),tabName = "filter"),
                                             menuItem(tags$span(id="menu3","Plot"), icon = icon("image"),tabName = "plot"),
                                             menuItem(tags$span(id="menu4","Map"), icon = icon("globe-americas"),tabName = "map"),
                                             menuItem(tags$span(id="menu5","About"),icon = icon("info-circle"),tabName = "about")


                                 )#final sidebarmenur

                ), #final dashboardsidebar

                #////////////#
                #/// BODY ///#
                #////////////#

                dashboardBody(

                  singleton(tags$head(
                    tags$script(src="//cdnjs.cloudflare.com/ajax/libs/annyang/1.4.0/annyang.min.js"),
                    includeScript('js/init_filter.js'),
                    includeScript('js/init_plot.js'),
                    includeScript('js/init_map.js')
                  )),


                tabItems(

                  #//////////////////#
                  #/// BIENVENIDA ///#
                  #//////////////////#


                  tabItem(tabName = "welcome",

                          fluidPage(id="wel",
                                    includeMarkdown("welcome1.Rmd")
                          )


                  ),#FINAL TABITEM

                  tabItem(tabName = "filter",
                          h3("Inicial table"),
                          DTOutput("table"),
                          h4("Word detected"),
                          verbatimTextOutput("word"),
                          h3("Table filtered"),
                          DTOutput("table1")
                  ),#FINAL TABITEM

                  tabItem(tabName = "plot",
                          h4("Title detected:"),
                          verbatimTextOutput("title"),
                          h4("Colour detected:"),
                          verbatimTextOutput("color"),
                          plotOutput('iris_plot')



                  ),#FINAL TABITEM
                  tabItem(tabName = "map",
                          h4("Country name detected:"),
                          verbatimTextOutput("default"),
                          h4("Available countries:"),
                          verbatimTextOutput("default1"),
                          d3plusOutput("d3_map")
                  ),#FINAL TABITEM

                  tabItem(tabName = "about",
                          fluidPage(id="abo",
                                    includeMarkdown("About.Rmd")
                          )

                  )#FINAL TABITEM

                )#final tabitems
                )#final dashboardbody
  )#final dashboardpage


)
