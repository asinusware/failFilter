#!/bin/bash
linea=1
# IMPORTANTE: ACA MAS BIEN VA TEXT2 (LO DE HOY) para que sea mas natural
# ESTA PENDIENTE MODIFICAR ESO EN TODO EL CODIGO
nlineas=`cat text2.txt | wc -l`
cat /dev/null > temporal.txt
while (( "$linea" <= "$nlineas" ))
do
   cadena_buscada=`sed -n "$linea""p" text2.txt | awk -F "," '{ print $2 }'`
   #echo "Buscando: $cadena_buscada"
   ed -s text.txt <<< 1,$g/"$cadena_buscada"/
# $? ME SERVIRIA PARA VALIDAR SI SE REUSA LA FALLA DE AYER Y DE PASO SABER
# SI ENTONCES ES UNA FALLA NUEVA!!! GREAT!!!
   if [ $? == 0  ]; then
      curFail=`sed -n "$linea""p" text2.txt | awk -F "," '{ print $3 }'`
      #echo "texto2: $curFail"
      oldFail=`ed -s text.txt <<< 1,$g/"$cadena_buscada"/ | awk -F "," ' { print $3 } '`
      #echo "la falla que se reusara es: $oldFail"
      falla=`ed -s text2.txt <<< "$linea"s/"$curFail"/"$oldFail"/p`
      echo "$falla" >> temporal.txt
   else
      sed -n "$linea"p text2.txt >> temporal.txt
   fi
   linea=$[ linea + 1 ]
done

