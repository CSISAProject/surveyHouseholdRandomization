# surveyHouseholdRandomization
This repository contains the R scripts for household randomization for Landscape Diagnostics Survey in India

In order to run the R scripts, you need to have the following:
•	Make sure you have received all the PDF files for the survey districts
•	Ensure that you have correctly placed them as District Name > Village Name > PDF files
•	Check whether the contents of the pdf files are extractable. In case of Bihar and most UP districts, you can easily extract particular words. If the PDF file is in image format, you need to use tesseract package.
•	Always check the PDF files whether they are extractable.
•	For Bihar and UP, you can extract the HH numbers without having to use tesseract package. But for AP, Odisha, West Bengal, remember to convert the pdf files to png format. 


How to copy and paste the finalHHNumber
•	Open the village folders
•	Search for “finalHHNumber.csv” & open it
•	The file “finalHHNumber.csv” is the compilation of all the wards along with HH Numbers
•	On the column, you would see something like [c…12…13…16…17…19]. Please note that this is the HH numbers generated from pdf files
•	Copy all these numbers is single column by looking at corresponding column named “SOURCE”
•	For first first file, generally the HH number is at left side.
•	For rest of the files, it is at right side to the file column name. 
•	If there is “NA” written next to the file name, please check another corresponding column to the right side where you can see the numbers.
•	Also, always cross check the “Source” column where pdf file name is written and COPY only its’ corresponding column with HH numbers.
