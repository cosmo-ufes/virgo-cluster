# Como transferir arquivos usando scp:

Uma maneira de transferir arquivos é utilizando o comando scp:
	
1. Transferência de arquivo/pasta para o cluster:
	scp arquivo <nome-virgo-scp>:destino
	scp -r pasta <nome-virgo-scp>:destino
		
2. Transferência de arquivo/pasta do cluster para o seu computador:
	scp <nome-virgo-scp>:arquivo destino
	scp -r <nome-virgo-scp>:pasta destino
		
- Adaptado de https://linuxacademy.com/blog/linux/ssh-and-scp-howto-tips-tricks/

- Aplicativo para transferência de arquivos: FileZilla (https://filezilla-project.org)
