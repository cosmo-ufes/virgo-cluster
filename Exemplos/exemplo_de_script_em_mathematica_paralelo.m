(*Prints the machine name that each kernel is running on*)
Print[ParallelEvaluate[$MachineName]];

(*Prints all Mersenne Prime numbers less than 3000*)
Print[Parallelize[Select[Range[3000],PrimeQ[2^#-1]&]]];