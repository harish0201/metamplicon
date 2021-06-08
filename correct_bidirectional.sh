#!/bin/bash

mkdir -p proc_fastq/paired
owd=$PWD
primer1="$1"
primer2="$2"
seqkit_bin="$3"
bbmap_bin="$4"
parallel_fac="$5"
printf "\nparallel_fac impacts on the number of seqkit processes run; i.e number of samples processed in a single time\n"
export PATH=$PATH:"$3" 
printf "\nstarting the process\n"
for i in *_R1.fastq; do echo "seqkit grep -d -i -p $primer1 "$i" | seqkit seq -v >> proc_fastq/"$i" ; \ 
seqkit grep -d -i -p $primer2 $(basename "$i" R1.fastq)R2.fastq | seqkit seq -v >> proc_fastq/$(basename "$i" R1.fastq)R2.fastq; \
seqkit grep -d -i -p $primer2 "$i" | seqkit seq -r -p -v >> proc_fastq/"$i"; \
seqkit grep -d -i -p $primer1 $(basename "$i" R1.fastq)R2.fastq | seqkit seq -r -p -v >> proc_fastq/$(basename "$i" R1.fastq)R2.fastq"; \
done | parallel -j$parallel_fac
#
printf "\norienting done\n"
#
cd proc_fastq
for i in *R1.fastq; do "$4"/repair.sh in="$i" in2=$(basename "$i" R1.fastq)R2.fastq \
out=paired/"$i" out2=paired/$(basename "$i" R1.fastq)R2.fastq ain=t; done
#
printf "\nre-pairing data\n"
printf "\nchecking if orientation is correct or not\n"
#
cd paired
Rscript $owd/primer_checks.R "$1" "$2"
printf "\ncheck proc_fastq/primer_hits.txt for final summary\n"
rm -rf filtN
rm ../*fastq
mv *.fastq ../
mv primer_hits.txt ../
cd ../
rm -rf paired
#
cd $owd
#
printf "\nfiles written to proc_fastq/ primer hits written to primer_hits.txt\n"
printf "\nother primer pairs can be checked independently with primer_checks.R. Use it as\n
Rscript primer_checks.R primer1 primer2\n"
printf "\ndone\n"
