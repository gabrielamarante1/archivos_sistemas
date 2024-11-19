#!/bin/bash

# Configuración de MySQL
DB_NAME="PrestamosElPinar"
DB_USER="prestausuario"
DB_PASS="prestacontraseña"

# Función para crear un nuevo préstamo
crear_prestamo() {
    echo "Crear un nuevo préstamo:"
    read -p "Ingrese el ID del usuario: " id_usuario
    read -p "Ingrese el ID del equipo: " id_equipo
    read -p "Ingrese la fecha del préstamo (YYYY-MM-DD): " fecha_prestamo
    read -p "Ingrese la fecha de devolución (YYYY-MM-DD): " fecha_devolucion

    mysql -u $DB_USER -p$DB_PASS <<EOF
USE $DB_NAME;

INSERT INTO Prestamos (id_usuario, id_equipo, fecha_prestamo, fecha_devolucion, caducado, borrable)
VALUES ($id_usuario, $id_equipo, '$fecha_prestamo', '$fecha_devolucion', 0, 0);
EOF
    echo "Préstamo creado exitosamente."
}

# Función para listar préstamos
listar_prestamos() {
    echo "Préstamos en el sistema:"
    mysql -u $DB_USER -p$DB_PASS -e "
USE $DB_NAME;
SELECT id_prestamo, id_usuario, id_equipo, fecha_prestamo, fecha_devolucion, caducado, borrable
FROM Prestamos;
"
}

# Menú principal del script
mostrar_menu() {
    echo "Seleccione una opción:"
    echo "1. Crear un nuevo préstamo"
    echo "2. Listar préstamos"
    echo "3. Salir"
}

# Lógica para mostrar el menú y recibir la opción del usuario
while true; do
    mostrar_menu
    read -p "Opción: " opcion
    case $opcion in
        1) crear_prestamo ;;
        2) listar_prestamos ;;
        3) echo "Saliendo..."; exit 0 ;;
        *) echo "Opción inválida, por favor intente de nuevo." ;;
    esac
done

