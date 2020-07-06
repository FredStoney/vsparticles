####################### INPUTS ######################################
# assumes DAve in 7th column
output_dir <- "C:/Users/fpsto/Documents/Work/StoneyForensic/June242020/output/"
my_data_dir <- "C:/Users/fpsto/Documents/Work/StoneyForensic/June242020/Packaging/"
#####################################################################

for(data_path in list.files(my_data_dir)){
  DAve.data <- read.csv(paste(my_data_dir,data_path, sep = ""))
  
  name <- file_path_sans_ext(basename(data_path))

  write.csv( DAve.data[DAve.data[,7]<=10,], file =paste(output_dir,name,"PM10.csv"), row.names = F)
  write.csv( DAve.data[DAve.data[,7]>10,], file =paste(output_dir,name,"Large.csv"), row.names = F)
  
}