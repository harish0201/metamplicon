## used for bidirectional sequencing, which was popular a few years back on 454 and Illumina platforms. 
##put primer1 and 2 as commandline args, seqkit and bbmap installation directory path to be given.
#!/bin/bash
mkdir -p proc_fastq/paired
primer1="$1"
primer2="$2"
seqkit_bin="$3"
bbmap_bin="$4"
export PATH=$PATH:"$3"

for i in *_R1.fastq; do seqkit grep -d -i -p $primer1 "$i" | seqkit seq -v >> proc_fastq/"$i" ; \ 
seqkit grep -d -i -p $primer2 $(basename "$i" R1.fastq)R2.fastq | seqkit seq -v >> proc_fastq/$(basename "$i" R1.fastq)R2.fastq; \
seqkit grep -d -i -p $primer2 "$i" | seqkit seq -r -p -v >> proc_fastq/"$i"; \
seqkit grep -d -i -p $primer1 $(basename "$i" R1.fastq)R2.fastq | seqkit seq -r -p -v >> proc_fastq/$(basename "$i" R1.fastq)R2.fastq; \
done

echo "orienting done"

cd proc_fastq
for i in *R1.fastq; do "$4"/repair.sh in="$i" in2=$(basename "$i" R1.fastq)R2.fastq \
out=paired/"$i" out2=paired/$(basename "$i" R1.fastq)R2.fastq ain=t; done

cd ../

echo "files written to proc_fastq/paired"
echo "done"
