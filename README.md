# metamplicon
Scripts to work on Amplicon sequencing

Will update as and well needed.

Dependencies:
1. Seqkit
2. bbmap - repair.sh
3. R and Libraries: Biostrings, ShortRead, DADA2

Notes:
1. used for bidirectional sequencing, which was popular a few years back on 454 and Illumina platforms. Unfortunately this works for Illumina Platforms, as others (454) etc are fairly trivial to account for.
2. uses `seqkit grep` to locate primer sequences in the amplicon datasets. This is done via `-d` option which scans across for degenerate bases
3. uses `seqkit seq` with `-r -p -v` parameter sets for reverse-complementing via `-r -p` switch `-v` to validate the bases.
4. Tried `seqkit locate` with `-P -d -i -r` parameter sets for searching primary strand with degenerate bases and case insensitivity, but its super slow. `locate` results in about 2-5% more number of sequences than `grep` but needs exploring. 

Usage: 
1. correct_bidirectional.sh: Correcting orientation of paired reads in case "orient.fwd" doesnt work. Will later check for single ended reads.
2. Use untrimmed reads only
sh correct_bidirectional.sh primer1 primer2 /path/to/seqkit /path/to/bbmap #no.of.processes

Caveats: 
1. Some data loss is expected, if either primers are not sequenced through.
2. seqkit uses a single thread. #no.of.processes refers to the number of samples processed in parallel
