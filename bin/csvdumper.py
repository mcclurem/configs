#!/usr/bin/env python
import csv
import argparse

def dumpCSV(filename, padwidth=2):
    lines = [ line for line in csv.reader(open(filename, 'rU')) ]
    columnCount = max([len(line) for line in lines])
    widthList = [0] * columnCount
    for line in lines:
        line += [''] * (columnCount - len(line))
        for i in range(columnCount):
            widthList[i] = max(widthList[i], len(line[i]))
    formatString =  '|'.join(["{%d:^%d}" % (i,widthList[i] + padwidth) for i in range(columnCount)])
    for line in lines:
        print formatString.format(*line)

if __name__ == "__main__":
    parser = argparse.ArgumentParser("Dumps a csv file to the terminal")
    parser.add_argument("filename", type=str, help="The file to dump")
    parser.add_argument("-p", "--pad", type=int, default=2, help="The number of padding spaces added")
    args = parser.parse_args()
    dumpCSV(args.filename, args.pad)

