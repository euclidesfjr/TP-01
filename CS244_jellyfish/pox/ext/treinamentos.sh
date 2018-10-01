#!/bin/bash
clear 

######################################################
#          SCRIPT PARA TREINAMENTOS JELLYFISH        #
#                                                    #
# Autor: Euclides Peres Farias Junior                #
# 28/09/2018   - versão 1.0                          #
#                                                    #
# Este script executa as opções automáticas para que #
# se possa fazer os treinamentos com os parâmetros   #
# setados com os seguintes status:                   #
#                   SEM MPTCP e SEM MPTCP            #
######################################################
##.


echo "Coleda de dados das Simulações do algoritmo - Jellyfish"
MED_MPTCP=0  #ecmp8
MED_SMPTCP=0 #8_shortest
MED_ECMP1F=0 #ecmp8 1 fluxo 
MED_ECMP8F=0 #ecmp8 8 fluxos
MED_KB1F=0 #8_shortest 1 fluxo
MED_KB8F=0 #8_shortest 8 fluxos
MED_AUX=0  #recebe dados para troca de informações


### execução 01
sudo mn -c 1> /dev/null 2> /dev/stdout

#Script que garante que não está ativo o MPTCP
sudo ./desabilita_mptcp.sh

#### Execução do script Jellyfish com r_method = emp8, fluxos = 1, servidores = 10  
echo "===> execução 01"
echo " "
echo "---------------  executando o treinamento -------------------------------------------"
echo "--------------- Jellyfish com r_method = ecmp8, fluxos = 1, servidores = 10 ----"
echo "--------------- SEM MPTCP------------------------------------------------------------"
echo " "
echo " "

#Limpa todos os processos do Python
sudo killall python
sleep 5

#Limpa todas as execuções no mininet
sudo mn -c 1> /dev/null 2> /dev/stdout
sleep 5


nohup sudo python build_topology.py


#### Execução do script completo, onde faz um backup dos resultados extraídos.
tar -cvzf resultado-01.tgz *.err *.out; echo "=======================================================" >> Relatorio_coletadas.csv; echo "#### * * * SEM MPTCP #### r_method = ecmp8, fluxos = 1, servidores = 10 ####################" >> Relatorio_coletadas.csv;echo " " >> Relatorio_coletadas.csv;sed -n '33,40p' build_topology.py >> Relatorio_coletadas.csv; cat nohup.out |head -3 >> Relatorio_coletadas.csv;cat nohup.out | grep average >> Relatorio_coletadas.csv


#Script que recebe os valores extraídos da execução para cálculo das médias.
MED_AUX=`grep average nohup.out | cut -d"=" -f2 | cut -d" " -f2`
MED_ECMP1F=`echo "scale=2; ($MED_ECMP1F + $MED_AUX)" | bc -l`

echo "removendo os arquivos de saida e erro ..."
rm -rf *.err *.out
############### fim da primeira execução do Jellyfish ########################################
#--------------------------------------------------------------------------------------------#


### execução 02
#### Execução do script Jellyfish com r_method = ecmp8, fluxos = 8, servidores = 10  
echo "===> execução 02"
echo " "
echo "----------------------  executando o treinamento --------------------------"
echo "---------------------- Jellyfish com r_method = ecmp8, fluxos = 8, servidores = 10 ----"
echo "--------------- SEM MPTCP------------------------------------------------------------"
echo " "
echo " "


#Limpa todos os processos do Python
sudo killall python
sleep 5

#Limpa todas as execuções no mininet
sudo mn -c 1> /dev/null 2> /dev/stdout
sleep 5

#Muda de parâmetros = FLUXOS de 1 para 8
cat build_topology.py | sed -i '39s/number_of_tcp_flows = 1/number_of_tcp_flows = 8/' build_topology.py

#script que executa o Jellyfish
nohup sudo python build_topology.py

#### Execução do script completo, onde faz um backup dos resultados extraídos.
tar -cvzf resultado-02.tgz *.err *.out; echo "=======================================================" >> Relatorio_coletadas.csv; echo "#### * * * SEM MPTCP #### r_method = ecmp8, fluxos = 1, servidores = 10 ####################" >> Relatorio_coletadas.csv;echo " " >> Relatorio_coletadas.csv;sed -n '33,40p' build_topology.py >> Relatorio_coletadas.csv; cat nohup.out |head -3 >> Relatorio_coletadas.csv;cat nohup.out | grep average >> Relatorio_coletadas.csv


#Script que recebe os valores extraídos da execução para cálculo das médias.
MED_AUX=`grep average nohup.out | cut -d"=" -f2 | cut -d" " -f2`
MED_ECMP8F=`echo "scale=2; ($MED_ECMP8F + $MED_AUX)" | bc -l`

echo "removendo os arquivos de saida e erro ..."
rm -rf *.err *.out
############### fim da primeira execução do Jellyfish ########################################
#--------------------------------------------------------------------------------------------#


