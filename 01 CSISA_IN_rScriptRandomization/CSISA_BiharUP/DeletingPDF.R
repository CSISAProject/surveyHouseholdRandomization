
# In case, you want to delete all the PDF files (eats up lots of storage on your laptop ! :( )
library(xlsx)
library(dplyr)
library(tidyverse)
library(plyr)
library(stringr)

parentFolder <- "/Users/apple/Desktop/SurveySampling/Bihar_UP/Balia"
setwd(parentFolder)

do.call(file.remove, list(list.files(parentFolder, full.names = T, pattern = "*.pdf$", recursive = T)))
