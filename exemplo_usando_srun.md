Em geral os cálculos em paralelo são realizados pelo OpenMPI através do comando mpirun.
Por exemplo, para executar quatro tarefas em paralelo que mostra o nome do servidor:

	mpirun -n 4 hostname

E o output será:

	m87
	m87
	m87
	m87

Como utilizamos o Slurm no virgo-cluster, o comando srun substitui o mpirun, sendo que seus
comandos são similares. Entretanto, são necessárias algumas alterações no #SBATCH do arquivo 
de submissão (*.slurm), como informar o número de tarefas em paralelo a serem realizadas.

Exemplo de arquivo de submissão usando o srun:

	#!/bin/sh
	#SBATCH --ntasks=4

	srun -n 4 hostname

E o output será:
	m87
	m87
	m87
	m87

Exemplo de arquivo de submissão utilizando o MontePython:

	#!/bin/sh

	#SBATCH --time=00:05:00
	#SBATCH --job-name="MP"
	#SBATCH --output=MP.out
	#SBATCH --exclude=m[87]
	#SBATCH --ntasks=10

	srun -n 10 python montepython/MontePython.py run -N 10000 -o chains/jlatest2 -p input/test.param

São criadas 10 cadeias em paralelo executadas no m88, com o output "MP.out".
