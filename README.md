# Documentación del Script de Generación de Archivos

## Descripción General
Este script bash crea 25 archivos vacíos con nombres secuenciales basados en el nombre del usuario actual del sistema. El script está diseñado para continuar la numeración desde el último número existente si ya hay archivos creados.

## Análisis Detallado del Código

### 1. Configuración Inicial
```bash
#!/bin/bash
username=$(whoami)
```
- `#!/bin/bash`: Esta línea (shebang) indica que el script debe ejecutarse usando el intérprete bash
- `username=$(whoami)`: Obtiene el nombre del usuario actual del sistema y lo almacena en la variable `username`

### 2. Búsqueda del Último Número
```bash
last_number=0
for file in "$username"-*; do
    if [ -f "$file" ]; then
        num=$(echo "$file" | grep -o '[0-9]*' | tail -1)
        if [ "$num" -gt "$last_number" ]; then
            last_number=$num
        fi
    fi
done
```
- `last_number=0`: Inicializa la variable que almacenará el número más alto encontrado
- `for file in "$username"-*`: Itera sobre todos los archivos que comienzan con el nombre de usuario
- `if [ -f "$file" ]`: Verifica si el elemento es un archivo regular
  - El parámetro -f es para verificar si un archivo existe y es un archivo regular (no un directorio ni otro tipo de archivo especial).
  -  El parámetro -o extrae las coincidencias extactas en vez de la línea.


### 3. Creación de Nuevos Archivos
```bash
for i in {1..25}; do
    current_number=$((last_number + i))
    touch "$username-$current_number"
done
```
- `for i in {1..25}`: Bucle que se ejecuta 25 veces
- `current_number=$((last_number + i))`: Calcula el siguiente número en la secuencia
- `touch "$username-$current_number"`: Crea un archivo vacío con el nombre formateado

### 4. Visualización de Resultados
```bash
ls -l "$username"-*
```
- Muestra una lista detallada de todos los archivos creados
- La opción `-l` proporciona información detallada como permisos, tamaño y fecha de creación

## Uso del Script

1. Crear el archivo:
   ```bash
   nano create_files.sh
   ```

2. Dar permisos de ejecución:
   ```bash
   chmod +x create_files.sh
   ```

3. Ejecutar el script:
   ```bash
   ./create_files.sh
   ```

## Características Principales
- Detecta automáticamente el nombre del usuario
- Continúa la numeración desde el último archivo existente
- Crea exactamente 25 archivos nuevos
- Maneja nombres de usuario con espacios de manera segura
- Muestra un resumen de los archivos creados

## Ejemplo de Salida
Si el usuario es "john", la salida podría verse así:
```
-rw-r--r-- 1 john john 0 Dec 2 10:00 john-1
-rw-r--r-- 1 john john 0 Dec 2 10:00 john-2
[...]
-rw-r--r-- 1 john john 0 Dec 2 10:00 john-25
```

## Notas Adicionales
- Los archivos creados tienen un tamaño de 0 bytes (están vacíos)
- El script es idempotente: puede ejecutarse múltiples veces sin problemas
- La numeración siempre continúa desde el número más alto encontrado