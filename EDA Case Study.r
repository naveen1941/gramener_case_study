#------------------------------------------------------------------------------------------------------------------------------
# EDA Cast Study
#------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------------------------------
# Set up work directory and load required libraries
#------------------------------------------------------------------------------------------------------------------------------
setwd("C:/Users/577753/Desktop/PGDDS/EDA Case Study")
library("tidyr")
library(ggplot2)
library("scales")
library("xlsx")
library(dplyr)
#------------------------------------------------------------------------------------------------------------------------------
#**********************Data Sourcing*******************************************************************************************
#------------------------------------------------------------------------------------------------------------------------------
# Read dataset 

fdata <- read.csv("loan.csv")
View(fdata)
str(fdata)
#------------------------------------------------------------------------------------------------------------------------------
# *********************Data Cleaning*******************************************************************************************
#------------------------------------------------------------------------------------------------------------------------------
# Data Quality Check
#------------------------------------------------------------------------------------------------------------------------------
which(duplicated(fdata$member_id)) # check duplicate records
#------------------------------------------------------------------------------------------------------------------------------
# Data Manipulation
#------------------------------------------------------------------------------------------------------------------------------
# AS PER USA INCOME CENSUS BETWEEN 2007 TO 2011, 50K $ IS THE AVERAGE HOUSEHOLD INCOME. CLASS OF INCOME IS THEREFORE
# BELOW $ 30K IS LOWER CLASS, BETWEEN $ 30K TO $ 100K IS MIDDLE CLASS AND ABOVE $ 100K IS UPPER MIDDLE CLASS.
# ACCORDINGLY INCOME CLASS IS DERIVED FOR FURTHER ANALYSIS.
#------------------------------------------------------------------------------------------------------------------------------
fdata$class <-ifelse(fdata$annual_inc < 30000 ,"LOWER",
                         ifelse(fdata$annual_inc>= 30000 & fdata$annual_inc < 100000,"MIDDLE",
                           "UPPER MIDDLE"))

ddata <- subset(fdata,loan_status == "Charged Off") # Data for default cases.
View(fdata)
View(ddata)

#------------------------------------------------------------------------------------------------------------------------------
# *********************Final Dataframe Export *********************************************************************************
#------------------------------------------------------------------------------------------------------------------------------
# Write to excel

write.xlsx(fdata, file='eda.xlsx', sheetName="Sheet1", col.names=TRUE, row.names=FALSE, append=TRUE) # For Tableau

################################################################################################################################ 
# Though final data frame  is exported to excel for plotting graphs in Tableau, they are plotted using R also as below.
# However, not much beautification has been done for graphs as they are not going to be used for final presentation.
################################################################################################################################

#------------------------------------------------------------------------------------------------------------------------------
# *********************Data Analysis ******************************************************************************************
#------------------------------------------------------------------------------------------------------------------------------
# Defaults: Based on Loan Term
ggplot(data=ddata, aes(x=term, fill = term)) + geom_bar(stat="count")

# Defaults: Based on Verification Status
ggplot(data=ddata, aes(x=verification_status, fill = verification_status)) + geom_bar(stat="count")

# Defaults: Home OWnership
ggplot(data=ddata, aes(x=home_ownership, fill = home_ownership)) + geom_bar(stat="count")

# Defaults: Employment Length
ggplot(data=ddata, aes(x=emp_length, fill = emp_length)) + geom_bar(stat="count")

# Defaults: Purpose of Loan
ggplot(data=ddata, aes(x=purpose, fill = purpose)) + geom_bar(stat="count")

# Defaults: Total Credit Accounts
ggplot(data=ddata, aes(x=total_acc, fill = total_acc)) + geom_histogram(stat="count")

# Defaults: Loan Grade
ggplot(data=ddata, aes(x=grade, fill = grade)) + geom_bar(stat="count")

# Defaults: State of Residence for Customers
ggplot(data=ddata, aes(x=addr_state, fill = addr_state)) + geom_bar(stat="count")

# Defaults: Customer Income Class
ggplot(data=ddata, aes(x=class, fill = class)) + geom_bar(stat="count")

# Defaults: Total Credit Accounts
ggplot(data=ddata, aes(x=total_acc)) + geom_histogram(stat="count")

# Defaults: Total Open Credit Accounts
ggplot(data=ddata, aes(x=open_acc)) + geom_histogram(stat="count")

# Defaults: Debt to Income Ratio
ggplot(data=ddata, aes(x=dti)) + geom_histogram(stat="count")

# Defaults: Revolving Utilization
ggplot(data=ddata, aes(x=revol_util)) + geom_histogram(stat="count")
#------------------------------------------------------------------------------------------------------------------------------