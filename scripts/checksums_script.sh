#!/bin/bash
base_dir="$(cd "$(dirname "$0")/.." && pwd)" # define a raiz do projeto
log_dir=$base_dir/logs # diz em que pasta vão ser guardados os logs

mkdir -p $log_dir # garante que a pasta existe

checksum_file=$log_dir/checksums_$(date +%Y%m%d_%H%M%S).txt # cria os checksums com timestamp
echo "Gerando checksums..." | tee -a $checksum_file # escreve a frase no terminal e no ficheiro; tee -a= print + append ao ficheiro

for fq in $base_dir/raw_data/*_fastq.gz # procura todos os ficheiros em raw_data que terminem com -fastq.gz
do
    md5sum $fq >> $checksum_file #calcula o hash MD5 para cada ficheiro fastQ
    sha256sum $fq >> $checksum_file # calcula o SHA-256 
done

echo "Checksums guardados em $checksum_file"
