################### ASSUMPTIONS ###########################
# The files in the directory are of type csv
# Each file has particle data beginning at the 37th column
cols_before_particle_data = 36
###########################################################
library(plyr)
library(dplyr)



###### PARAMETERS #########
number_of_elements = 27 #How many element columns are in the dataset?
output_dir <- "C:/Users/fpsto/Documents/Work/StoneyForensic/June242020/output/" # Where will the output csv files go?
my_data_directory <- "C:/Users/fpsto/Documents/Work/StoneyForensic/June242020/Packaging/" # Wheres the Data?
count_output_file <- "C:/Users/fpsto/Documents/Work/StoneyForensic/June242020/output/a.csv"
#area_range <- c(0, 10000) # (lowerbound, upperbound) for area of particles
filename <- "firearms280"  # What would you like to call the file?

threshold_element <- 2
threshold_mass <- 80
############################
# RUN THE FILE

setwd(output_dir)
my_data <- openfiles(my_data_directory)
colnames(my_data) <- sub("\n.*", "", colnames(my_data))
#vars <- c("Area")
firstcounts <- count(as.factor(my_data$location))
colnames(firstcounts) <- c("location", "before_clean")
#area_filtered_data <- my_data %>%
#  filter(
#    .data[[vars[[1]]]] > area_range[[1]],
#    .data[[vars[[1]]]] < area_range[[2]]
#  )

particle.data <- my_data[, -c(1:cols_before_particle_data)]
# clean data
my.clean.data <- cleaner( clean.data.fun(particle.data,  elements.col = 1:number_of_elements, threshold.element = threshold_element, threshold.mass = threshold_mass), number.of.elements = number_of_elements)

secondcounts <- count(as.factor(my.clean.data$location))
colnames(secondcounts) <- c("location", "after_clean")
# filter area

bothcounts <- merge(firstcounts, secondcounts)
write.csv(bothcounts, file = count_output_file)
runProgram(my.clean.data, 1:number_of_elements, outname = filename)

nrow(my_data) # this is the number of total rows of particles before cleaning
nrow(my.clean.data) # number of rows after cleaning
#nrow(area_filtered_data) # number of rows after filtering area