### execução 03
echo "====> execução 03"
echo " "
echo "----------------------  executando o treinamento --------------------------"
echo "---------------------- Jellyfish com r_method = 8_shortest, fluxos = 1, servidores = 10 ----"
echo "--------------- SEM MPTCP------------------------------------------------------------"
echo " "
echo " "


#Limpa todos os processos do Python
sudo killall python
sleep 5

#Limpa todas as execuções no mininet
sudo mn -c 1> /dev/null 2> /dev/stdout
sleep 5

#Muda de parâmetros de ecmp8 para 8_shortest
cat build_topology.py | sed -i '37s/'ecmp8'/'8_shortest'/' build_topology.py

#Muda de parâmetros = FLUXOS de 1 para 8
cat build_topology.py | sed -i '39s/number_of_tcp_flows = 8/number_of_tcp_flows = 1/' build_topology.py

#script que executa o Jellyfish
nohup sudo python build_topology.py

#### Execução do script completo, onde faz um backup dos resultados extraídos.
tar -cvzf resultado-03.tgz *.err *.out; echo "=======================================================" >> Relatorio_coletadas.csv; echo "#### * * * SEM MPTCP #### r_method = 8_shortest, fluxos = 1, servidores = 10 ####################" >> Relatorio_coletadas.csv;echo " " >> Relatorio_coletadas.csv;sed -n '33,40p' build_topology.py >> Relatorio_coletadas.csv; cat nohup.out |head -3 >> Relatorio_coletadas.csv;cat nohup.out | grep average >> Relatorio_coletadas.csv


#Script que recebe os valores extraídos da execução para cálculo das médias.
MED_AUX=`grep average nohup.out | cut -d"=" -f2 | cut -d" " -f2`
MED_KB1F=`echo "scale=2; ($MED_KB1F + $MED_AUX)" | bc -l`

echo "removendo os arquivos de saida e erro ..."
rm -rf *.err *.out
############### fim da primeira execução do Jellyfish ########################################

#--------------------------------------------------------------------------------------------#

### execução 04
echo "====> execução 04"
echo " "
echo "----------------------  executando o treinamento --------------------------"
echo "---------------------- Jellyfish com r_method = 8_shortest, fluxos = 8, servidores = 10 ----"
echo "--------------- SEM MPTCP------------------------------------------------------------"
echo " "
echo " "


#Limpa todos os processos do Python
sudo killall python
sleep 5

#Limpa todas as execuções no mininet
sudo mn -c 1> /dev/null 2> /dev/stdout
sleep 5

#Muda de parâmetros de ecmp8 para 8_shortest
#cat build_topology.py | sed -i '37s/'ecmp8'/'8_shortest'/' build_topology.py

#Muda de parâmetros = FLUXOS de 1 para 8
cat build_topology.py | sed -i '39s/number_of_tcp_flows = 1/number_of_tcp_flows = 8/' build_topology.py

#script que executa o Jellyfish
nohup sudo python build_topology.py

#### Execução do script completo, onde faz um backup dos resultados extraídos.
tar -cvzf resultado-04.tgz *.err *.out; echo "=======================================================" >> Relatorio_coletadas.csv; echo "#### * * * SEM MPTCP #### r_method = 8_shortest, fluxos = 1, servidores = 10 ####################" >> Relatorio_coletadas.csv;echo " " >> Relatorio_coletadas.csv;sed -n '33,40p' build_topology.py >> Relatorio_coletadas.csv; cat nohup.out |head -3 >> Relatorio_coletadas.csv;cat nohup.out | grep average >> Relatorio_coletadas.csv


#Script que recebe os valores extraídos da execução para cálculo das médias.
MED_AUX=`grep average nohup.out | cut -d"=" -f2 | cut -d" " -f2`
MED_KB8F=`echo "scale=2; ($MED_KB8F + $MED_AUX)" | bc -l`

echo "removendo os arquivos de saida e erro ..."
rm -rf *.err *.out
############### fim da primeira execução do Jellyfish ########################################

#**************************************************************************************************
#**************************************************************************************************


echo "================== EXECUÇÃO COM MPTCP STARTADO ==========="
### execução 05
sudo mn -c 1> /dev/null 2> /dev/stdout

#Script que garante que não está ativo o MPTCP

echo "====> execução 05"
echo " "
echo "----------------------  executando o treinamento --------------------------"
echo "---------------------- Jellyfish com r_method = ecmp8, fluxos = 1, servidores = 10 ----"
echo "--------------- COM MPTCP------------------------------------------------------------"
echo " "
echo " "


#Limpa todos os processos do Python
sudo killall python
sleep 5

#Limpa todas as execuções no mininet
sudo mn -c 1> /dev/null 2> /dev/stdout
sleep 5

#Muda de parâmetros de ecmp8 para 8_shortest
cat build_topology.py | sed -i '37s/'8_shortest'/'ecmp8'/' build_topology.py

