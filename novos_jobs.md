# Submissão de jobs usando o Slurm:

O sistema de filas do Virgo-Cluster é o Slurm (Simple Linux Utility for Resource Management). Ele é responsável por alocar o hardware necessário (CPUs, Memória) dos computadores para a realização dos cálculos numéricos (jobs).

**AVISO**:

	Comandos simples (para compactar dados, criar diretórios, etc.) que são executados em poucos minutos no nó principal (m87) são permitidos (Jupyter, Mathematica, editor de texto...). Entretanto, qualquer script que não for submetido ao SLURM e que executam manipulações/criação de dados MUITO propensos a sobrecarregar o nó principal, criando problemas significativos para todos os usuários ativos serão interrompidos a qualquer momento.

## Comandos básicos:

`sinfo`
	Visão geral sobre os recursos disponíveis no cluster.

`squeue`
	Mostra informações sobre os jobs rodando/em espera e também quantos recursos estão alocados para determinadas tarefas.

`scancel`
	Cancela um trabalho submetido.

`virgoinfo`
	Mostra o estado  atual do cluster.


## Como criar um Jobs:
Um job consiste em duas partes: recursos necessários (CPUs, memória) e procedimentos (scripts).
Para criar um job é necessário escrever um arquivo de submissão (*.slurm).

### Exemplo de arquivo .slurm:

	nano submit.slurm
		#!/bin/bash
		#SBATCH --job-name=teste                    # Nome da tarefa
		#SBATCH --mail-type=END                     # Enviará um e-mail quando a tarefa 											  acabar
		#SBATCH --mail-user=fisica.renan@gmail.com  # Endereço de e-mail
		
		python -c 'print("Hello World!")'

	Para submeter o arquivo:
		sbatch submit.slurm

Após a submissão, o script entra como PENDING (PD). Uma vez que os recursos requeridos estão disponíveis, a alocação de hardware é criada e o processo entra como RUNNING. Completado o job, o processo entra como COMPLETED. Caso dê algum erro no script, o resultado final será FAILED.

- https://support.ceci-hpc.be/doc/_contents/QuickStart/SubmittingJobs/SlurmTutorial.html
- https://hpcc.usc.edu/support/documentation/slurm/
- https://help.rc.ufl.edu/doc/Sample_SLURM_Scripts
- Dica pra quem usa Mac (para ativar as cores): https://gist.github.com/XVilka/8346728
