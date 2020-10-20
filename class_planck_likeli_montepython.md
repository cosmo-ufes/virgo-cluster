
*Esse tutorial foi criado baseado na instalação oficial e em alguns eventuais problemas enfrentados.*

Passos para instalar o `class` + `MontePython` + `Planck Likelihood` (2015) no Virgo-cluster:

1. É necessário utilizar o Python 2.
	Você pode utilizar a versão do CentOS com o Python 2 e os pacotes necessários para rodar os
	softwares acima (NumPy, SciPy, Cython, MatPlotLib, PyFITS, ...) ou instalar o seu próprio ambiente
	(e não máquina virtual) do Python 2 utilizando por exemplo o Anaconda (anaconda.org).
	Para verificar a versão atual do Python:
			
		python
			 Exemplos de possíveis outputs: 
				Python do CentOS:
					Python 2.7.5 (default, Jun 20 2019, 20:27:34) 
					[GCC 4.8.5 20150623 (Red Hat 4.8.5-36)] on linux2
				Python do Anaconda:
					Python 2.7.16 | Anaconda, Inc. | (default, Mar 14 2019, 21:08:58)
		exit()

	Caso você tenha baixado o Anaconda e esteja utilizando o Python 3, você pode criar um novo
	um ambiente virtual, ao invés de reinstalar tudo novamente:

		conda create -n <nome do ambiente> python=<versão do Python> anaconda
		conda create -n python2 python=2.7 anaconda
		conda activate python2

	Para desativar o ambiente:

		conda deactivate <nome do ambiente>
		conda deactivate python2

	Instale os pacotes abaixo:

		conda install -c cefca pyfits
		conda install -c anaconda libgfortran

	* Note que a versão do pyfits da fonte "cefca" está desatualizada. Eu recomendo (infelizmente) a não utilizar
	o Python do Anaconda e sim a do CentOS pois todos os pacotes estão atualizados.

2. Verifique se você está na pasta /home/<usuário>/:

	    pwd
		/home/<usuário>

	O Print Working Directory (pwd) mostra o caminho da pasta atual.

3. Baixe o class, montepython e a likelihood do Planck (2015):

	   git clone https://github.com/lesgourg/class_public.git
	   git glone https://github.com/brinckmann/montepython_public.git
	   wget -O COM_Likelihood_Code-v2.0_R2.00.tar.bz2 "http://pla.esac.esa.int/pla/aio/product-action?COSMOLOGY.FILE_ID=COM_Likelihood_Code-v2.0_R2.00.tar.bz2"
	   wget -O COM_Likelihood_Data-baseline_R2.00.tar.gz "http://pla.esac.esa.int/pla/aio/product-action?COSMOLOGY.FILE_ID=COM_Likelihood_Data-baseline_R2.00.tar.gz"

4. Sugiro mover as pastas "plc-2.0" e "plc_2.0" extraídas dos arquivos COM_Likelihood_*.tar.gz para uma 
pasta nova chamada planck.

	   mkdir planck
	   tar -xvf COM_Likelihood_Code-v2.0_R2.00.tar.bz2
	   tar -xvf COM_Likelihood_Data-baseline_R2.00.tar.gz
	   mv plc-2.0 plc_2.0 planck/

5. Class:

	   cd class
	   make clean
	   make all
	   cd python/
	   python setup.py build
	   python setup.py install --user
	   cd ..

