

library(VSParticles)

openfiles <- function(directory){
  df <- data.frame()
  sub.files <- list.files(directory)
  ext.sub.files <- paste(directory, sub.files, sep = "/")
  
  for (filename in ext.sub.files){
    location <- tools::file_path_sans_ext(basename(filename))
    temp_csv <- read.csv(filename, header = T, comment.char = "", check.names = F)
    temp_csv$location <- location
    temp_csv$sub.location <- 1
    temp_csv$type = "C"
    df <- rbind(df, temp_csv)
  }
  df
}


runProgram <- function(my.clean.data, elements.col, outname){
  origin=1
  type = c("Z","C")
  ratio=2/3
  range.particles=c(0,200000)
  range.area.particles=c(0,1000)
  range.count.particles=c(0,10000)
  my.clean.data$type = "C"
  my.datasets <- create.train.test.datasets.fun(my.clean.data, origin, type, ratio, range.particles, range.area.particles, range.count.particles)
  training.data <- my.datasets[[1]]
  test.data <- my.datasets[[2]]
  
  # create tpts
  
  
  n.class <- 10
  n.subset.training <- 8000
  modelNames = NULL
  my.TPTs.object <- create_TPTs.fun(training.data, elements.col, n.class, n.subset.training, modelNames)
  my.TPTs.training.data <- predict_TPTs.fun(my.TPTs.object,training.data,elements.col=elements.col)
  
  ## create multinomial tables
  my.multinom.data <- create.Multinom.tables.fun(my.TPTs.training.data, origin, type="C")
  my.multinom.train.count <- my.multinom.data[[1]]
  my.multinom.train.prob <- my.multinom.data[[2]]
  
  
  ####################################
  # test the new data
  big.clean <- test.data
  my.TPTs.big <- predict_TPTs.fun(my.TPTs.object,big.clean,elements.col = elements.col)
  dim(my.TPTs.big)
  
  my.TPTs.big$type = "C"
  multinom.big <- create.Multinom.tables.fun(my.TPTs.big, 1, type="C")
  big.count <- multinom.big[[1]]
  big.prob <- multinom.big[[2]]
  
  
  df <- infer.source.fun(big.count[1,],my.multinom.train.prob,lik = T,log.bool = T)
  for (i in 2:nrow(big.count)){
    assign(rownames(big.count)[i],infer.source.fun(big.count[i,],my.multinom.train.prob,lik = T,log.bool = T))
    df <- cbind(df,get(rownames(big.count)[i]))
    rm(list = rownames(big.count)[i])
  }
  colnames(df)<-rownames(big.count)
  head(df)
  
  df2 <- infer.source.fun(big.count[1,], my.multinom.train.prob, lik=FALSE, log.bool=FALSE, prior.vect=NULL)
  for (i in 2:nrow(big.count)){
    assign(rownames(big.count)[i],infer.source.fun(big.count[i,], my.multinom.train.prob, lik=FALSE, log.bool=FALSE, prior.vect=NULL))
    df2 <- cbind(df2,get(rownames(big.count)[i]))
    rm(list = rownames(big.count)[i])
  }
  colnames(df2)<-rownames(big.count)
  head(df2)
  
  write.csv(df,file= paste("/",outname,"LR.csv",sep=""))
  write.csv(df2,file= paste("/",outname,"PP.csv",sep=""))
}
