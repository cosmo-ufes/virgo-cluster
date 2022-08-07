#!/bin/bash

## Exemplo de arquivo de submissão para o Python.

#SBATCH --job-name="Python"
#SBATCH --mail-type=END
#SBATCH --mail-user=seu@email.com
#SBATCH --exclude=m[88]
#SBATCH --output=python.out

python -c 'print("Hello World!")'
python exemplo_de_script_em_python
sleep 50


