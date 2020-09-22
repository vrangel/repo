#!/bin/bash

echo Iniciando...

while IFS=";" read mail dcos
do
    echo -e "\nAtualizando os DCOs $dcos de $mail"

    adcos=($(echo $dcos | tr "," "\n"))
    jdcos="["

    for dco in "${adcos[@]}"
    do
	jdcos+="\"$dco\","
    done

    curl --request PUT \
      --url http://comercial.riachuelo.net/api/portal/usuariodcos \
      --header 'content-type: application/json' \
      --data @<(cat <<EOF
{
        "mail": "$mail",
        "dcos": ${jdcos%?}]
}
EOF
)
done < base-vitor.csv

echo -e "\n\nFinalizado."
