# Monitoramento Automatizado de Servidor Linux

## Sobre o projeto

Projeto desenvolvido em um ambiente Rocky Linux virtualizado com Oracle VirtualBox, com o objetivo de praticar administração de servidores, monitoramento de recursos e automação de tarefas.

O sistema utiliza um script Bash para coletar informações sobre memória RAM e utilização de disco, registrando os resultados em um arquivo de log.

A execução é automatizada por meio de um serviço e um timer do systemd.

## Tecnologias utilizadas

- Rocky Linux
- Bash Shell Script
- systemd (Service e Timer)
- SSH
- Oracle VirtualBox
- Git e GitHub

## Funcionalidades

- Monitoramento da memória RAM.
- Verificação da utilização de disco.
- Registro de data e hora.
- Armazenamento de informações em logs.
- Alerta quando a partição raiz atinge 80% ou mais de utilização.
- Execução automática utilizando systemd.

## Testes realizados

O sistema foi testado em dois cenários:

**Situação normal:** disco com 7% de utilização, registrando a mensagem de funcionamento normal.

**Situação de alerta:** simulação de 85% de utilização, registrando corretamente a mensagem de alerta.

A execução automática também foi validada por meio do systemd, com código de saída 0 (sucesso).

## Estrutura do projeto

```text
monitor-servidor/
├── monitor.sh
├── systemd/
│   ├── monitor-servidor.service
│   └── monitor-servidor.timer
├── .gitignore
└── README.md
```

Os logs e arquivos de backup são ignorados pelo Git.

## Instalação

O projeto foi desenvolvido no Rocky Linux com o usuário `joao`.

Para utilizar em outro ambiente, é necessário adaptar o usuário, o diretório de logs e a variável `HOME` no arquivo de serviço.

### 1. Preparar o diretório de logs

```bash
mkdir -p ~/monitor-servidor/logs
```

### 2. Instalar o script

Dentro da pasta do projeto, execute:

```bash
sudo install -m 755 monitor.sh /usr/local/bin/monitor-servidor.sh
```

### 3. Instalar as unidades do systemd

```bash
sudo cp systemd/monitor-servidor.service /etc/systemd/system/
sudo cp systemd/monitor-servidor.timer /etc/systemd/system/
```

### 4. Ativar o monitoramento automático

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now monitor-servidor.timer
```

## Verificação do funcionamento

Consultar o timer:

```bash
systemctl status monitor-servidor.timer
```

Executar o serviço manualmente:

```bash
sudo systemctl start monitor-servidor.service
```

Consultar os registros do serviço:

```bash
sudo journalctl -u monitor-servidor.service -n 15 --no-pager
```

Consultar o arquivo de monitoramento:

```bash
tail -n 25 ~/monitor-servidor/logs/monitoramento.log
```

## Agendamento

O timer utiliza:

- `OnBootSec=1min`: primeira execução aproximadamente um minuto após a inicialização, quando o timer está ativo.
- `OnUnitActiveSec=5min`: agendamento baseado na última ativação da unidade.

## Próximos aprimoramentos

- Monitoramento de CPU.
- Integração com Zabbix.
- Envio de notificações.
- Execução em instâncias AWS EC2.
- Integração com ferramentas de automação DevOps.
