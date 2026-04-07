-- Base de datos para TorqueLab Automotive
-- Autor: Antonio, Jose Daniel, Enrique
-- Fecha: 2026-03-24

--------------------------------------------------
-- Tabla: categoria_componente
-- Categorías de componentes
--------------------------------------------------
CREATE TABLE categoria_componente (
    id_categoria SERIAL PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL,
    descripcion TEXT
);


--------------------------------------------------
-- Tabla: cliente
-- Información de clientes
--------------------------------------------------
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    dni VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    telefono_contacto VARCHAR(20),
    pais VARCHAR(100),
    region VARCHAR(100),
    provincia VARCHAR(100),
    ciudad VARCHAR(100),
    direccion VARCHAR(200)
);


--------------------------------------------------
-- Tabla: departamento
-- Departamentos de la empresa
--------------------------------------------------
CREATE TABLE departamento (
    id_departamento SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);


--------------------------------------------------
-- Tabla: proveedor
-- Proveedores de componentes
--------------------------------------------------
CREATE TABLE proveedor (
    id_proveedor SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    cif VARCHAR(20) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(150),
    pais VARCHAR(100),
    region VARCHAR(100),
    provincia VARCHAR(100),
    ciudad VARCHAR(100),
    direccion VARCHAR(200)
);


--------------------------------------------------
-- Tabla: empleado
-- Información de empleados
--------------------------------------------------
CREATE TABLE empleado (
    id_empleado SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(150) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(150),
    puesto VARCHAR(100),
    salario DECIMAL(10,2),
    direccion VARCHAR(200),
    fecha_contratacion DATE,
    id_departamento INT,

    CONSTRAINT fk_empleado_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES departamento(id_departamento)
);


--------------------------------------------------
-- Tabla: vehiculo
-- Vehículos asociados a clientes
--------------------------------------------------
CREATE TABLE vehiculo (
    id_vehiculo SERIAL PRIMARY KEY,
    matricula VARCHAR(20) UNIQUE NOT NULL,
    marca VARCHAR(100) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    anio INT,
    num_bastidor VARCHAR(50) UNIQUE,
    id_cliente INT NOT NULL,

    CONSTRAINT fk_vehiculo_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
);


--------------------------------------------------
-- Tabla: componente
-- Componentes o productos del sistema
--------------------------------------------------
CREATE TABLE componente (
    id_componente SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio_venta DECIMAL(10,2) NOT NULL,
    precio_compra DECIMAL(10,2),
    stock INT DEFAULT 0,
    stock_minimo INT DEFAULT 0,
    tipo_producto VARCHAR(50),
    marca VARCHAR(100),
    modelos_compatibles TEXT,
    id_proveedor INT,
    id_categoria INT,

    CONSTRAINT fk_componente_proveedor
        FOREIGN KEY (id_proveedor)
        REFERENCES proveedor(id_proveedor),

    CONSTRAINT fk_componente_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categoria_componente(id_categoria)
);


--------------------------------------------------
-- Tabla: servicio
-- Servicios realizados a vehículos
--------------------------------------------------
CREATE TABLE servicio (
    id_servicio SERIAL PRIMARY KEY,
    fecha_apertura DATE NOT NULL,
    fecha_cierre DATE,
    tipo VARCHAR(100),
    descripcion TEXT,
    estado VARCHAR(50),
    kilometraje INT,
    coste DECIMAL(10,2),
    id_vehiculo INT NOT NULL,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,

    CONSTRAINT fk_servicio_vehiculo
        FOREIGN KEY (id_vehiculo)
        REFERENCES vehiculo(id_vehiculo),

    CONSTRAINT fk_servicio_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente),

    CONSTRAINT fk_servicio_empleado
        FOREIGN KEY (id_empleado)
        REFERENCES empleado(id_empleado)
);


--------------------------------------------------
-- Tabla: servicio_componente
-- Relación entre servicios y componentes utilizados
--------------------------------------------------
CREATE TABLE servicio_componente (
    id_servicio_componente SERIAL PRIMARY KEY,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    id_servicio INT NOT NULL,
    id_componente INT NOT NULL,

    CONSTRAINT fk_sc_servicio
        FOREIGN KEY (id_servicio)
        REFERENCES servicio(id_servicio),

    CONSTRAINT fk_sc_componente
        FOREIGN KEY (id_componente)
        REFERENCES componente(id_componente)
);


