#!/bin/bash

## Exemplo de arquivo de submissão para o Mathematica 12.

#SBATCH --job-name="Mathematica Parallel"
#SBATCH --mail-type=END
#SBATCH --mail-user=seu@email.com
#SBATCH --exclude=m[87]
#SBATCH --cpus-per-task=16
#SBATCH --output=mathematica_parallel.out

math -run < ./exemplo_de_script_em_mathematica_paralelo.m
sleep 50


