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
      --url http://comercial-dev.riachuelo.net/api/portal/usuariodcos \
      --header 'content-type: application/json' \
      --data @<(cat <<EOF
{
        "mail": "$mail",
        "dcos": ${jdcos%?}]
}
EOF
)
done < test.csv

echo -e "\n\nFinalizado."
