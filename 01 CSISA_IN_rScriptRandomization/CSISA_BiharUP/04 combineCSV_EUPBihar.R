#install.packages("rJava", dependencies=TRUE)
# library(xlsx)
# library(dplyr)
# library(tidyverse)
# library(plyr)
# library(stringr)

parentFolder <- "/Users/apple/Desktop/SurveySampling/Bihar_UP/Balia"
setwd(parentFolder)

files <- list.files(path = parentFolder, full.names = T, recursive = T, pattern = "^[0-9a-zA-Z_]+.csv")
files
for (f in files) {
  file.copy(from = f, to = parentFolder)
}

allVill <- list.files(parentFolder, pattern = "*.csv$")
allVill
wb <- createWorkbook()

for (i in allVill) {
  sheet <- createSheet(wb, sheetName = (i))
  addDataFrame(read.csv(i), sheet)
}

saveWorkbook(wb, "finalRandomNumberBalia.xlsx")

