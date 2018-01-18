import os, strutils

let
    prefix = '#'

var
    header = newSeqOfCap[string](5000)
    fragment_num = 0

proc main() =
    if paramCount() < 4:
        quit("synopsis: " & getAppFilename() & " filename chunksize outprefix outsuffix")

    let
        filename = paramStr(1)
        chunksize = parseInt(paramStr(2))
        outprefix = paramStr(3)
        outsuffix = paramStr(4)
        file = open(filename, fmRead)
    var
        line = newStringOfCap(20000).TaintedString

    if file == nil:
        quit("Cannot open file " & filename)

    defer: file.close()

    while file.readLine(line):
        if line.startsWith(prefix):
            header.add(line)
        else:
            let outfilename = outprefix & intToStr(fragment_num) & outsuffix
            let outfile = open(outfilename, fmWrite)

            if outfile == nil:
                quit("Cannot open file " & outfilename & " for writing")
            defer: outfile.close
            for hline in header:
                outfile.writeLine(hline)
            outfile.writeLine(line)
            var i = 1
            while i < chunksize and file.readLine(line):
                outfile.writeLine(line)
                inc(i)
            inc(fragment_num)

main()
    
