#!/bin/bash

# Definimos la fecha y el nombre del archivo de backup
FECHA=$(date +%F)
NOMBRE_BACKUP="prestamossoft_backup_$FECHA.sql"

# Ruta completa del directorio donde se guardará el backup
DIRECTORIO_BACKUP="./Backup"

# Crear la carpeta Backup si no existe
mkdir -p "$DIRECTORIO_BACKUP"

# Ejecutamos el backup
mysqldump -u prestausuario -pprestacontrasena PrestamosElPinar > "$DIRECTORIO_BACKUP/$NOMBRE_BACKUP"

# Mensaje de confirmación
echo "Backup creado en $DIRECTORIO_BACKUP/$NOMBRE_BACKUP"