--------------------------------------------------
-- Tabla: pedido
-- Pedidos realizados por clientes
--------------------------------------------------
CREATE TABLE pedido (
    id_pedido SERIAL PRIMARY KEY,
    fecha_pedido DATE NOT NULL,
    estado VARCHAR(50),
    total DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(50),
    direccion_envio VARCHAR(200),
    id_cliente INT NOT NULL,

    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
);


--------------------------------------------------
-- Tabla: detalle_pedido
-- Detalle de productos dentro de un pedido
--------------------------------------------------
CREATE TABLE detalle_pedido (
    id_detalle SERIAL PRIMARY KEY,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    id_pedido INT NOT NULL,
    id_componente INT NOT NULL,

    CONSTRAINT fk_dp_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES pedido(id_pedido),

    CONSTRAINT fk_dp_componente
        FOREIGN KEY (id_componente)
        REFERENCES componente(id_componente)
);


--------------------------------------------------
-- Tabla: orden_compra
-- Pedidos a proveedores
--------------------------------------------------
CREATE TABLE orden_compra (
    id_orden_compra SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    estado VARCHAR(50),
    total DECIMAL(10,2) NOT NULL,
    id_proveedor INT NOT NULL,

    CONSTRAINT fk_oc_proveedor
        FOREIGN KEY (id_proveedor)
        REFERENCES proveedor(id_proveedor)
);


--------------------------------------------------
-- Tabla: detalle_orden_compra
-- Detalle de cada orden de compra
--------------------------------------------------
CREATE TABLE detalle_orden_compra (
    id_detalle_compra SERIAL PRIMARY KEY,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    id_orden_compra INT NOT NULL,
    id_componente INT NOT NULL,

    CONSTRAINT fk_doc_orden
        FOREIGN KEY (id_orden_compra)
        REFERENCES orden_compra(id_orden_compra),

    CONSTRAINT fk_doc_componente
        FOREIGN KEY (id_componente)
        REFERENCES componente(id_componente)
);


--------------------------------------------------
-- Tabla: contrato
-- Contratos de empleados
--------------------------------------------------
CREATE TABLE contrato (
    id_contrato SERIAL PRIMARY KEY,
    tipo_contrato VARCHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    jornada VARCHAR(50),
    salario_base DECIMAL(10,2) NOT NULL,
    id_empleado INT NOT NULL,

    CONSTRAINT fk_contrato_empleado
        FOREIGN KEY (id_empleado)
        REFERENCES empleado(id_empleado)
);


--------------------------------------------------
-- Tabla: nomina
-- Nóminas de empleados
--------------------------------------------------
CREATE TABLE nomina (
    id_nomina SERIAL PRIMARY KEY,
    mes INT NOT NULL,
    anio INT NOT NULL,
    salario_base DECIMAL(10,2) NOT NULL,
    complementos DECIMAL(10,2) DEFAULT 0,
    deducciones DECIMAL(10,2) DEFAULT 0,
    salario_neto DECIMAL(10,2) NOT NULL,
    id_empleado INT NOT NULL,

    CONSTRAINT fk_nomina_empleado
        FOREIGN KEY (id_empleado)
        REFERENCES empleado(id_empleado)
);


--------------------------------------------------
-- Tabla: cita
-- Citas de clientes
--------------------------------------------------
CREATE TABLE cita (
    id_cita SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    motivo TEXT,
    estado VARCHAR(50),
    id_vehiculo INT NOT NULL,
    id_cliente INT NOT NULL,

    CONSTRAINT fk_cita_vehiculo
        FOREIGN KEY (id_vehiculo)
        REFERENCES vehiculo(id_vehiculo),

    CONSTRAINT fk_cita_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
);



------------------------------------------------------------------------
-- 
--                       INSERTAR DATOS
--
------------------------------------------------------------------------

