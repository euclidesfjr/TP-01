#!/bin/sh

#

NOME=`basename $0`
#

# Funcoes
#

uso() {
   cat --  <<FIM
   $NOME - Uso:
   $NOME arquivo
FIM
}

erro() {
   cat -- <<FIM
   $NOME - Erro:
   $*
FIM
}

#
# Corpo do script
#

if [ $# -ne 1 ]; then
   uso
   exit 1
fi

if [ ! -r $1 ]; then
    erro "Arquivo informado [${1}] nao exite/nao pode ser lido."
    exit 1
fi

cat $1 | sed  '/^$/d' | while read linha
do
   set $linha
   echo "$*"
   case $# in
       2 ) ;;
       * )
           i=2
           partes=`echo "$linha" | sed -e 's~ ~:~g'`
           while [ $i -lt $# ]
           do
              c1=`echo "$partes" | cut -d':' -f1`
              c2=`echo "$partes" | cut -d':' -f${i}`
              c3=`echo "$partes" | cut -d':' -f${#}`
              echo "   ${c1};${c2};${c3}"
              i=`expr $i + 1`
           done
   esac
done

#
# E.F.
#
