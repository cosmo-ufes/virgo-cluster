#!/bin/bash
## Para mais informações: https://slurm.schedmd.com/sbatch.html

## Comandos do SBATCH:
## --cores-per-socket=<cores> Restrict node selection to nodes with at least the specified number of cores per socket. See additional information under -B option above when task/affinity plugin is enabled.
## --cpus-per-task=<ncpus> Advise the Slurm controller that ensuing job steps will require ncpus number of processors per task. Without this option, the controller will just try to allocate one processor per task. For instance, consider an application that has 4 tasks, each requiring 3 processors. If our cluster is comprised of quad-processors nodes and we simply ask for 12 processors, the controller might give us only 3 nodes. However, by using the --cpus-per-task=3 options, the controller knows that each task requires 3 processors on the same node, and the controller will grant an allocation of 4 nodes, one for each of the 4 tasks.
## --error=<filename pattern> Instruct Slurm to connect the batch script's standard error directly to the file name specified in the "filename pattern". By default both standard output and standard error are directed to the same file. For job arrays, the default file name is "slurm-%A_%a.out", "%A" is replaced by the job ID and "%a" with the array index. For other jobs, the default file name is "slurm-%j.out", where the "%j" is replaced by the job ID.
## --exclude=<node name list> Explicitly exclude certain nodes from the resources granted to the job.
## --job-name=<jobname> Specify a name for the job allocation. The specified name will appear along with the job id number when querying running jobs on the system. The default is the name of the batch script, or just "sbatch" if the script is read on sbatch's standard input.
## --mail-type=<type> Notify user by email when certain event types occur. Valid type values are NONE, BEGIN, END, FAIL, REQUEUE, ALL (equivalent to BEGIN, END, FAIL, REQUEUE, and STAGE_OUT), STAGE_OUT (burst buffer stage out and teardown completed), TIME_LIMIT, TIME_LIMIT_90 (reached 90 percent of time limit), TIME_LIMIT_80 (reached 80 percent of time limit), TIME_LIMIT_50 (reached 50 percent of time limit) and ARRAY_TASKS (send emails for each array task). Multiple type values may be specified in a comma separated list. The user to be notified is indicated with --mail-user. Unless the ARRAY_TASKS option is specified, mail notifications on job BEGIN, END and FAIL apply to a job array as a whole rather than generating individual email messages for each task in the job array.
## --mail-user=<user> User to receive email notification of state changes as defined by --mail-type. The default value is the submitting user.
## --mem=<size[units]> Specify the real memory required per node. Default units are megabytes unless the SchedulerParameters configuration parameter includes the "default_gbytes" option for gigabytes. Different units can be specified using the suffix [K|M|G|T]. Default value is DefMemPerNode and the maximum value is MaxMemPerNode.
## --mincpus=<n> Specify a minimum number of logical cpus/processors per node.
## --nodes=<minnodes[-maxnodes]> Request that a minimum of minnodes nodes be allocated to this job. A maximum node count may also be specified with maxnodes. If only one number is specified, this is used as both the minimum and maximum node count. The partition's node limits supersede those of the job. If a job's node limits are outside of the range permitted for its associated partition, the job will be left in a PENDING state. This permits possible execution at a later time, when the partition limit is changed. If a job node limit exceeds the number of nodes configured in the partition, the job will be rejected. Note that the environment variable SLURM_JOB_NODES will be set to the count of nodes actually allocated to the job. See the ENVIRONMENT VARIABLES section for more information. If -N is not specified, the default behavior is to allocate enough nodes to satisfy the requirements of the -n and -c options. The job will be allocated as many nodes as possible within the range specified and without delaying the initiation of the job. The node count specification may include a numeric value followed by a suffix of "k" (multiplies numeric value by 1,024) or "m" (multiplies numeric value by 1,048,576).
## --ntasks=<number> sbatch does not launch tasks, it requests an allocation of resources and submits a batch script. This option advises the Slurm controller that job steps run within the allocation will launch a maximum of number tasks and to provide for sufficient resources. The default is one task per node, but note that the --cpus-per-task option will change this default.
## --output=<out_file>	Instruct Slurm to connect the batch script's standard output directly to the file name specified in the "filename pattern". By default both standard output and standard error are directed to the same file. For job arrays, the default file name is "slurm-%A_%a.out", "%A" is replaced by the job ID and "%a" with the array index. For other jobs, the default file name is "slurm-%j.out", where the "%j" is replaced by the job ID.
## --time=<time> Set a limit on the total run time of the job allocation. If the requested time limit exceeds the partition's time limit, the job will be left in a PENDING state (possibly indefinitely). The default time limit is the partition's default time limit. When the time limit is reached, each task in each job step is sent SIGTERM followed by SIGKILL. The interval between signals is specified by the Slurm configuration parameter KillWait. The OverTimeLimit configuration parameter may permit the job to run longer than scheduled. Time resolution is one minute and second values are rounded up to the next minute. A time limit of zero requests that no time limit be imposed. Acceptable time formats include "minutes", "minutes:seconds", "hours:minutes:seconds", "days-hours", "days-hours:minutes" and "days-hours:minutes:seconds".

## Exemplo de como colocar os comandos do SBATCH baseado nas configurãções de sua escolha. 
## Note que quase todos os comandos são opicionais.

#SBATCH --job-name="Meu Script"
#SBATCH --mail-type=END
#SBATCH --mail-user=seu@email.com
#SBATCH --exclude=m[87]
#SBATCH --cpus-per-task=10
#SBATCH --output=terminal_output.out

## Nessa parte você colocará o seu código, da mesma forma como
## se fosse no terminal. Note que não é necessário usar o screen.
			
python -c 'print("Hello World!")'
sleep 15


