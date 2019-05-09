library(data.table)
library(fs)
library(tidyverse)

fs::dir_create("SampleFiles/")

MakeCSV <- function(FileNumber,records=1000){
  # 1. Create Sample dataset
  FileNumber = str_pad(FileNumber,width = 4,pad = 0)
  SampleData <- tibble(
    Index = 1:records,                                        #Creates an index with the numbers 1 to 100
    Category = sample(LETTERS[1:27],records,replace = TRUE),  #Randomly samples each letter of the alphabet 100 times
                                                              #Replace = T allows for values to be used more than once
                                                              #Use LETTERS for upper case and letters for lower case
                                                              #Letter 27 intentionally chosen to create an NA value in our sample data
    Value = rnorm(records),                                   #Create 100 random normally distributed values
    Value2 = sample(c(1:10,NA),records,replace = TRUE),       #Creates a random number between 1 and 10. 
                                                              #I've also used the c function to add some NA values
    FileNumber = FileNumber
  )
  fwrite(SampleData,str_c("SampleFiles/test",FileNumber,".csv"))
}

system.time(
  1:1000 %>% walk(MakeCSV)
)

system.time(
  dt <- dir("SampleFiles/",full.names = TRUE) %>% map_df(fread)
)
