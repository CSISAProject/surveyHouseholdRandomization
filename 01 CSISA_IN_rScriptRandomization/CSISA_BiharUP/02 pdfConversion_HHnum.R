# to install packages: install.packages(c("pdftools", "data.table", "tidyverse", "plyr", "stringr", "gtools"))
# 
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

y <- sapply(z, pdf_text)


# ************************************************** #

# w <- str_extract_all(y,"गतह सपखयच : [[:print:]]{1,8}")

w <- str_extract_all(y, "गतह सपखयच : \\d{1,8} | 
                     मकपन सशखनप : \\d{1,8} | मकपन सहखनप : \\d{1,8} | मककन सपखनक : \\d{1,8}  | मकपन सपखयप :  \\d{1,8}  ")
                     
u <- str_extract_all(w, "[0-9.]+")

#w <- str_extract_all(y,"(\\d{1,8}\\W{1,8}[0-9.]+)|(\\d{1,8}\\p{L})|(\\d{1,8})|(\\p{Digit}{1,4}\\W\\p{Digit}{1,4})")


#w <- str_extract_all(y,"(\\p{Digit}{1,4}\\W\\p{Digit}{1,4})|(\\d{1,5})")
#w

# ************************************************** #

#v <- str_extract_all(u, "(\\d{1,8}),(\\d{1,8}\\p{Digit}{1,4}\\S\\d{1,8})|(\\p{Digit}{1,5})|(\\d{1,8})|
#                     (\\d{1,8})\\s(\\p{Letter})|(\\d{1,8}\\w\\p{Letter}\\W\\d{1,8})")


x <- lapply(u, unique)
x
for (i in seq_along(x)) {
  filename = paste(z[[i]],".csv", sep = "")
  write.table(x[i],filename, row.names = FALSE, col.names = "hhID")
  
}




files <- list.files(pattern="*.csv$")
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

q <- p[sample(nrow(p),15), ]

#q <- sample(p[ ,1], 15, replace = FALSE)


write.csv(q,"finalRANDOM.csv", row.names = FALSE)


# cheers ! Enjoy automating !! ;)




