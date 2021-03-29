shinyServer(function(input, output) {

  ##################################################
  ####                                          ####
  ####                                          ####
  #######           FILTER SECTION           #######
  ####                                          ####
  ####                                          ####
  ##################################################

  ##################################################
  #                INICIAL DATAFRAME               #
  ##################################################

  output$table <- renderDT({

      DT::datatable(iris,rownames = FALSE,extensions = 'FixedColumns',
                    options = list(
                      scrollX = TRUE))

  })

  ##################################################
  #                  WORD DETECTED                 #
  ##################################################
  output$word <- renderText({ input$type })

  ##################################################
  #                 FILTERED TABLE                 #
  ##################################################
  output$table1 <- renderDT({

    D <- iris[which(iris$Species==input$type),]

    DT::datatable(D,rownames = FALSE,extensions = 'FixedColumns',
                  options = list(
                    scrollX = TRUE))

  })

  ##################################################
  ####                                          ####
  ####                                          ####
  #######            PLOT SECTION            #######
  ####                                          ####
  ####                                          ####
  ##################################################

  ##################################################
  #                    MAIN PLOT                   #
  ##################################################
  output$iris_plot = renderPlot({
    col = tolower(input$color)
    if (length(col) == 0 || !(col %in% colors())) col = 'gray'
    plot(iris$Sepal.Length,iris$Sepal.Width, main = input$title, col = col, cex = input$bigger, pch = 19)
  })

  ##################################################
  #                 WORDS DETECTED                 #
  ##################################################
  output$title <- renderText({ input$title })

  output$color <- renderText({ tolower(input$color) })


  ##################################################
  ####                                          ####
  ####                                          ####
  #######            MAP SECTION             #######
  ####                                          ####
  ####                                          ####
  ##################################################

  ##################################################
  #                  WORD DETECTED                 #
  ##################################################

  output$default <- renderText({ input$txt })

  ##################################################
  #              AVAILABLE COUNTRIES               #
  ##################################################

  output$default1 <- renderText({
    data("bra_exp_2015")

    mapa <- system.file("extdata", "countries.topojson", package = "D3plusR")
    mapa <- jsonlite::fromJSON(mapa, simplifyVector = F)

    #MAP
    pa <- levels(as.factor(bra_exp_2015$Partner))

    paises <- pa[c(9,18,25,39,40,44,48,61,100,125,145,147,148,60,195,205,209,152,180)]

    return(paises)
  })


  ##################################################
  #                    MAP DATA                    #
  ##################################################
  graf_mapa <- reactive({
    data("bra_exp_2015")

    mapa <- system.file("extdata", "countries.topojson", package = "D3plusR")
    mapa <- jsonlite::fromJSON(mapa, simplifyVector = F)


    #MAP
    pa <- levels(as.factor(bra_exp_2015$Partner))

    paises <- pa[c(9,18,25,39,40,44,48,61,100,125,145,147,148,60,195,205,209,152,180)]


    bra_exp_2015$Partner <- as.factor(bra_exp_2015$Partner)

    a <- which(bra_exp_2015$Partner==input$txt)

    data <- bra_exp_2015[a,]

    #AGREGATE INFO
    data$hab <- round(runif(nrow(data),3000000,15000000))

    data$hab1 <- round(runif(nrow(data),3000000,15000000))

    data$hab2 <- round(runif(nrow(data),3000000,15000000))

    data$hab3 <- round(runif(nrow(data),3000000,15000000))

    data$hab4 <- round(runif(nrow(data),3000000,15000000))

    data$hab5 <- round(runif(nrow(data),3000000,15000000))

    data$hab6 <- round(runif(nrow(data),3000000,15000000))

    data$hab7 <- round(runif(nrow(data),3000000,15000000))

    d3_CAF <- d3plus(data = data,
                     type = "geo_map",
                     id = "Partner.ISO",
                     width = "100%",
                     height = 700) %>%
      d3plusCoords(mapa, projection = "equirectangular") %>%
      d3plusColor(value = "Trade.Value..US..") %>%
      d3plusTooltip(value = c("Trade.Value..US..", "Partner.ISO","name","hab","hab1","hab2","hab3","hab4","hab5","hab6","hab7")) %>%
      d3plusLabels(FALSE) %>%
      d3plusText("Partner") %>%
      d3plusTitle("World Map") %>%
      d3plusZoom(value = TRUE, scroll = FALSE)


    return(d3_CAF)


  })

  ##################################################
  #                  DyNAMIC MAP                   #
  ##################################################
  output$d3_map <- renderD3plus({

    withProgress(message = 'Getting Map', value = 0, {
      incProgress(1/2, detail = "Performing calculations")
      graf_mapa()
    })


  })




}) #FINAL SHINY SERVER
