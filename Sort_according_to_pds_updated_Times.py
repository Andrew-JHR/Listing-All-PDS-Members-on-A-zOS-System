# Sort time DESENDING
# Author: Andrew Jan
# Date of Creation: 2021/05/05

ipath = r'd:\logs\SYS1.ZOS.OS22.txt'
opath = r'd:\logs\ZT2FILES.txt'

ofile = open(opath,'w')
ifile = open(ipath,'r')
lines = ifile.readlines()
ifile.close()

lst = list()
 
for i in range(len(lines)-1):
   lines[i] = lines[i].split(',')
   if lines[i][1][:2] == '  ':
      continue
   lst.append(lines[i])

lst.sort(key = lambda x : x[1]+x[2], reverse=True)

for i in range(len(lst)):
   lst[i] = ','.join(lst[i])
   ofile.write(lst[i])

ofile.close()
exit()
