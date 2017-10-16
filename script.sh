#!/bin/bash
linea=1
# IMPORTANTE: ACA MAS BIEN VA TEXT2 (LO DE HOY) para que sea mas natural
# ESTA PENDIENTE MODIFICAR ESO EN TODO EL CODIGO
nlineas=`cat text.txt | wc -l`

while (( "$linea" <= "$nlineas" ))
do
   cadena_buscada=`sed -n "$linea""p" text.txt | awk -F "," '{ print $2 }'`
   echo "Buscando: $cadena_buscada"
   ed -s text2.txt <<< 1,$g/"$cadena_buscada"/
# $? ME SERVIRIA PARA VALIDAR SI SE REUSA LA FALLA DE AYER Y DE PASO SABER
# SI ENTONCES ES UNA FALLA NUEVA!!! GREAT!!!
   echo "$?"
   linea=$[ linea + 1 ]
done

