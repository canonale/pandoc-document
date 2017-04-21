#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Es necesario indicar la ruta del fichero"
    exit
fi

if [ ! -f $1 ]; then
    echo "El fichero $1 no existe"
    exit
fi

chapters=$1

function 64image() {
    if [ $# -eq 0 ]; then
        echo "Necesite el nombre de la imagen"
        return 1
    fi
    if [ -f $1 ]; then
        mime=$(file --mime-type -b $1)
        img=$(base64 $1 | paste -s -d "")
        echo "data:$mime;base64,$img"
    fi
}

for x in $(sed -n '/^\[[^]]\+\]:.*\/imagenes\//{s;.*: \(./imagenes/.*\) ".*;\1;g;p}' ${chapters})
do 
    b64=$(64image $x)
    sed -i "s|${x}|${b64}|"  ${chapters}
done
