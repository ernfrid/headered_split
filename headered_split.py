#!/usr/bin/env python

import sys
import argparse

def main(infile, prefix, suffix, lines):
    header = list()
    fragment_num = 0
    for line in infile:
        if line.startswith('#'):
            header.append(line)
        else:
            with open(prefix + str(fragment_num) + suffix, 'w') as outfile:
                outfile.writelines(header)
                outfile.write(line)
                for i in xrange(lines - 1):
                    try:
                        outfile.write(next(infile))
                    except StopIteration:
                        break
                fragment_num += 1

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Split a file with #-prefixed headers.')
    parser.add_argument('infile', nargs='*', type=argparse.FileType('r'), default=sys.stdin, help='input file. default: stdin')
    parser.add_argument('--lines', type=int, default=10000, help='number of data lines per file')
    parser.add_argument('--prefix', type=str, default='', help='prefix to add to output file names')
    parser.add_argument('--suffix', type=str, default='', help='suffix to add to output file names')
    args = parser.parse_args()
    main(args.infile, args.prefix, args.suffix, args.lines)