#Muda de parâmetros = FLUXOS de 1 para 8
cat build_topology.py | sed -i '39s/number_of_tcp_flows = 8/number_of_tcp_flows = 1/' build_topology.py

#script que executa o Jellyfish
nohup sudo python build_topology.py

#### Execução do script completo, onde faz um backup dos resultados extraídos.
tar -cvzf resultado-05.tgz *.err *.out; echo "=======================================================" >> Relatorio_coletadas.csv; echo "#### * * * COM MPTCP #### r_method = ecmp8, fluxos = 1, servidores = 10 ####################" >> Relatorio_coletadas.csv;echo " " >> Relatorio_coletadas.csv;sed -n '33,40p' build_topology.py >> Relatorio_coletadas.csv; cat nohup.out |head -3 >> Relatorio_coletadas.csv;cat nohup.out | grep average >> Relatorio_coletadas.csv


#Script que recebe os valores extraídos da execução para cálculo das médias.
MED_AUX=`grep average nohup.out | cut -d"=" -f2 | cut -d" " -f2`
MED_MPTCP=`echo "scale=2; ($MED_MPTCP + $MED_AUX)" | bc -l`

echo "removendo os arquivos de saida e erro ..."
rm -rf *.err *.out
############### fim da primeira execução do Jellyfish ########################################

#--------------------------------------------------------------------------------------------#


echo "================== EXECUÇÃO COM MPTCP STARTADO ==========="
### execução 06
sudo mn -c 1> /dev/null 2> /dev/stdout

#Script que garante que não está ativo o MPTCP
sudo ./habilita_mptcp.sh

echo "====> execução 06"
echo " "
echo "----------------------  executando o treinamento --------------------------"
echo "---------------------- Jellyfish com r_method = 8_shortest, fluxos = 1, servidores = 10 ----"
echo "--------------- COM MPTCP------------------------------------------------------------"
echo " "
echo " "


#Limpa todos os processos do Python
sudo killall python
sleep 5

#Limpa todas as execuções no mininet
sudo mn -c 1> /dev/null 2> /dev/stdout
sleep 5

#Muda de parâmetros de ecmp8 para 8_shortest
cat build_topology.py | sed -i '37s/'ecmp8'/'8_shortest'/' build_topology.py

#Muda de parâmetros = FLUXOS de 1 para 8
#cat build_topology.py | sed -i '39s/number_of_tcp_flows = 8/number_of_tcp_flows = 1/' build_topology.py

#script que executa o Jellyfish
nohup sudo python build_topology.py

#### Execução do script completo, onde faz um backup dos resultados extraídos.
tar -cvzf resultado-06.tgz *.err *.out; echo "=======================================================" >> Relatorio_coletadas.csv; echo "#### * * * COM MPTCP #### r_method = ecmp8, fluxos = 1, servidores = 10 ####################" >> Relatorio_coletadas.csv;echo " " >> Relatorio_coletadas.csv;sed -n '33,40p' build_topology.py >> Relatorio_coletadas.csv; cat nohup.out |head -3 >> Relatorio_coletadas.csv;cat nohup.out | grep average >> Relatorio_coletadas.csv


#Script que recebe os valores extraídos da execução para cálculo das médias.
MED_AUX=`grep average nohup.out | cut -d"=" -f2 | cut -d" " -f2`
MED_SMPTCP=`echo "scale=2; ($MED_SMPTCP + $MED_AUX)" | bc -l`

echo "removendo os arquivos de saida e erro ..."
rm -rf *.err *.out
############### fim da primeira execução do Jellyfish ########################################

echo " " >> Relatorio_coletadas.csv
echo "=======================================================================" >> Relatorio_coletadas.csv
echo "---------------- TABELA DOS RESULTADOS EXTRAÍDOS OS EXPERIMENTOS ------" >> Relatorio_coletadas.csv
echo " " 

echo "-------------------------------------------------------------" >> Relatorio_coletadas.csv
echo "|CONGESTION      | FAT-TREE (10 SVRS)|  JELLYFISH (10 SVRS)  |" >> Relatorio_coletadas.csv
echo "|CONTROL         |        ECMP       |ECMP  |8-SHORTEST PATHS|" >> Relatorio_coletadas.csv
echo "|TCP 1 FLOW      |                   |$MED_ECMP1F%|    $MED_KB1F%     |" >> Relatorio_coletadas.csv
echo "|TCP 8 FLOWS     |                   |$MED_ECMP8F%|   $MED_KB8F%       |" >> Relatorio_coletadas.csv
echo "|MPTCP 8 SUBFLOWS|                   |$MED_MPTCP%|   $MED_SMPTCP%       |" >> Relatorio_coletadas.csv
echo "-------------------------------------------------------------" >> Relatorio_coletadas.csv

echo "Execuções dos experimentos realizadas com Sucesso!" >> Relatorio_coletadas.csv
