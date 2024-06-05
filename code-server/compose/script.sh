#!/bin/bash

# Iniciar o SSHD
/usr/sbin/sshd -D

# Iniciar o code-server
/code-server/bin/code-server --bind-addr 0.0.0.0:8080 --auth password