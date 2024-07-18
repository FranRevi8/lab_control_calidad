
-- Tablas originales:

CREATE TABLE Estudiantes (
    Nombre VARCHAR(100) primary key,
    Cursos VARCHAR(255) -- Aquí almacenamos múltiples cursos en una sola columna
);

-- Esta tabla no es correcta por 2 motivos:
-- 1. No tiene ID.
-- 2. "cursos" almacena objetos.

-- Lo solucionaría haciendo otra tabla "cursos" y una tabla intermedia que relaciones ambas. 
-- Ambas llevarán por supuesto una ID auto_increment que será la primary key.





INSERT INTO Estudiantes (ID, Nombre, Cursos) VALUES
('Juan Pérez', 'Matemáticas, Historia'),
('Ana Gómez', 'Biología'),
('Luis Rodríguez', 'Matemáticas, Física, Química');

-- Hay que cambiar este insert y dividirlo en 3, de manera que rellene las 3 tablas.





CREATE TABLE Productos (
    ID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Categoría VARCHAR(100),
    Proveedor VARCHAR(100),
    Precio DECIMAL(10, 2),
    Proveedores VARCHAR(255) -- Almacenamos los nombres de múltiples proveedores
);

-- En esta tabla veo varios errores:
-- 1. Se usan tildes (desaconsejado). Las quitaré para no tener problemas en el futuro.
-- 2. Falta una tabla "proveedores". De hecho hay dos columnas que se refieren a proveedor, por algún motivo.
-- 3. La id no es UNIQUE.

-- Lo solucionaría añadiendo la tabla proveedores y relacionando esa con Productos en forma ManytoMany.





CREATE TABLE Clientes (
    ID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Email VARCHAR(100),
    Teléfonos VARCHAR(255), -- Almacenando múltiples números de teléfono en una sola columna
    Dirección VARCHAR(255)
);

-- En esta tabla veo varios errores:
-- 1. Se usan tildes (desaconsejado). Las quitaré para no tener problemas en el futuro.
-- 2. El email debería ser not null, puesto que lo podríamos necesitar
-- para comunicarnos con el cliente.
-- 3. Los datos no son atómicos por culpa de "teléfonos".
-- 4. La id no es unique.

-- Solución: crear una tabla teléfonos que se relacione ManyToOne con clientes. 





CREATE TABLE Pedidos (
    ID INT PRIMARY KEY,
    Cliente VARCHAR(100),
    Fecha DATE,
    Productos VARCHAR(255), -- Almacena múltiples productos en una sola columna
    Cantidades VARCHAR(255), -- Almacena cantidades correspondientes en una sola columna
    Total DECIMAL(10, 2),
    Estado VARCHAR(50)
);

-- En esta tabla veo varios errores:
-- 1. ID no es UNIQUE.
-- 2. Los datos no son atómicos por culpa de "productos".
-- 3. Los datos no son atómicos por culpa de "cantidades".

-- Crearía una tabla Detalles_pedido que incluiría las cantidades y un subtotal, 
-- se relacionaría con Pedidos mediante el id_pedido.





-- SOLUCIONES

create table estudiantes (
    id INT primary key unique,
    nombre VARCHAR(100)
);

create table cursos (
    id INT primary key unique,
    nombre VARCHAR(100)
);

create table estudiantes_cursos (
    id_estudiante INT,
    id_curso INT,
    primary key (id_estudiante, id_curso),
    foreign key (id_estudiante) references estudiantes(id),
    foreign key (id_curso) references cursos(id)
);

INSERT INTO estudiantes (id, nombre) VALUES
	(1, 'Juan Pérez'),
	(2, 'Ana Gómez'),
	(3, 'Luis Rodríguez');

INSERT INTO cursos (id, nombre) VALUES
	(1, 'Matemáticas'),
	(2, 'Historia'),
	(3, 'Biología'),
	(4, 'Física'),
	(5, 'Química');

INSERT INTO estudiantes_cursos (id_estudiante, id_curso) VALUES
	(1, 1), 
	(1, 2), 
	(2, 3), 
	(3, 1), 
	(3, 4), 
	(3, 5); 

-- -------------------------------------------------------

create table productos (
    id INT primary key unique,
    nombre VARCHAR(100),
    categoria VARCHAR(100),
    precio DECIMAL(10, 2)
);

create table proveedores (
    id INT primary key unique,
    nombre VARCHAR(100)
);

create table productos_proveedores (
    producto_id INT,
    proveedor_id INT,
    primary key (producto_id, proveedor_id),
    foreign key (producto_id) references productos(id),
    foreign key (proveedor_id) references proveedores(id)
);

-- -------------------------------------------------------

create table clientes (
    id INT primary key unique,
    nombre VARCHAR(100),
    email VARCHAR(100) not null,
    direccion VARCHAR(255)
);

create table telefonos (
    id INT primary key unique,
    id_cliente INT,
    numero VARCHAR(15),
    primary key (id_cliente, numero),
    foreign key (id_cliente) references clientes(id)
);

-- -------------------------------------------------------

create table pedidos (
    id INT primary key unique,
    cliente VARCHAR(100),
    fecha DATE,
    total DECIMAL(10, 2),
    estado VARCHAR(50)
);

create table detalle_pedido (
	id INT primary key unique,
	id_pedido INT,
	producto VARCHAR(100),
	cantidad INT,
	subtotal INT,
	foreign key (id_pedido) references pedidos (id)
);

