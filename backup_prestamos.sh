#!/bin/bash
FECHA=$(date +%F)
NOMBRE_BACKUP="prestamossoft_backup_$FECHA.sql"
mysqldump -u prestausuario -pprestacontraseña PrestamosElPinar > /$HOME/Documentos/PrestamosSoft/$NOMBRE_BACKUP
echo "Backup creado en /$HOME/Documentos/PrestamosSoft/$NOMBRE_BACKUP"

