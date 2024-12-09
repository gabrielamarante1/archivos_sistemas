#!/bin/bash

# Comprobamos que el script se ejecute con permisos de root. Requiere permiso de superusuario. Esto para prevenir que nos equivoquemos de nuevooo
if [[ $EUID -ne 0 ]]; then
    echo "Este script debe ejecutarse como root"
    exit 1
fi

# Función para gestionar usuarios
menu_usuarios() {
    while true; do
        echo "=== GESTIÓN DE USUARIOS ==="
        echo "1) Crear usuario"
        echo "2) Modificar usuario"
        echo "3) Eliminar usuario"
        echo "4) Listar usuarios"
        echo "5) Volver al menú principal"
        read -p "Seleccioná una opción: " opcion

        case $opcion in
            1) crear_usuario ;;
            2) editar_usuario ;;
            3) remover_usuario ;;
            4) listar_usuarios ;;
            5) return ;;
            *) echo "Opción inválida. Intentá de nuevo." ;;
        esac
    done
}

# Función para gestionar grupos
menu_grupos() {
    while true; do
        echo "=== GESTIÓN DE GRUPOS ==="
        echo "1) Crear grupo"
        echo "2) Modificar grupo"
        echo "3) Eliminar grupo"
        echo "4) Listar grupos"
        echo "5) Volver al menú principal"
        read -p "Seleccioná una opción: " opcion

        case $opcion in
            1) crear_grupo ;;
            2) modificar_grupo ;;
            3) eliminar_grupo ;;
            4) listar_grupos ;;
            5) return ;;
            *) echo "Opción inválida. Intentá de nuevo." ;;
        esac
    done
}

# Funciones para usuarios
crear_usuario() {
    read -p "Ingresá el nombre del usuario a crear: " username
    read -p "Ingresá el shell del usuario (dejar en blanco para /bin/bash): " shell
    shell=${shell:-/bin/bash}
    useradd -m -s "$shell" "$username"

    if [[ $? -eq 0 ]]; then
        echo "Usuario '$username' creado exitosamente."
    else
        echo "Error al crear el usuario '$username'."
    fi
}

editar_usuario() {
    read -p "Ingresá el nombre del usuario a editar: " username
    read -p "Ingresá el nuevo shell para el usuario (dejar en blanco para no cambiar): " shell
    read -p "Ingresá el nuevo nombre para el usuario (dejar en blanco para no cambiar): " new_username

    [[ -n $shell ]] && usermod -s "$shell" "$username"
    if [[ -n $new_username ]]; then
        usermod -l "$new_username" "$username"
        username="$new_username"
    fi

    echo "Edición del usuario '$username' completada."
}

remover_usuario() {
    read -p "Ingresá el nombre del usuario a eliminar: " username
    userdel -r "$username"

    if [[ $? -eq 0 ]]; then
        echo "Usuario '$username' eliminado."
    else
        echo "Error al eliminar el usuario '$username'."
    fi
}

listar_usuarios() {
    echo "=== Lista de usuarios ==="
    cut -d: -f1 /etc/passwd
}

# Funciones para grupos
crear_grupo() {
    read -p "Ingresá el nombre del grupo a crear: " groupname
    groupadd "$groupname"

    if [[ $? -eq 0 ]]; then
        echo "Grupo '$groupname' creado."
    else
        echo "Error al crear el grupo '$groupname'."
    fi
}

modificar_grupo() {
    read -p "Ingresá el nombre del grupo a modificar: " groupname
    read -p "Ingresá el nuevo nombre del grupo: " new_groupname
    groupmod -n "$new_groupname" "$groupname"

    if [[ $? -eq 0 ]]; then
        echo "Grupo '$groupname' renombrado a '$new_groupname'."
    else
        echo "Error al modificar el grupo '$groupname'."
    fi
}

eliminar_grupo() {
    read -p "Ingrese el nombre del grupo a eliminar: " groupname
    groupdel "$groupname"

    if [[ $? -eq 0 ]]; then
        echo "Grupo '$groupname' eliminado."
    else
        echo "Error al eliminar el grupo '$groupname'."
    fi
}

listar_grupos() {
    echo "=== Lista de grupos ==="
    cut -d: -f1 /etc/group
}

# Función para ejecutar backup . Aca estamos comprobando si tiene -x por las dudas. Evitar pifiarle de nuevo
ejecutar_backup() {
    if [[ -x ./backup.sh ]]; then
        ./backup.sh
    else
        echo "El script 'backup.sh' no existe o no tiene permisos -x."
    fi
}

# Menú principal
while true; do
    echo "=== MENÚ PRINCIPAL ==="
    echo "1) USUARIOS"
    echo "2) GRUPOS"
    echo "3) BACKUP"
    echo "4) Salir"
    read -p "Seleccioná una opción: " opcion

    case $opcion in
        1) menu_usuarios ;;
        2) menu_grupos ;;
        3) ejecutar_backup ;;
        4) echo "Saliendo..."; exit 0 ;;
        *) echo "Opción no valida. Intentá de nuevo." ;;
    esac
done
