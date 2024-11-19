#!/bin/bash

# Configuración de MySQL
DB_NAME="PrestamosElPinar"
DB_USER="prestausuario"
DB_PASS="prestacontraseña"

# Función para crear un nuevo usuario
crear_usuario() {
    echo "Crear un nuevo usuario:"
    read -p "Ingrese el nombre del usuario: " nombre
    read -p "Ingrese el apellido del usuario: " apellido
    read -p "Ingrese el email del usuario: " email
    read -p "Ingrese el teléfono del usuario: " telefono

    mysql -u $DB_USER -p$DB_PASS <<EOF
USE $DB_NAME;

INSERT INTO Usuarios (nombre, apellido, email, telefono)
VALUES ('$nombre', '$apellido', '$email', '$telefono');
EOF
    echo "Usuario creado exitosamente."
}

# Función para modificar un usuario existente
modificar_usuario() {
    echo "Modificar un usuario existente:"
    read -p "Ingrese el ID del usuario a modificar: " id_usuario

    # Verificar si el usuario existe
    resultado=$(mysql -u $DB_USER -p$DB_PASS -e "USE $DB_NAME; SELECT COUNT(*) FROM Usuarios WHERE id_usuario = $id_usuario;" | tail -n 1)
    if [[ $resultado -eq 0 ]]; then
        echo "El usuario con ID $id_usuario no existe."
        return
    fi

    echo "Seleccione el campo que desea modificar:"
    echo "1. Nombre"
    echo "2. Apellido"
    echo "3. Email"
    echo "4. Teléfono"
    echo "5. Cancelar"
    read -p "Opción: " opcion

    case $opcion in
        1) 
            read -p "Ingrese el nuevo nombre: " nombre
            mysql -u $DB_USER -p$DB_PASS <<EOF
USE $DB_NAME;
UPDATE Usuarios SET nombre = '$nombre' WHERE id_usuario = $id_usuario;
EOF
            echo "Nombre actualizado."
            ;;
        2) 
            read -p "Ingrese el nuevo apellido: " apellido
            mysql -u $DB_USER -p$DB_PASS <<EOF
USE $DB_NAME;
UPDATE Usuarios SET apellido = '$apellido' WHERE id_usuario = $id_usuario;
EOF
            echo "Apellido actualizado."
            ;;
        3) 
            read -p "Ingrese el nuevo email: " email
            mysql -u $DB_USER -p$DB_PASS <<EOF
USE $DB_NAME;
UPDATE Usuarios SET email = '$email' WHERE id_usuario = $id_usuario;
EOF
            echo "Email actualizado."
            ;;
        4)
            read -p "Ingrese el nuevo teléfono: " telefono
            mysql -u $DB_USER -p$DB_PASS <<EOF
USE $DB_NAME;
UPDATE Usuarios SET telefono = '$telefono' WHERE id_usuario = $id_usuario;
EOF
            echo "Teléfono actualizado."
            ;;
        5) 
            echo "Modificación cancelada."
            ;;
        *) 
            echo "Opción inválida."
            ;;
    esac
}

# Función para eliminar un usuario
eliminar_usuario() {
    echo "Eliminar un usuario:"
    read -p "Ingrese el ID del usuario a eliminar: " id_usuario

    # Verificar si el usuario existe
    resultado=$(mysql -u $DB_USER -p$DB_PASS -e "USE $DB_NAME; SELECT COUNT(*) FROM Usuarios WHERE id_usuario = $id_usuario;" | tail -n 1)
    if [[ $resultado -eq 0 ]]; then
        echo "El usuario con ID $id_usuario no existe."
        return
    fi

    # Confirmación de eliminación
    read -p "¿Está seguro de que desea eliminar el usuario con ID $id_usuario? (s/n): " confirmacion
    if [[ "$confirmacion" == "s" ]]; then
        mysql -u $DB_USER -p$DB_PASS <<EOF
USE $DB_NAME;
DELETE FROM Usuarios WHERE id_usuario = $id_usuario;
EOF
        echo "Usuario eliminado exitosamente."
    else
        echo "Eliminación cancelada."
    fi
}

# Función para listar usuarios
listar_usuarios() {
    echo "Usuarios en el sistema:"
    mysql -u $DB_USER -p$DB_PASS -e "
USE $DB_NAME;
SELECT id_usuario, nombre, apellido, email, telefono
FROM Usuarios;
"
}

