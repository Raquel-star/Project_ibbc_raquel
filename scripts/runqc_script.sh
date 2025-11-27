#!/bin/bash
# Script 2: pipeline para processar FASTQ paired-end em lote
# Uso: ./pipeline.sh [raw_data_dir] [processed_dir] [results_dir] [log_dir]


BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
# raw_dir: recebe o 1º argumento do script; se não existir, usa o caminho por defeito
raw_dir=${1:-$BASE_DIR/raw_data}
# proc_dir: onde ficam os FASTQ limpos gerados pelo fastp
proc_dir=${2:-$BASE_DIR/processed_data}
# results_dir: pasta para guardar relatórios FastQC/fastp/MultiQC
results_dir=${3:-$BASE_DIR/results}
# log_dir: onde ficam guardados os logs de execução
log_dir=${4:-$BASE_DIR/logs}

mkdir -p $proc_dir $results_dir $log_dir # mkdir cria as pastas e -p evita erro caso elas já existam
# cria o log file com um timestamp
log_file=$log_dir/run_$(date +%Y%m%d_%H%M%S).log

# --- parâmetros configuráveis ---
THREADS=4 # quantas cores vai usar nos programas
TRIM_QUAL=20 # qualidade mínima para manter uma base
MIN_LENGTH=50 # tamanho mínimo da read após trimming
# (podem ser alterados e relançar o script)

# escrever o log, tee -a escreve no ecrã e append ao ficheiro do log
echo "Pipeline iniciado em $(date)" | tee -a $log_file
echo "Parâmetros: threads=$THREADS trim_qual=$TRIM_QUAL min_length=$MIN_LENGTH" | tee -a $log_file

# Loop: percorre todos os ficheiros que terminam com _r1_fastq.gz
for r1 in $raw_dir/*_r1_fastq.gz
do
# basename remove o sufixo para obter apenas o nome da amostra
    SAMPLE=$(basename $r1 _r1_fastq.gz)
 # r2 é o ficheiro emparelhado correspondente ao R1
    r2=$raw_dir/${SAMPLE}*_r2_fastq.gz

    echo "Processando $SAMPLE..." | tee -a $log_file

    # QC inicial
# -t nº de threads; -o pasta de output; $r1 $r2 corre para R1 e R2; 2>&1 junta erros ao output
# Preprocessamento com fastp (parametrizado)
# nº de threads
# input R1 e R2
# output R1 limpo
# output R2 limpo
# cortar bases com qualidade abaixo de Q20
# descartar reads curtas (<50 nt)
# relatório HTML
# relatório JSON
# logs completos e guardados no ficheiro log
    fastqc -t $THREADS -o $results_dir $r1 $r2 2>&1 | tee -a $log_file
    fastp -w $THREADS \
          -i $r1 -I $r2 \
          -o $proc_dir/${SAMPLE}_r1_clean_fastq.gz \
          -O $proc_dir/${SAMPLE}_r2_clean_fastq.gz \
          --qualified_quality_phred $TRIM_QUAL \
          --length_required $MIN_LENGTH \
          -h $results_dir/${SAMPLE}_fastp.html \
          -j $results_dir/${SAMPLE}_fastp.json \
          2>&1 | tee -a $log_file
done

# Juntar relatórios com MultiQC
multiqc $results_dir -o $results_dir 2>&1 | tee -a $log_file
# lê os relatórios FastQC e fastp, cria o relatório MultiQC e escreve para no log

echo "Pipeline terminado em $(date)" | tee -a $log_file # regista a data de fim
