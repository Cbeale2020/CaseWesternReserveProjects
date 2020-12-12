import os 
import csv

file = '../Resources/election_dataCB.csv'
#data = []
#unique = set()

Correy = 0
OTooley = 0
Li = 0
Khan = 0 
Total = 0

with open (file, newline="", encoding="utf-8") as csvfile:
    freader = csv.reader(csvfile, delimiter = ",")
    csv_header = next(freader)
    for row in freader:
        Total +=1 
       #data.append(row[2])
    #for item in data:
        #unique.add(item)
    #for item in unique:
       # print(item) 
    #for row in freader:
        if row[2] == "Khan":
            Khan += 1 
        elif row[2] == "Li":
            Li += 1 
        elif row[2] == "O'Tooley":
            OTooley += 1
        elif row[2] == "Correy":
            Correy += 1
      
KhanP = (Khan/Total) *100
CorreyP = (Correy/Total) * 100
LiP = (Li/Total)* 100
OTooleyP = (OTooley/Total) * 100

Canidates = ["Khan", "Correy", "Li", "O'Tooley"]
Votes = [Khan, Correy, Li, OTooley]

CombineDict = dict(zip(Canidates,Votes)) 
key = max(CombineDict, key=CombineDict.get)

rot = round(KhanP, 3)
rot2 = round(CorreyP,3)
rot3 = round(LiP,3)
rot4 = round(OTooleyP,3)

print("Election Results")
print("------------------------------")
print(f"Total Votes: {Total}")
print("------------------------------")
print(f"Khan: {rot}% ({Khan})")
print(f"Correy: {rot2}% ({Correy})")
print(f"Li: {rot3}% ({Li})")
print(f"O'Tooley: {rot4}% ({OTooley})")
print("------------------------------")
print(f"Winner: {key}") 
print("------------------------------")


output = os.path.join('../Resources/Result.txt')

with open(output,"w") as file:

# Write methods to print to ElectionsResults
    file.write(f"Election Results")
    file.write("\n")
    file.write(f"----------------------------")
    file.write("\n")
    file.write(f"Total Votes: {Total}")
    file.write("\n")
    file.write(f"----------------------------")
    file.write("\n")
    file.write(f"Khan: {rot}% ({Khan})")
    file.write("\n")
    file.write(f"Correy: {rot2}% ({Correy})")
    file.write("\n")
    file.write(f"Li: {rot3}% ({Li})")
    file.write("\n")
    file.write(f"O'Tooley: {rot4}% ({OTooley})")
    file.write("\n")
    file.write(f"----------------------------")
    file.write("\n")
    file.write(f"Winner: {key}")
    file.write("\n")
    file.write(f"----------------------------")