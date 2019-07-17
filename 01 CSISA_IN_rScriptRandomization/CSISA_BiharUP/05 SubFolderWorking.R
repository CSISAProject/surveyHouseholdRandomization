#install.packages("rJava", dependencies=TRUE)
# library(xlsx)
# library(dplyr)
# library(tidyverse)
# library(plyr)
# library(stringr)

# Same as file no. 04....

parentFolder <- "/Users/asoc/Desktop/SurveySampling/Bihar_UP/NAWADA"
setwd(parentFolder)

# do.call(file.remove, list(list.files(parentFolder, full.names = T, pattern = "*.csv$", recursive = T)))

files <- list.files(path = parentFolder, full.names = T, recursive = T, pattern = "^[a-zA-Z_]+.csv")
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

saveWorkbook(wb, "finalRandomNumberNAWADA.xlsx")

