# to install packages: install.packages(c("pdftools", "data.table", "tidyverse", "plyr", "stringr", "gtools"))
# download and install following libraries
# library(pdftools)
# library(data.table)
# library(tidyverse)
# library(plyr)
# library(stringr)
# library(gtools)
# library(xlsx)

# set directory : should manage folder path properly, make sure pdf files are
#                 placed as District > village name > pdf files

parentFolder <- "/Users/apple/Desktop/SurveySampling"
setwd(parentFolder)

# to check the pdf files
list.files(parentFolder)

# setting the file path for the parent folder
readPdf <- file.path(parentFolder)

# listing all the pdf files with full path names
filenames <- list.files(readPdf, pattern = "*.pdf$")

z <- mixedsort(sort(filenames))

# convert pdf files into plain text format
y <- sapply(z, pdf_text)

# look for the patterns of household numbers in hindi
# easy way to check the spelling in unicode from the file is to copy the name
# GRIHA SANKHYA and paste it in the find (Ctrl + F) textbox. And then copy and paste it

w <- str_extract_all(y, "गतह सपखयच : \\d{1,8} | 
                     मकपन सशखनप : \\d{1,8} | मकपन सहखनप : \\d{1,8} | मककन सपखनक : \\d{1,8}  | मकपन सपखयप :  \\d{1,8}  ")
                     
u <- str_extract_all(w, "[0-9.]+")

# remove duplicate Household numbers 

x <- lapply(u, unique)
x

# paste the numbers in respective village file names
for (i in seq_along(x)) {
  filename = paste(z[[i]],".csv", sep = "")
  write.table(x[i],filename, row.names = FALSE, col.names = "hhID")
  
}

# to combine all village csv files into one file 

files <- list.files(pattern="*.csv$")
allFiles <- llply(files, read.csv)
combined <- do.call("smartbind", allFiles)

read_csv_filename <- function(files){
  ret <- read.csv(files)
  ret$Source <- files
  ret
}

allFiles <- ldply(files, read_csv_filename)

write.csv(allFiles, "finalHHNumber1001.csv", fileEncoding = "UTF-8", row.names = FALSE)

p <- read.csv("finalHHNumber1001.csv", header = T, stringsAsFactors = F)

q <- p[sample(nrow(p),15), ]

write.csv(q,"finalRANDOM.csv", row.names = FALSE)


# cheers ! Enjoy automating !! ;)
