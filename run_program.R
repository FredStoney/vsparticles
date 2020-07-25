################### ASSUMPTIONS ###########################
# The files in the directory are of type csv
# Each file has particle data beginning at the 37th column
cols_before_particle_data = 36
###########################################################
library(dplyr)


###### PARAMETERS #########
number_of_elements = 27 #How many element columns are in the dataset?
output_dir <- "C:/N9New_05-19-20/N9New OJ-7 2017-IJ-CX-0030/OJ-7 Experiment 5/Output/" # Where will the output csv files go?
my_data_directory <- "C:/N9New_05-19-20/N9New OJ-7 2017-IJ-CX-0030/OJ-7 Experiment 5/Packaging/" # Wheres the Data?
area_range <- c(0, 10000) # (lowerbound, upperbound) for area of particles
filename <- "packaging"  # What would you like to call the file?
threshold_element <- 5
threshold_mass <- 60
############################
# RUN THE FILE

setwd(output_dir)
my_data <- openfiles(my_data_directory)
colnames(my_data) <- sub("\n.*", "", colnames(my_data))
vars <- c("Area")


area_filtered_data <- my_data %>%
  filter(
    .data[[vars[[1]]]] > area_range[[1]],
    .data[[vars[[1]]]] < area_range[[2]]
  )

particle.data <- area_filtered_data[, -c(1:cols_before_particle_data)]
# clean data
my.clean.data <- clean.data.fun(particle.data,  elements.col = 1:number_of_elements, threshold.element = threshold_element, threshold.mass = threshold_mass)

# filter area


runProgram(area_filtered_data, 1:number_of_elements, outname = filename)

nrow(my_data) # this is the number of total rows of particles before cleaning
nrow(my.clean.data) # number of rows after cleaning
nrow(area_filtered_data) # number of rows after filtering area

