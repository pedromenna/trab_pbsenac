# Repositorio para a primeira atividade PB Compass.

## Requisitos

### Instancia AWS:
- Gerar um chave pública para acesso ao ambiente
- Criar instância Amazon Linux 2
    - t3.small
    - 16 GB SSD
- Gerar 1 elastic IP e anexar à instância EC2
- Liberar portas de comunicação para acesso público
    - 22/TCP (SSH)
    - 111/TCP e UDP (RPC)
    - 2049/TCP/UDP (NFS)
    - 80/TCP (HTTP)
    - 443/TCP (HTTPS)

### Configurações Linux:

- Configurar o NFS entregue;
- Criar um diretorio dentro do filesystem do NFS com seu nome;
- Subir um apache no servidor - o apache deve estar online e rodando;
- Criar um script que valide se o serviço esta online e envie o resultado da validação para o seu diretorio no nfs;
    - O script deve conter - Data HORA + nome do serviço + Status + mensagem personalizada de ONLINE ou offline;
    - O script deve gerar 2 arquivos de saida: 1 para o serviço online e 1 para o serviço OFFLINE;
    - Execução automatizada do script a cada 5 minutos.


-----------------------------------------------------------------------------


## Instrução de criação e configuração da instância 

### Gerar uma chave pública de acesso na AWS e anexá-la à uma nova instância EC2.
- Iniciar a página da AWS
- No console pesquisar pelo serviço EC2 
- Entrar em "Key pairs" no menu lateral esquerdo.
- Clicar em "Create key pair".
- Inserir um nome para a chave e clicar em "Create key pair".
- Salvar o arquivo .pem gerado.
- Clicar em "Instances" no menu lateral esquerdo.
- Clicar em "Launch Instance".
- Adicionar as Tags da instância (Name, Project e CostCenter) em instancias, volumes e interface network.
- Selecionar a imagem Amazon Linux 2 AMI (HVM).
- Selecionar o tipo de instância t3.small.
- Selecionar a chave gerada anteriormente.
- Selecionar ou criar um security group.
- Colocar 16 GB de armazenamento gp2 (SSD).
- Clicar em "Launch Instance".


### Alocar um endereço IP elástico à instância EC2.

- Iniciar a página da AWS
- No console pesquisar pelo serviço EC2 
- Entrar em "Elastic IP" no menu lateral esquerdo.
- Clicar em "Allocate Elastic IP address".
- Selecionar o ip alocado e clicar em "Actions" -> "Associate Elastic IP address".
- Selecionar a instância EC2 criada anteriormente e clicar em "Associate".

### Configurar gateway de internet.

- Iniciar a página da AWS
- No console pesquisar pelo serviço VPC 
- Entrar "Internet gateways" no menu lateral esquerdo.
- Clicar em "Create internet gateway".
- Definir um nome para o gateway e clicar em "Create internet gateway".
- Selecionar o gateway criado e clicar em "Actions" -> "Attach to VPC".
- Selecionar a VPC da instância EC2 criada anteriormente e clicar em "Attach".

### Configurar rota de internet.

- Iniciar a página da AWS
- No console pesquisar pelo serviço VPC 
- Entrar "Route tables" no menu lateral esquerdo.
- Selecionar a tabela de rotas da VPC da instância EC2 criada anteriormente.
- Clicar em "Actions" -> "Edit routes".
- Clicar em "Add route".
- Configurar desse jeito:
    - Destination: 0.0.0.0/0
    - Target: Selecionar o gateway de internet criado anteriormente
- Clicar em "Save changes".

### Configurar regras de segurança.


- Iniciar a página da AWS
- No console pesquisar pelo serviço EC2 
- Entrar em "Security Groups" no menu lateral esquerdo.
- Selecionar o grupo de segurança da instância EC2 criada anteriormente.
- Clicar em "Actions" -> "Edit inbound roules".
- Configurar desse jeito:
    Type | Protocol | Port range | Source | Description
    ---|---|---|---|---
    SSH | TCP | 22 | 0.0.0.0/0 | SSH
    TCP personalizado | TCP | 80 | 0.0.0.0/0 | HTTP
    TCP personalizado | TCP | 443 | 0.0.0.0/0 | HTTPS
    TCP personalizado | TCP | 111 | 0.0.0.0/0 | RPC
    UDP personalizado | UDP | 111 | 0.0.0.0/0 | RPC
    TCP personalizado | TCP | 2049 | 0.0.0.0/0 | NFS
    UDP personalizado | UDP | 2049 | 0.0.0.0/0 | NFS
    
    
    -----------------------------------------------------------------------------
    
    
### Configuração do NFS entregue.

- Criar um diretório para o NFS com o comando `sudo mkdir /mnt/nfs`.
- No console pesquisar pelo serviço EFS
- Crie um EFS
- Clique no EFS criado e siga para a parte de "Network"
- Altere todos os Security Groups para o mesmo usado na sua instância indo em "Manage" e alterando nessa área
- Volte e clique em "Attach" e copie o comando que será usado para montar o nfs (comando + dns)  
- Montar o NFS no diretório usando o comando `sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport dns_do_nfs:/ /mnt/nfs`.
- Verificar se o NFS foi montado utilizando o comando `df -h`.
- Configurar o NFS para montar automaticamente no boot usando o comando `sudo nano /etc/fstab`.
- Edite a linha para ficar da seguinte maneira no arquivo `/etc/fstab`:
    ```
    UUID= dns_do_nfs:/ /mnt/nfs     /           nfs    defaults,noatime  0   0
    ```
- Salvar o arquivo `/etc/fstab`.
- Criar um novo diretório para o usuário pedro menna usando o comando `sudo mkdir /mnt/nfs/pedromenna`.
