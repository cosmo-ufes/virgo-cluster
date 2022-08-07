#!/bin/bash

## Exemplo de arquivo de submissão para o Mathematica 11.2.

#SBATCH --job-name="Mathematica"
#SBATCH --mail-type=END
#SBATCH --mail-user=seu@email.com
#SBATCH --exclude=m[87]
#SBATCH --output=mathematica.out

math11.2 -run < ./exemplo_de_script_em_mathematica_serial.m
sleep 50


