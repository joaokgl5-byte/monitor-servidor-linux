#!/bin/bash

LOG="$HOME/monitor-servidor/logs/monitoramento.log"

{
	echo "===== MONITORAMENTO DO SERVIDOR ====="
	echo "Data e hora:"
	date

	echo "===== USO DE MEMORIA ====="
	free -h

	echo "===== USO DO DISCO ====="
	df -h

	echo "===== ALERTA DE DISCO ====="
	USO_DISCO=$(df -P / | awk 'NR==2 {gsub(/%/, "", $5); print $5}')

	if [ "$USO_DISCO" -ge 80 ]; then
    	     echo "ALERTA: Disco com ${USO_DISCO}% de uso!"
	else
    	     echo "OK: Disco com ${USO_DISCO}% de uso."
	fi

	echo "====================================="
	echo ""
} >> "$LOG"
