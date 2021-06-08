## metamplicon
Scripts to work on Amplicon sequencing

Will update as and when needed.

Dependencies:
1. Seqkit
2. bbmap - repair.sh
3. R and Libraries: Biostrings, ShortRead, DADA2

# correct_bidirectional.sh
Notes:
1. used for bidirectional sequencing, which was popular a few years back on 454 and Illumina platforms. Unfortunately this works for Illumina Platforms, as others (454) etc are fairly trivial to account for.
2. uses `seqkit grep` to locate primer sequences in the amplicon datasets. This is done via `-d` option which scans across for degenerate bases
3. uses `seqkit seq` with `-r -p -v` parameter sets for reverse-complementing via `-r -p` switch `-v` to validate the bases.
4. Tried `seqkit locate` with `-P -d -i -r` parameter sets for searching primary strand with degenerate bases and case insensitivity, but its super slow. `locate` results in about 2-5% more number of sequences than `grep` but needs exploring. 
5. Comparative note after the entire process is done, all the seqkit processes running on single thread:
````
With seqkit locate:
                 Forward Complement Reverse RevComp
FWD.ForwardReads  134792          0       0    2443
FWD.ReverseReads     979          0       0  151956
REV.ForwardReads     587          0       0  149638
REV.ReverseReads  133569          0       0     945
Time: ~4mins

With seqkit grep:
                 Forward Complement Reverse RevComp
FWD.ForwardReads  133467          0       0     168
FWD.ReverseReads     176          0       0  149150
REV.ForwardReads      27          0       0  148587
REV.ReverseReads  132896          0       0      17
Time: ~1min
````

Usage: 
1. Use untrimmed reads only
2. sh correct_bidirectional.sh primer1 primer2 /path/to/seqkit /path/to/bbmap #no.of.processes

Caveats: 
1. Some data loss is expected, if either primers are not sequenced through.
2. seqkit uses a single thread. #no.of.processes refers to the number of samples processed in parallel. Feel free to increase the number of threads (n) using `-j n` by editing the shell script after each seqkit invocation
