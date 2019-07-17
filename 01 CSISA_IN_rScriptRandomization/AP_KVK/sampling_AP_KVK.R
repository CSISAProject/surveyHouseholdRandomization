# load the following libraries ----
library(pdftools)			
library(data.table)
library(tidyverse)
library(plyr)
library(stringr)
library(gtools)
library(tesseract)
library(xlsx)
# dyn.load('/Library/Java/JavaVirtualMachines/jdk-11.0.2.jdk/Contents/Home/jre/lib/server/libjvm.dylib')
library(rJava)

# set working directory where the village pdf files are located ----
parentFolder <- setwd("/Users/asoc/Desktop/CSISA_2019/CSISA_IN/AP_KVK/Anantapur/Vankarakunta")

# first you need to change the pdf format to png if the files are not extractable ----
filenames <- list.files(parentFolder, pattern = "*.pdf$")

filenames <- list.files(parentFolder, pattern = "*.png$")
filenames
z <- mixedsort(sort(filenames))
y <- sapply(z, pdftools::pdf_convert, dpi=300)

# after you have changed the files to png ----
filenames <- list.files(parentFolder, pattern = "*.png$")
filenames
text <- sapply(y, tesseract::ocr)
text

# look for the pattern of "House Number" in the extracted text
w <- str_extract_all(text, "House Number : [[0-9][A-O][—][/][-][ ][.][~]]{1,9} | House Number [[0-9][A-O][—][/][-][ ][.][~]]{1,9}
                     | House Number: [[0-9][A-O][—][/][-][ ][.][~]]{1,9} | H NO [[0-9][A-O][—][/][-][ ][.][~]]{1,9}")
w

u <- str_extract_all(w, "[[A][I][B][C][D][E][F][0-9][—][/][-][ ][.][-]]+")

u

x <- lapply(u, unique)
x

for (i in seq_along(x)) {
  filename = paste(z[[i]],".csv", sep = "")
  write.table(x[i],filename, row.names = TRUE, col.names = "hhID")
}


files <- list.files(pattern="*.csv$")
files

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

q <- p[sample(nrow(p),45), ]
q

write.csv(q,"Vankarakunta.csv", row.names = FALSE)



# combining all final random csv files ----

parentFolder <- "/Users/asoc/Desktop/CSISA_2019/CSISA_IN/AP_KVK/Anantapur"
setwd(parentFolder)

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

saveWorkbook(wb, "finalRandomNumberAnantapur.xlsx")