--------------------------------------------------
-- Datos de prueba: categoria_componente
--------------------------------------------------
INSERT INTO categoria_componente (nombre_categoria, descripcion) VALUES
('Motor', 'Componentes relacionados con el motor y su funcionamiento'),
('Frenos', 'Piezas del sistema de frenado del vehículo'),
('Suspensión', 'Elementos de amortiguación y estabilidad'),
('Electricidad', 'Componentes eléctricos y electrónicos'),
('Escape', 'Piezas del sistema de escape y emisiones');

--------------------------------------------------
-- Datos de prueba: cliente
--------------------------------------------------
INSERT INTO cliente (dni, nombre, apellidos, email, telefono_contacto, pais, region, provincia, ciudad, direccion) VALUES
('12345678A', 'Juan', 'Pérez García', 'juan.perez@email.com', '611111111', 'España', 'Andalucía', 'Sevilla', 'Sevilla', 'Calle Feria 12'),
('23456789B', 'Ana', 'López Martín', 'ana.lopez@email.com', '622222222', 'España', 'Madrid', 'Madrid', 'Madrid', 'Avenida de América 45'),
('34567890C', 'Carlos', 'Ruiz Sánchez', 'carlos.ruiz@email.com', '633333333', 'España', 'Cataluña', 'Barcelona', 'Barcelona', 'Carrer de Mallorca 88'),
('45678901D', 'Lucía', 'Fernández Díaz', 'lucia.fernandez@email.com', '644444444', 'España', 'Comunidad Valenciana', 'Valencia', 'Valencia', 'Gran Vía 23'),
('56789012E', 'Pedro', 'Gómez Torres', 'pedro.gomez@email.com', '655555555', 'España', 'Andalucía', 'Málaga', 'Málaga', 'Paseo del Parque 7');

--------------------------------------------------
-- Datos de prueba: departamento
--------------------------------------------------
INSERT INTO departamento (nombre, descripcion) VALUES
('Mecánica', 'Departamento encargado de reparaciones mecánicas'),
('Administración', 'Gestión administrativa y documentación'),
('Ventas', 'Atención comercial y ventas de productos'),
('Recambios', 'Control de stock y gestión de componentes'),
('Atención al Cliente', 'Gestión de citas y soporte al cliente');

--------------------------------------------------
-- Datos de prueba: proveedor
--------------------------------------------------
INSERT INTO proveedor (nombre, cif, telefono, email, pais, region, provincia, ciudad, direccion) VALUES
('AutoParts Sevilla S.L.', 'B12345671', '954111111', 'contacto@autopartssevilla.com', 'España', 'Andalucía', 'Sevilla', 'Sevilla', 'Polígono Store, Nave 4'),
('Recambios Madrid S.A.', 'B12345672', '915222222', 'ventas@recambiosmadrid.com', 'España', 'Madrid', 'Madrid', 'Madrid', 'Calle Industria 19'),
('MotorTech Barcelona', 'B12345673', '934333333', 'info@motortechbcn.com', 'España', 'Cataluña', 'Barcelona', 'Barcelona', 'Avinguda Diagonal 120'),
('Frenos Levante S.L.', 'B12345674', '963444444', 'pedidos@frenoslevante.com', 'España', 'Comunidad Valenciana', 'Valencia', 'Valencia', 'Calle del Puerto 30'),
('EscapeSur Components', 'B12345675', '952555555', 'admin@escapesur.com', 'España', 'Andalucía', 'Málaga', 'Málaga', 'Camino de San Rafael 55');

--------------------------------------------------
-- Datos de prueba: empleado
--------------------------------------------------
INSERT INTO empleado (nombre, apellidos, dni, telefono, email, puesto, salario, direccion, fecha_contratacion, id_departamento) VALUES
('Antonio', 'Martín López', '11223344A', '666111111', 'antonio.martin@torquelab.com', 'Mecánico', 1850.00, 'Calle Sol 10, Sevilla', '2023-01-10', 1),
('María', 'Navarro Ruiz', '22334455B', '666222222', 'maria.navarro@torquelab.com', 'Administrativa', 1650.00, 'Avenida Constitución 18, Sevilla', '2022-09-15', 2),
('Javier', 'Santos Gómez', '33445566C', '666333333', 'javier.santos@torquelab.com', 'Asesor Comercial', 1700.00, 'Calle Real 22, Dos Hermanas', '2024-02-01', 3),
('Elena', 'Castillo Pérez', '44556677D', '666444444', 'elena.castillo@torquelab.com', 'Responsable de Recambios', 1750.00, 'Calle Luna 5, Sevilla', '2021-06-20', 4),
('David', 'Ortega Jiménez', '55667788E', '666555555', 'david.ortega@torquelab.com', 'Recepcionista', 1600.00, 'Calle Norte 14, Sevilla', '2024-05-12', 5);

