####################### INPUTS ######################################
# assumes DAve in 7th column
output_dir <- "C:/N9New_05-19-20/N9New OJ-7 2017-IJ-CX-0030/OJ-7 Experiment 5/Output9/"
my_data_dir <- "C:/N9New_05-19-20/N9New OJ-7 2017-IJ-CX-0030/OJ-7 Experiment 5/Cell Phones/"
#####################################################################

for(data_path in list.files(my_data_dir)){
  DAve.data <- read.csv(paste(my_data_dir,data_path, sep = ""))
  
  name <- file_path_sans_ext(basename(data_path))
  
  sorted <- DAve.data[ order(DAve.data[,7]), ]
  quants <- quantile(1:nrow(sorted))
  q1= 1:quants[2]
  q2= (quants[2]+1) : quants[3]
  q3= (quants[3]+1) : quants[4]
  q4= (quants[4]+1) : nrow(sorted)
  
  write.csv( sorted[q1,], file =paste(output_dir,name,"Q1.csv"), row.names = F)
  write.csv( sorted[q2,], file =paste(output_dir,name,"Q2.csv"), row.names = F)
  write.csv( sorted[q3,], file= paste(output_dir,name,"Q3.csv"), row.names = F)
  write.csv( sorted[q4,], file= paste(output_dir,name,"Q4.csv"), row.names = F)
}