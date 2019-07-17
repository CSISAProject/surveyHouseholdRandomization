
# For Uttar Pradesh PDF files
# to install packages: install.packages(c("pdftools", "data.table", "tidyverse", "plyr", "stringr", "gtools"))
# library(pdftools)
# library(data.table)
# library(tidyverse)
# library(plyr)
# library(stringr)
# library(gtools)
# library(xlsx)
# library(rJava)

# set directory : should manage folder path properly, make sure pdf files are
#                 placed as District > village name > pdf files

parentFolder <- "/Users/apple/Desktop/SurveySampling/Bihar_UP/01restDistricts/Balia/33_CharaKolhua"
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



w <- str_extract_all(y, "मकपन सपखनप : \\d{1,8} | मकपन सनखनप : \\d{1,8}")


u <- str_extract_all(w, "[0-9]+")

x <- lapply(u, unique)
x <- lapply(x, as.integer)
x <- lapply(x, unique)
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


write.csv(q,"33_CharaKolhua.csv", row.names = FALSE, fileEncoding = "UTF-8")


# cheers ! Enjoy automating !! ;)
