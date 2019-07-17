library(pdftools)
library(data.table)
library(tidyverse)
library(plyr)
library(stringr)
library(gtools)
library(tesseract)
library(xlsx)
library(rJava)

parentFolder <- setwd("/Users/asoc/Desktop/SurveySampling/Odisha/Mayurbhanj2019/villageVoterFiles_Mayurbhanj/Bahalda")

readPdf <- file.path(parentFolder)

filenames <- list.files(readPdf, pattern = "*.PDF$")
filenames
z <- mixedsort(sort(filenames))
z
y <- sapply(z, pdftools::pdf_convert, dpi=600)

oriya <- tesseract("ori")

text <- sapply(y, tesseract::ocr, engine = oriya)

text

w <- str_extract_all(text, "(?<=ନଂ:)\\d{1,4} | (?<=ନଂ:\\s)\\d{1,4} | (?<=ନଂ2)\\d{1,4} | (?<=ନଂ\\s:\\s)\\d{1,4} | (?<=ନଂ\\s:)\\d{1,4}")
w

# u <- str_extract_all(w, "[0-9]+")
# u
x <- lapply(w, unique)

dt <- do.call("rbind", lapply(x, as.data.frame)) 

dt <- lapply(dt, unique)

dt <- dt[order(dt, decreasing = FALSE)]

dt

for (i in seq_along(dt)) {
  filename = paste(filenames[[i]],"1001",".csv", sep = "")
  write.table(dt[i],filename, row.names = FALSE, col.names = "hhID")
  
}




files <- list.files(pattern="*.csv$")
files
p <- read.csv(files, header = T, stringsAsFactors = F)
q <- p[sample(nrow(p),25), ]

write.csv(q,"Bahalda.csv", row.names = FALSE)