--------------------------------------------------
-- Datos de prueba: vehiculo
--------------------------------------------------
INSERT INTO vehiculo (matricula, marca, modelo, anio, num_bastidor, id_cliente) VALUES
('1234ABC', 'Toyota', 'Corolla', 2018, 'JTDBR32E720123456', 1),
('2345BCD', 'Ford', 'Focus', 2020, 'WF0NXXGCDNLA65432', 2),
('3456CDE', 'BMW', '320d', 2019, 'WBA8C11050A987654', 3),
('4567DEF', 'Audi', 'A3', 2021, 'WAUZZZ8V6MA123789', 4),
('5678EFG', 'Seat', 'León', 2017, 'VSSZZZ5FZHR456123', 5);

--------------------------------------------------
-- Datos de prueba: componente
--------------------------------------------------
INSERT INTO componente (nombre, descripcion, precio_venta, precio_compra, stock, stock_minimo, tipo_producto, marca, modelos_compatibles, id_proveedor, id_categoria) VALUES
('Filtro de aceite', 'Filtro de aceite para motores gasolina y diésel', 18.50, 9.20, 40, 10, 'Recambio', 'Bosch', 'Toyota Corolla, Ford Focus', 1, 1),
('Pastillas de freno delanteras', 'Juego de pastillas de freno delanteras', 65.00, 34.00, 25, 5, 'Recambio', 'Brembo', 'BMW 320d, Audi A3', 4, 2),
('Amortiguador trasero', 'Amortiguador para eje trasero', 89.90, 50.00, 18, 4, 'Recambio', 'Monroe', 'Seat León, Ford Focus', 2, 3),
('Batería 12V 70Ah', 'Batería de arranque 12V 70Ah', 120.00, 78.50, 12, 3, 'Recambio', 'Varta', 'Toyota Corolla, Audi A3, Seat León', 3, 4),
('Silencioso trasero', 'Silencioso del sistema de escape', 145.00, 92.00, 8, 2, 'Recambio', 'Walker', 'Ford Focus, BMW 320d', 5, 5);

--------------------------------------------------
-- Datos de prueba: servicio
--------------------------------------------------
INSERT INTO servicio (fecha_apertura, fecha_cierre, tipo, descripcion, estado, kilometraje, coste, id_vehiculo, id_cliente, id_empleado) VALUES
('2026-03-01', '2026-03-02', 'Mantenimiento', 'Cambio de aceite y revisión general', 'Finalizado', 118500, 95.00, 1, 1, 1),
('2026-03-03', '2026-03-04', 'Reparación', 'Sustitución de pastillas de freno delanteras', 'Finalizado', 84200, 140.00, 2, 2, 1),
('2026-03-05', NULL, 'Diagnóstico', 'Revisión de ruido en suspensión trasera', 'En proceso', 91300, 60.00, 3, 3, 1),
('2026-03-06', '2026-03-06', 'Electricidad', 'Cambio de batería', 'Finalizado', 45200, 135.00, 4, 4, 1),
('2026-03-07', NULL, 'Reparación', 'Inspección del sistema de escape', 'Pendiente', 132400, 80.00, 5, 5, 1);

--------------------------------------------------
-- Datos de prueba: servicio_componente
--------------------------------------------------
INSERT INTO servicio_componente (cantidad, precio_unitario, id_servicio, id_componente) VALUES
(1, 18.50, 1, 1),
(1, 65.00, 2, 2),
(2, 89.90, 3, 3),
(1, 120.00, 4, 4),
(1, 145.00, 5, 5);

