'''
Created on Sep 13, 2013

@author: davide
'''
import xlrd
import csv



wb = xlrd.open_workbook('politesi.xls')
print wb.sheet_names()
sh = wb.sheet_by_name('politesi_prod_20130906')
your_csv_file = open('politesi.csv', 'wb')
wr = csv.writer(your_csv_file, quoting=csv.QUOTE_ALL)

for rownum in xrange(sh.nrows):
    wr.writerow(sh.row_values(rownum))

your_csv_file.close()