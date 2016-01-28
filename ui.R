
shinyUI(fluidPage(
    titlePanel("Data Classification"),
    sidebarLayout(
        sidebarPanel(
            fileInput('file1', 'Choose file to upload',
                      accept = c(
                          'text/csv',
                          'text/comma-separated-values',
                          'text/tab-separated-values',
                          'text/plain',
                          '.csv',
                          '.tsv'
                      )
            ),
            checkboxInput('header', 'Header', TRUE),
            radioButtons('sep', 'Separator',
                         c(Comma=',',
                           Semicolon=';',
                           Tab='\t'),
                         ','),
            radioButtons('method', 'Classifiction Method',
                         c(None='',
                           'K means Clustering'='kmeans',
                           'Hierarchical Clustering'="hcluster"),
                         '"'),
            numericInput("nclasses",label="Number of classes",value=4,min=2,max=20,step=1),
            tags$hr(),
            p('This application will do a claaification for the data uploaded.For instructions,',
              'please click on',
              a('help', href = './help.html', target="_blank"), 'for details.'
            )
        ),
        mainPanel(
            plotOutput('contents')
        )
    )
))

