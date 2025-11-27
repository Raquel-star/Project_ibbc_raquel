#!/bin/bash
# Script 1: criar estrutura de diretórios para análise

working_dir="$(cd "$(dirname "$0")/.." && pwd)"

mkdir -p $working_dir/{raw_data,processed_data,results,logs,scripts}

echo "Estrutura criada em $working_dir"
