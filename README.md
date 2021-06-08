# metamplicon
Scripts to work on Amplicon sequencing

Will update as and well needed.

Dependencies:
1. Seqkit
2. bbmap - repair.sh
3. R and dependencies: Biostrings, ShortRead

Usage: 
1. correct_bidirectional.sh: Correcting orientation of 
sh correct_bidirectional.sh primer1 primer2 /path/to/seqkit /path/to/bbmap

Cons: Some data loss is expected.
