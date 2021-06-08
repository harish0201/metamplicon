# metamplicon
Scripts to work on Amplicon sequencing

Will update as and well needed.

Dependencies:
1. Seqkit
2. bbmap - repair.sh
3. R and dependencies: Biostrings, ShortRead, DADA2

Notes:
used for bidirectional sequencing, which was popular a few years back on 454 and Illumina platforms. Unfortunately this works for Illumina Platforms, as others (454) etc are fairly trivial to account for.

Usage: 
1. correct_bidirectional.sh: Correcting orientation of paired reads in case "orient.fwd" doesnt work. Will later check for single ended reads.
2. Use untrimmed reads only
sh correct_bidirectional.sh primer1 primer2 /path/to/seqkit /path/to/bbmap #no.of.processes

Caveats: 
1. Some data loss is expected, if either primers are not sequenced.
2. seqkit uses a single thread. #no.of.processes refers to the number of samples processed in parallel
