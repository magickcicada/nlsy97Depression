cd "C:\Users\delamb\data\nlsy97Subset02"
infile using nlsy97Subset02.dct, clear
do nlsy97Subset02-value-labels-rename.do
save nlsy97Depression, replace
