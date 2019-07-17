# to install packages: install.packages(c("pdftools", "data.table", "tidyverse", "plyr", "stringr", "gtools"))
# 
library(pdftools)
library(data.table)
library(tidyverse)
library(plyr)
library(stringr)
library(gtools)
library(xlsx)
library(rJava)
# set directory : should manage folder path properly, make sure pdf files are
# placed as District > village name > pdf files

parentFolder <- "/Users/asoc/Desktop/SurveySampling/WestBengal/Barddhaman/"
setwd(parentFolder)

# to check the pdf files
list.files(parentFolder)


# setting the file path for the parent folder
readPdf <- file.path(parentFolder)
# listing all the pdf files with full path names
filenames <- list.files(readPdf, pattern = "*.pdf$")
filenames
z <- mixedsort(sort(filenames))

y <- sapply(z, pdf_text)
y
# ************************************************** #

# w <- str_extract_all(y,"????????? ??????????????? : [[:print:]]{1,8}")

w <- str_extract_all(y, " : n \\d{1,10} | : n\\d{1,15} | : n 0\\d{1,15}" )

u <- str_extract_all(w, "[0-9.]+")

x <- lapply(u, unique)

for (i in seq_along(x)) {
  filename = paste(z[[i]],".csv", sep = "")
  write.table(x[i],filename, row.names = FALSE, col.names = "hhID")
  
}


files <- list.files(pattern="*.csv$")

for (f in files){
  p <- read.csv(f, header = T)
  q <- p[sample(nrow(p), 15),]
  #hh = paste0(files[[f]],"RANDOMIZED",".csv", sep = "")
  write.table(q, paste(f, "R1001",".csv", sep = ""), row.names = FALSE, col.names = "Randomized_hhID" )
}

allFiles <- llply(files, read.csv)


combined <- do.call("smartbind", allFiles)

read_csv_filename <- function(files){
  ret <- read.csv(files)
  ret$Source <- files
  ret
}

allFiles <- ldply(files, read_csv_filename)

# for (file in allFiles) {
#   p <- read.csv(combined, header = T, stringsAsFactors = F)
#   q <- sample(p[ ,1], 15, replace = FALSE)
#   write.csv(q, paste0(file,"RANDOM.csv"))
# }

write.csv(allFiles, "finalHHNumber1001.csv", fileEncoding = "UTF-8", row.names = FALSE)

p <- read.csv("finalHHNumber1001.csv", header = T, stringsAsFactors = F)

set.seed(123)
q <- p[sample(nrow(p),15), ]

#q <- sample(p[ ,1], 15, replace = FALSE)


write.csv(q,"17_Raipur.csv", row.names = FALSE)


# cheers ! Enjoy automating !! ;)




