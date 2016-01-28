options(shiny.maxRequestSize = 9*1024^2)
library(ggplot2)
library(reshape2)
library(cluster)

shinyServer(function(input, output) {


   
        
 
    output$contents <- renderPlot({
        # input$file1 will be NULL initially. After the user selects
        # and uploads a file, it will be a data frame with 'name',
        # 'size', 'type', and 'datapath' columns. The 'datapath'
        # column will contain the local filenames where the data can
        # be found.
        
        method<- as.character(input$method)
        
        inFile <- input$file1
        
        if (is.null(inFile))
            return(NULL)
        
        data<-read.csv(inFile$datapath, header = input$header,
                       sep = input$sep)

        n<- nrow(data)
        index<- seq(1,n)
        df<- cbind(index,data)
        
        if(method=="")
        {

            df<- melt(df,id.vars="index",variable.name='series')
            ggplot(df,aes(index,value))+geom_line()+facet_grid(series~.)
        }
        else if(method=="kmeans")
        {
            kc<- kmeans(data,centers=input$nclasses)
            clusplot(data,kc$cluster,color=TRUE,shade=TRUE,labels =2)
            
        }
        else
        {
            dd<- dist(data)
            h<- hclust(dd)
            plot(h)
        }

    })
})