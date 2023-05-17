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
