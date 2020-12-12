# First import what you need
import os
import csv
# Create a variable for where your files are located
path = '../Resources/budget_dataCB.csv'

#Create list for you columns or what you need to add,subtract, etc
#The total number of months included in the dataset
#The net total amount of "Profit/Losses" over the entire period
#The average of the changes in "Profit/Losses" over the entire period
Month =[] 
Profit = []
Change = []

# open file path using with open and create a reader to read information
with open (path, 'r') as csvfile: 
    preader = csv.reader(csvfile, delimiter = ",")
#Skip the header if you need to perform numeric functions
    csv_header = next(preader)
#Add"Append" the values "rows" into the list above 
    for row in preader: 
        Month.append(row[0])
        Profit.append(int(row[1])) 

    for i in range(len(Profit)-1): 
        Change.append(Profit[i+1]-(Profit[i]))
MaxIncrease = (max(Change))
MaxDecrease = (min(Change))
MaxIncreaseMonth = Change.index(max(Change)) + 1
MaxDecreaseMonth = Change.index(min(Change)) + 1

print(f"The number of Months {len(Month)}")
print(f"The total Profits {sum(Profit)}")
print(f"Max Increase + {sum(Change)/len(Change)}")
print(f"Greatest Increase: {Month[MaxIncreaseMonth]} {str(MaxIncrease)}")
print(f"Greatest Decrease: {Month[MaxDecreaseMonth]} {str(MaxDecrease)}") 

output = os.path.join('../Resources/Financial AnalysisResult.txt')

with open(output,"w") as file:

# Write methods to print to Summary 
    file.write(f"Financial Analysis")
    file.write("\n")
    file.write(f"----------------------------")
    file.write("\n")
    file.write(f"The number of Months {len(Month)}")
    file.write("\n")
    file.write(f"The total Profits {sum(Profit)}")
    file.write("\n")
    file.write(f"Max Increase + {sum(Change)/len(Change)}")
    file.write("\n")
    file.write(f"Greatest Increase: {Month[MaxIncreaseMonth]} {str(MaxIncrease)}")
    file.write("\n")
    file.write(f"Greatest Decrease: {Month[MaxDecreaseMonth]} {str(MaxDecrease)}")