--------------------------------------------------
-- Datos de prueba: pedido
--------------------------------------------------
INSERT INTO pedido (fecha_pedido, estado, total, metodo_pago, direccion_envio, id_cliente) VALUES
('2026-03-10', 'Enviado', 18.50, 'Tarjeta', 'Calle Feria 12, Sevilla', 1),
('2026-03-11', 'Preparando', 65.00, 'PayPal', 'Avenida de América 45, Madrid', 2),
('2026-03-12', 'Entregado', 179.80, 'Tarjeta', 'Carrer de Mallorca 88, Barcelona', 3),
('2026-03-13', 'Enviado', 120.00, 'Transferencia', 'Gran Vía 23, Valencia', 4),
('2026-03-14', 'Pendiente', 145.00, 'Tarjeta', 'Paseo del Parque 7, Málaga', 5);

--------------------------------------------------
-- Datos de prueba: detalle_pedido
--------------------------------------------------
INSERT INTO detalle_pedido (cantidad, precio_unitario, subtotal, id_pedido, id_componente) VALUES
(1, 18.50, 18.50, 1, 1),
(1, 65.00, 65.00, 2, 2),
(2, 89.90, 179.80, 3, 3),
(1, 120.00, 120.00, 4, 4),
(1, 145.00, 145.00, 5, 5);

--------------------------------------------------
-- Datos de prueba: orden_compra
-- Pedidos realizados a proveedores
--------------------------------------------------
INSERT INTO orden_compra (fecha, estado, total, id_proveedor) VALUES
('2026-02-20', 'Recibido', 368.00, 1),
('2026-02-22', 'Pendiente', 340.00, 2),
('2026-02-24', 'Recibido', 392.50, 3),
('2026-02-26', 'En tránsito', 408.00, 4),
('2026-02-28', 'Pendiente', 460.00, 5);

--------------------------------------------------
-- Datos de prueba: detalle_orden_compra
--------------------------------------------------
INSERT INTO detalle_orden_compra (cantidad, precio_unitario, subtotal, id_orden_compra, id_componente) VALUES
(40, 9.20, 368.00, 1, 1),
(10, 34.00, 340.00, 2, 2),
(5, 78.50, 392.50, 3, 4),
(12, 34.00, 408.00, 4, 2),
(5, 92.00, 460.00, 5, 5);

--------------------------------------------------
-- Datos de prueba: contrato
--------------------------------------------------
INSERT INTO contrato (tipo_contrato, fecha_inicio, fecha_fin, jornada, salario_base, id_empleado) VALUES
('Indefinido', '2023-01-10', NULL, 'Completa', 1700.00, 1),
('Indefinido', '2022-09-15', NULL, 'Completa', 1550.00, 2),
('Temporal', '2024-02-01', '2026-08-01', 'Completa', 1600.00, 3),
('Indefinido', '2021-06-20', NULL, 'Completa', 1650.00, 4),
('Temporal', '2024-05-12', '2026-05-12', 'Parcial', 1200.00, 5);

--------------------------------------------------
-- Datos de prueba: nomina
--------------------------------------------------
INSERT INTO nomina (mes, anio, salario_base, complementos, deducciones, salario_neto, id_empleado) VALUES
(3, 2026, 1700.00, 150.00, 120.00, 1730.00, 1),
(3, 2026, 1550.00, 100.00, 95.00, 1555.00, 2),
(3, 2026, 1600.00, 130.00, 110.00, 1620.00, 3),
(3, 2026, 1650.00, 140.00, 115.00, 1675.00, 4),
(3, 2026, 1200.00, 80.00, 60.00, 1220.00, 5);

--------------------------------------------------
-- Datos de prueba: cita
--------------------------------------------------
INSERT INTO cita (fecha, hora, motivo, estado, id_vehiculo, id_cliente) VALUES
('2026-04-10', '09:00:00', 'Cambio de aceite y filtros', 'Confirmada', 1, 1),
('2026-04-11', '10:30:00', 'Revisión de frenos', 'Pendiente', 2, 2),
('2026-04-12', '12:00:00', 'Diagnóstico de suspensión', 'Confirmada', 3, 3),
('2026-04-13', '16:00:00', 'Sustitución de batería', 'Completada', 4, 4),
('2026-04-14', '11:15:00', 'Revisión del escape', 'Cancelada', 5, 5);