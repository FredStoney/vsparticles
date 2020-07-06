
####################### INPUTS ######################################
# assumes DAve in 7th column
output_dir <- "C:/Users/fpsto/Documents/Work/StoneyForensic/June242020/output/"
my_data_dir <- "C:/Users/fpsto/Documents/Work/StoneyForensic/June242020/Packaging/"
#####################################################################


output <- data.frame( "Specimen Name" = c(), "Number of Particles" = c(), "DAve Mean"=c(), "DAve Variance"=c())
library(tools)
for(data_path in list.files(my_data_dir)){

DAve.data <- read.csv(paste(my_data_dir,data_path, sep = ""))

name <- file_path_sans_ext(basename(data_path))
rows <- nrow(DAve.data)
DAve.col <- DAve.data[,7]
DAve.mean <- mean(DAve.col)
DAve.var <- var(DAve.col)

output <- rbind(output, data.frame( "Specimen Name" = c(name), "Number of Particles" = c(rows), "DAve Mean"=c(DAve.mean), "DAve Variance"=c(DAve.var)))
}

head(output)
data_dir_name <- file_path_sans_ext(basename(my_data_dir))
write.csv(output, file = paste(output_dir,"/DAve-",data_dir_name,".csv", sep = ""), row.names = F)