# Funciones para gestionar equipos
crear_equipo() {
    echo "Crear un nuevo equipo:"
    read -p "Ingrese el nombre del equipo: " nombre
    read -p "Ingrese la descripción del equipo: " descripcion

    mysql -u $DB_USER -p$DB_PASS <<EOF
USE $DB_NAME;

INSERT INTO Equipos (nombre, descripcion)
VALUES ('$nombre', '$descripcion');
EOF
    echo "Equipo creado exitosamente."
}

modificar_equipo() {
    echo "Modificar un equipo existente:"
    read -p "Ingrese el ID del equipo a modificar: " id_equipo

    # Verificar si el equipo existe
    resultado=$(mysql -u $DB_USER -p$DB_PASS -e "USE $DB_NAME; SELECT COUNT(*) FROM Equipos WHERE id_equipo = $id_equipo;" | tail -n 1)
    if [[ $resultado -eq 0 ]]; then
        echo "El equipo con ID $id_equipo no existe."
        return
    fi

    echo "Seleccione el campo que desea modificar:"
    echo "1. Nombre"
    echo "2. Descripción"
    echo "3. Cancelar"
    read -p "Opción: " opcion

    case $opcion in
        1) 
            read -p "Ingrese el nuevo nombre del equipo: " nombre
            mysql -u $DB_USER -p$DB_PASS <<EOF
USE $DB_NAME;
UPDATE Equipos SET nombre = '$nombre' WHERE id_equipo = $id_equipo;
EOF
            echo "Nombre del equipo actualizado."
            ;;
        2) 
            read -p "Ingrese la nueva descripción del equipo: " descripcion
            mysql -u $DB_USER -p$DB_PASS <<EOF
USE $DB_NAME;
UPDATE Equipos SET descripcion = '$descripcion' WHERE id_equipo = $id_equipo;
EOF
            echo "Descripción del equipo actualizada."
            ;;
        3) 
            echo "Modificación cancelada."
            ;;
        *) 
            echo "Opción inválida."
            ;;
    esac
}

eliminar_equipo() {
    echo "Eliminar un equipo:"
    read -p "Ingrese el ID del equipo a eliminar: " id_equipo

    # Verificar si el equipo existe
    resultado=$(mysql -u $DB_USER -p$DB_PASS -e "USE $DB_NAME; SELECT COUNT(*) FROM Equipos WHERE id_equipo = $id_equipo;" | tail -n 1)
    if [[ $resultado -eq 0 ]]; then
        echo "El equipo con ID $id_equipo no existe."
        return
    fi

    # Confirmación de eliminación
    read -p "¿Está seguro de que desea eliminar el equipo con ID $id_equipo? (s/n): " confirmacion
    if [[ "$confirmacion" == "s" ]]; then
        mysql -u $DB_USER -p$DB_PASS <<EOF
USE $DB_NAME;
DELETE FROM Equipos WHERE id_equipo = $id_equipo;
EOF
        echo "Equipo eliminado exitosamente."
    else
        echo "Eliminación cancelada."
    fi
}

listar_equipos() {
    echo "Equipos en el sistema:"
    mysql -u $DB_USER -p$DB_PASS -e "
USE $DB_NAME;
SELECT id_equipo, nombre, descripcion
FROM Equipos;
"
}

# Menú principal del script
mostrar_menu() {
    echo "Seleccione una opción:"
    echo "1. Crear un nuevo usuario"
    echo "2. Modificar un usuario"
    echo "3. Eliminar un usuario"
    echo "4. Listar usuarios"
    echo "5. Crear un nuevo equipo"
    echo "6. Modificar un equipo"
    echo "7. Eliminar un equipo"
    echo "8. Listar equipos"
    echo "9. Salir"
}

# Lógica para mostrar el menú y recibir la opción del usuario
while true; do
    mostrar_menu
    read -p "Opción: " opcion
    case $opcion in
        1) crear_usuario ;;
        2) modificar_usuario ;;
        3) eliminar_usuario ;;
        4) listar_usuarios ;;
        5) crear_equipo ;;
        6) modificar_equipo ;;
        7) eliminar_equipo ;;
        8) listar_equipos ;;
        9) echo "Saliendo..."; exit 0 ;;
        *) echo "Opción inválida, por favor intente de nuevo." ;;
    esac
done
