Para acessar o virgo basta usar o seguinte comando:

    ssh -J <login único UFES>@sshgate.ufes.br:22222 <nome-do-usuario-no-virgo>@172.20.76.99 -p 22
 
 Veja que é necessário criar uma chave pública de ssh e ela deve ser colocada no https://git.ufes.br/profile/keys . Em caso de dúvidas para encontrar suas chaves públicas ou caso queiram gerar novas chaves de ssh, ver https://git.ufes.br/help/ssh/README#generating-a-new-ssh-key-pair. Os usuarios que forneceram a suas chaves não precisaram mais inserir a sua senha mas sim a passphrase usada para criar a chave. A passphrase sera requisitada duas vezes, uma para acessar ao `@sshgate.ufes.br` e outra para acessar ao virgo, por tanto aconselho usar o keychain ou alguma coisa similar.

* Caso ainda não tenha feito nenhum acesso remoto neste novo formato da UFES, pode já fazer o passo acima, mas precisa também me enviar um email informando o seu login único. Isto pois o NTI precisa primeiro fazer uma liberação do login, que no momento é feita manualmente, não basta inserir no GitLab.

A sua chave pública está localizada provavelmente na sua pasta home (`~/`) dentro da pasta `.ssh`(do seu computador pessoal)

    ~/
    |____~/.ssh/
    |____~/.ssh/id_rsa
    |____~/.ssh/id_rsa.pub
  
Para facilitar a sua vida, você pode criar (caso ainda não tenha) um arquivo de configuração do `ssh`. Com isso, o seu computador saberá as configurações corretas para se conectar em servidores. O arquivo "config" não tem nenhuma extensão. Crie um arquivo sem nenhum conteúdo chamado "config" e o salve dentro da pasta .ssh (~/.ssh/). Você pode criar esse arquivo usando por exemplo o Sublime, Vim, Nano, ...
Vamos agora editar esse arquivo. Abra ele com o seu editor de texto favorito e adicione as seguintes linhas:

    Host <nome desejado>
    HostName     172.20.76.99
    Port         22
    User         <usuário>
    ProxyJump    <login único UFES>@sshgate.ufes.br:22222
    LocalForward <porta a ser tunelada> localhost:<porta padrão> # Opcional
    
Exemplo:

    Host virgo
    HostName     172.20.76.99
    Port         22
    User         renan
    ProxyJump    renan.a.oliveira@sshgate.ufes.br:22222
    LocalForward 8889 localhost:8888
    
Para mais opções e a explicação do que cada um dos termos, veja: https://www.ssh.com/ssh/config.

Para faciliar o acesso, ao invés de digitar toda vez `ssh -J ...`,  você pode criar um alias. Caso tenha gerado um arquivo de configuração do ssh, você pode simplesmente usar o seguinte comando:

  ssh <nome desejado>

Por exemplo:

    ssh virgo

Se tudo estiver correto, você irá se conectar ao virgo. Uma outra vantagem em salvar as opções no arquivo de configuração é caso você use o scp. Abaixo, temos um exemplo de como transferir um arquivo do seu computador pessoal para o virgo:

    scp <arquivo desejado> <nome desejado>:~/
    scp -r <pasta desejada> <nome desejado>:~/
    
  Exemplo:
  
    scp <caminho para arquivo>/documento.txt virgo:~/
    
  ou ...
  
    scp <caminho para arquivo>/documento.txt virgo:/media/storage_m87/renan/
    
Para saber como funciona o scp, veja: https://linux.die.net/man/1/scp.

Uma das aplicações do comando `LocalForward` é que você pode acessar (caso tenha instalado na sua conta) o Jupyter Lab usando o virgo no seu computador. Para isso:

  No virgo:
  
    jupyter-lab --port=<porta padrão> --no-browser

  Exemplo:

    jupyter-lab --port=8888 --no-browser

  No seu computador, abra o browser e digite na barra de tarefas:

    localhost:<porta a ser tunelada>

  Exemplo:

    localhost:8889

  Pronto! Você pode acessar o Jupyter Lab no seu computador, porém o kernel está no virgo.
