#!/bin/bash
base_dir="$(cd "$(dirname "$0")/.." && pwd)" # define a raiz
backup_dir=$base_dir/backup # pasta onde o backup comprimido será guardado
log_dir=$base_dir/logs # onde será guardado o ficheiro

mkdir -p $backup_dir $log_dir # garante que as pastas existem

tarball=$backup_dir/Project_ibbc_raquel_$(date +%Y%m%d_%H%M%S).tar.gz # ficheiro .tar.gz com timestamp 
tar -czvf $tarball $base_dir 2>&1 | tee -a $log_dir/backup.log # -v mostra no terminal o que está a fazer
# -f define o nome do ficheiro
#  $tarball $base_dir diz para comprimir a pasta toda; 2>&1 diz para registar os erros também
# | tee -a $log_dir/backup.log coloca o output no terminal e adiciona ao ficheiro backup.log
echo "Backup criado: $tarball"
