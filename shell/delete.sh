#!/bin/bash

# Obtener el nombre de usuario
username=$(whoami)

# Contar cuántos archivos se borrarán
file_count=$(ls -1 "$username"-* 2>/dev/null | wc -l)

if [ $file_count -eq 0 ]; then
    echo "No se encontraron archivos para borrar."
    exit 0
fi

# Mostrar los archivos que se borrarán
echo "Se encontraron $file_count archivos:"
ls -l "$username"-*

# Pedir confirmación
echo
echo "¿Estás seguro de que quieres borrar estos archivos? (s/n)"
read -r respuesta

if [ "$respuesta" = "s" ] || [ "$respuesta" = "S" ]; then
    # Borrar los archivos
    rm "$username"-*
    echo "Archivos borrados exitosamente."
else
    echo "Operación cancelada. No se borró ningún archivo."
fi