6. Planck Likelihood:

	   cd planck
	   cd plc-2.0

	Nesta parte é necessário alterar algumas entradas no arquivo "Makefile":

	    nano Makefile

   E é necessário alterar as seguintes linhas:

     	Linha 30: FC = ifort -> FC = gfortran 
     	Linha 57: MKLROOT = -> MKLROOT = /opt/intel/mkl
     	Linha 58: LAPACKLIBPATHMKL = -> LAPACKLIBPATHMKL = -L$(MKLROOT)/lib/intel64
     	Linha 84: CM64 = -> CM64 = -m64
     	Linha 89: FM64 = -> FM64 = -m64

   CTRL+X E depois Y ou S.

     	./waf configure --install_all_deps
	
	Provavelmente aparecerá um erro falando que não está instalado o CFISTIO. Não se preocupe pois o instalador tomará conta disso pra você. Se tudo ocorrer bem...

     	./waf install
     	source bin/clik_profile.sh

	Para otimizar as coisas, você pode colocar o comando "source <caminho para o arquivo>/clik_profile.sh" no arquivo .bashrc. Esse arquivo fica na sua home (/home/<usuário>).	Lembre-se que é obrigatório ter o Python 2. Caso você utiliza o Python 3 como padrão, é preciso colocar antes do comando mencionado anteriormente "conda activate python2", ou se quiser utilizar o Python do próprio OS, "conda deactivate".

	Exemplo do arquivo .bashrc de um usuário que tem o ambiente Python 3 do Anaconda:

		nano /home/<usuário>/.bashrc

			...
			Várias coisas
			...

		conda activate python2
		source planck/plc-2.0/bin/clik_profile.sh

	Exemplo do arquivo .bashrc de um usuário que tem o ambiente Python 3 do Anaconda e irá utilizar o
	Python do CentOS:

		nano /home/<usuário>/.bashrc

			...
			Várias coisas
			...

		conda deactivate
		source planck/plc-2.0/bin/clik_profile.sh

	Recomendo verificar se o Python importa corretamente a classe "clik":

		python
		import clik

	Se não aparecer nenhum erro, tudo está ok. Se aparecer um erro do tipo

		Cannot use clik wrapper (cause = 'No module named lkl')

	ou

		Cannot use clik wrapper (cause = 'libgfortran.so.4: cannot open shared object file: No such file or directory')
		Cannot use clik_lensing wrapper (cause = 'libgfortran.so.4: cannot open shared object file: No such file or directory')

	Significa que o wrapper da Likelihood do Planck não está funcionando, e no último caso, não foi possível encontrar o arquivo libgfortran.so.4. Isso pode variar de computador para computador, mas no computador aonde apareceu o erro, o arquivo libgfortran.so.4 estava na pasta:
	
		/home/<usuário>/anaconda3/envs/python2/x86_64-conda_cos6-linux-gnu/sysroot/lib

	Para solucionar esse erro bastou escrever no terminal (e adicionar esse comando no arquivo .bashrc):
		
		export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/<usuário>/anaconda3/envs/python2/x86_64-conda_cos6-linux-gnu/sysroot/lib

	E tivemos sucesso ao importar a classe "clik" no Python.

8. MontePython:

     	cd
     	cd
     	cd montepython_public/
     	cp default.conf.template default.conf
     	nano default.conf

   E edite as linhas abaixo:
	
		Linha 22: root = '/Path/to/your/codes' -> root = '/home/<usuário>'
		Linha 24: path['cosmo'] = root+'/class' -> path['cosmo'] = root+'/class_public'
		Linha 25: path['clik'] = root+'/planck/plc-2.0' -> path['clik'] = root+'/planck/plc-2.0'

	Eu não alterei a linha 25 porque não foi necessário.

9. Testando:

	Em geral, o MontePython tenta usar todos os cores do computador. O problema é que isso pode travar o cluster. Para um teste inicial é OBRIGATÓRIO utilizar o comando "srun -n 1" para gerar apenas uma cadeia e utilizar apenas um core. Ao submeter o seu cálculo no sistema de filas, você pode configurar o arquivo *.slurm para rodar em mais cores.

		srun -n 1 python montepython/MontePython.py run -p input/base2015.param -o chains/testando -N 10

	Se tudo funcionar, ótimo!

	Talvez essa thread seja interessante: https://github.com/brinckmann/montepython_public/issues/14
	E essa outra: https://serverfault.com/questions/1669/shell-command-to-monitor-changes-in-a-file-whats-it-called-again/1670
