##########################################################################################
args <- commandArgs(trailingOnly = TRUE)
#load packages
library(dada2)
packageVersion("dada2")
library(ShortRead)
packageVersion("ShortRead")
library(Biostrings)
packageVersion("Biostrings")

#define inputs
path<- getwd()
fnFs <- sort(list.files(path, pattern = "_R1.fastq", full.names = TRUE))
fnRs <- sort(list.files(path, pattern = "_R2.fastq", full.names = TRUE))

fnFs.filtN <- file.path(path, "filtN", basename(fnFs)) 
fnRs.filtN <- file.path(path, "filtN", basename(fnRs))
filterAndTrim(fnFs, fnFs.filtN, fnRs, fnRs.filtN, maxN = 0, multithread = TRUE, compress=FALSE)

#define primers
FWD<- args[1]
REV<- args[2]
allOrients <- function(primer) {
    require(Biostrings)
    dna <- DNAString(primer)
    orients <- c(Forward = dna, Complement = complement(dna), Reverse = reverse(dna), 
    RevComp = reverseComplement(dna))
    return(sapply(orients, toString))
}
FWD.orients <- allOrients(FWD)
REV.orients <- allOrients(REV)

primerHits <- function(primer, fn) {
    nhits <- vcountPattern(primer, sread(readFastq(fn)), fixed = FALSE)
    return(sum(nhits > 0))
}
pre_hits<- rbind(FWD.ForwardReads = sapply(FWD.orients, primerHits, fn = fnFs.filtN[[1]]),
    FWD.ReverseReads = sapply(FWD.orients, primerHits, fn = fnRs.filtN[[1]]),
    REV.ForwardReads = sapply(REV.orients, primerHits, fn = fnFs.filtN[[1]]),
    REV.ReverseReads = sapply(REV.orients, primerHits, fn = fnRs.filtN[[1]]))
pre_hits
write.table(pre_hits, file="primer_hits.txt", sep="\t", quote=F, row.names=T)
