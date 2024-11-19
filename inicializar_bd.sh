#!/bin/bash

# Configuración de MySQL
DB_NAME="PrestamosElPinar"
DB_USER="prestausuario"
DB_PASS="prestacontraseña"

# Crear la base de datos si no existe
echo "Creando la base de datos $DB_NAME si no existe..."
mysql -u $DB_USER -p$DB_PASS <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
EOF
echo "Base de datos $DB_NAME creada o ya existente."

# Crear las tablas si no existen
echo "Creando tablas en la base de datos $DB_NAME..."

mysql -u $DB_USER -p$DB_PASS <<EOF
USE $DB_NAME;

-- Crear tabla Usuarios
CREATE TABLE IF NOT EXISTS Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

-- Crear tabla Equipos
CREATE TABLE IF NOT EXISTS Equipos (
    id_equipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL
);

-- Crear tabla Prestamos
CREATE TABLE IF NOT EXISTS Prestamos (
    id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_equipo INT NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE NOT NULL,
    caducado BOOLEAN DEFAULT 0,
    borrable BOOLEAN DEFAULT 0,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_equipo) REFERENCES Equipos(id_equipo)
);
EOF

echo "Tablas creadas exitosamente (si no existían)."
echo "La base de datos y las tablas están configuradas correctamente."
