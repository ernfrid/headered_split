This is a program for splitting a file where there are header lines prefixed
with a `#` character.

Interestingly, the first Nim version was significantly slower than the Python
version. Switching to sysio instead of the streams module fixed this.

The input file was from svtools test data: https://github.com/hall-lab/svtools/blob/develop/tests/test_data/vcfsort/input.vcf

On my MacBook Air using Python 2.7.10 and Nim 0.17.2 on a file with 1000 data
lines and 47 header lines, I get the following timings:
```
$ time python headered_split.py --lines 100 --prefix python. --suffix .vcf input.vcf

real    0m0.076s
user    0m0.035s
sys     0m0.027s

$ time ./headered_split input.vcf 100 nim. .vcf

real    0m0.027s
user    0m0.005s
sys     0m0.015s
```
