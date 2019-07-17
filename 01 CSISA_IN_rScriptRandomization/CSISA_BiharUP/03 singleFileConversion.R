
# make sure that you have loaded all the required packages
# also make sure that the files are placed according to the file pathnames

parentFolder <- "/Users/apple/Desktop/SurveySampling/Bihar_UP/01restDistricts/Balia/29_NaukaGaon"
setwd(parentFolder)
filenames <- list.files(parentFolder, pattern = "*.pdf$")
filenames
z <- mixedsort(sort(filenames))
y <- sapply(z, pdf_text)

# the follwing is an example from PDFs of Uttar Pradesh

w <- str_extract_all(y, "मकपन सगखनप : \\d{1,8} | मकपन सभखयप : \\d{1,8} | मकपन सगखयप : \\d{1,8} | मकपन सपखयप : \\d{1,8}  | मकपन सपखनप : \\d{1,8} | मककन सभखनक : \\d{1,8}  | 
                     मकपन सभखनप : \\d{1,8} | मसहन सगखनह : \\d{1,8} | मसहन सभखनह : \\d{1,8} |
                     मकनन सभखनन : \\d{1,8} | मसहन सपखनह : \\d{1,8} |मकपन सगखनप : \\d{1,8} |
                     मकपन सभखनप : \\d{1,8} | मकपन सपखनप : \\d{1,8} | रकपन सपखनप : \\d{1,8} |
                     मकपन ससखनप : \\d{1,8} | मकपन सशखनप : \\d{1,8} | मकपन सहखनप : \\d{1,8} | 
                     मककन सपखनक : \\d{1,8} | मकपन सवखनप : \\d{1,8} | मकमन सपखनम : \\d{1,8}")

u <- str_extract_all(w, "[0-9.]+")

x <- lapply(u, unique)
x <- lapply(x, as.integer)
x <- lapply(x, unique)
dt <- do.call("rbind", lapply(x, as.data.frame)) 

dt <- lapply(dt, unique)

for (i in seq_along(dt)) {
  filename = paste(filenames[[i]],".csv", sep = "")
  write.table(dt[i],filename, row.names = FALSE, col.names = "hhID")
  
}
