### Query Document Database
###
### Author: Wang, Qiudan
### Course: CS5200
### Term: 2023 Spring

# assumes that you have set up the database structure by running CreateFStruct.R

# Query Parameters (normally done via a user interface)

quarter <- "Q2"
year <- "2021"
customer <- "Medix"

# write code below
#---------------------------------------------------------------------------------------
# create a lock file called "customer.lock" in the folder quarter/year, if it does not exist.
setLock <- function(customer, year, quarter) {
  wd <- getwd()
  lock_file_a = paste(wd, "docDB", "reports", year, quarter, customer, ".lock", sep = "/")
  if (!file.exists(lock_file_a)) {
    file.create(lock_file_a)
    return (0)
  } else {
    return (-1)
  }
}
#---------------------------------------------------------------------------------------
# generate the report full file name using the pattern Company.Year.Quarter.pdf
genReportFName <- function(customer, year, quarter) {
  pdf_file_name = paste(customer, year, quarter, "pdf", sep=".")
  return (pdf_file_name)
}
#---------------------------------------------------------------------------------------
# check if there is a lock file in folder, if not store, report (the downloaded report)
storeReport <- function(customer, year, quarter) {
  wd <- getwd()
  pdf_file_name = genReportFName(customer, year, quarter)
  lock_file = paste(wd, "docDB", "reports", year, quarter, customer, ".lock", sep="/")
  target_folder = paste(wd, "docDB", "reports", year, quarter, customer, sep="/")
  if (!file.exists(lock_file)) {
    file.copy(paste(".", pdf_file_name, sep="/"), target_folder, overwrite = TRUE)
  }
}
#---------------------------------------------------------------------------------------
# removes the lock file
relLock <- function(customer, year, quarter) {
  wd <- getwd()
  lock_file = paste(wd, "docDB", "reports", year, quarter, customer, ".lock", sep="/")
  if (file.exists(lock_file)) {
    file.remove(lock_file)
  }
}

# test that all functions work
setLock(customer, year, quarter)
genReportFName(customer, year, quarter)
storeReport(customer, year, quarter)
relLock(customer, year, quarter)
