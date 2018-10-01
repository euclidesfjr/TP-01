#!/bin/bash
##informações sobre o ambiente mptcp

################# Desabilitar a funçao MPTCP  ####################################

#sudo sysctl net.mptcp.mptcp_enabled=0 -w 
#sudo sysctl net.mptcp.mptcp_path_manager=default -w
#sysctl -a |grep mptcp

################# Listtar para conferir a funçao MPTCP  ####################################
#net.mptcp.mptcp_binder_gateways = 
#net.mptcp.mptcp_checksum = 1
#net.mptcp.mptcp_debug = 0
#net.mptcp.mptcp_enabled = 0
#net.mptcp.mptcp_path_manager = default
#net.mptcp.mptcp_scheduler = default
#net.mptcp.mptcp_syn_retries = 3
#net.mptcp.mptcp_version = 0

################# Habilitar a funçao MPTCP  ####################################

sudo sysctl net.mptcp.mptcp_enabled=1 -w 
sudo sysctl net.mptcp.mptcp_path_manager=fullmesh -w
sysctl -a |grep mptcp

################# Listtar para conferir a funçao MPTCP  ####################################
#net.mptcp.mptcp_binder_gateways = 
#net.mptcp.mptcp_checksum = 1
#net.mptcp.mptcp_debug = 0
#net.mptcp.mptcp_enabled = 1
#net.mptcp.mptcp_path_manager = fullmesh
#net.mptcp.mptcp_scheduler = default
#net.mptcp.mptcp_syn_retries = 3
#net.mptcp.mptcp_version = 0
