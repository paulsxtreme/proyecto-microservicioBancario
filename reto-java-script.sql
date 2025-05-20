-- Script de creación de base de datos para el Sistema Bancario
-- Postgres SQL

-- Crear la base de datos
CREATE DATABASE reto-java;

-- Conectar a la base de datos
\c reto-java

-- Crear tabla de personas
CREATE TABLE personas (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    genero VARCHAR(20),
    edad INTEGER,
    identificacion VARCHAR(13) NOT NULL UNIQUE,
    direccion VARCHAR(200),
    telefono VARCHAR(10),
    version BIGINT DEFAULT 0 NOT NULL
);

-- Crear tabla de clientes
CREATE TABLE clientes (
    clienteid BIGSERIAL PRIMARY KEY,
    personaid BIGINT NOT NULL REFERENCES personas(id) ON DELETE CASCADE,
    contrasena VARCHAR(100) NOT NULL,
    estado BOOLEAN DEFAULT TRUE,
    version BIGINT DEFAULT 0 NOT NULL
);

-- Crear tabla de cuentas
CREATE TABLE cuentas (
    numerocuenta BIGSERIAL PRIMARY KEY,
    clienteid BIGINT NOT NULL REFERENCES clientes(clienteid) ON DELETE CASCADE,
    tipocuenta VARCHAR(50) NOT NULL CHECK (tipocuenta IN ('Ahorros', 'Corriente')),
    saldoinicial NUMERIC(15, 2) NOT NULL DEFAULT 0,
    estado BOOLEAN DEFAULT TRUE,
    version BIGINT DEFAULT 0 NOT NULL
);

-- Crear tabla de movimientos
CREATE TABLE movimientos (
    id BIGSERIAL PRIMARY KEY,
    numerocuenta BIGINT NOT NULL REFERENCES cuentas(numerocuenta) ON DELETE CASCADE,
    fecha TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    tipomovimiento VARCHAR(10) NOT NULL CHECK (tipomovimiento IN ('CREDITO', 'DEBITO')),
    valor NUMERIC(15, 2) NOT NULL,
    saldo NUMERIC(15, 2) NOT NULL,
    version BIGINT DEFAULT 0 NOT NULL
);

-- Crear índices para mejorar el rendimiento
CREATE INDEX idx_personas_identificacion ON personas(identificacion);
CREATE INDEX idx_cuentas_clienteid ON cuentas(clienteid);
CREATE INDEX idx_movimientos_numerocuenta ON movimientos(numerocuenta);
CREATE INDEX idx_movimientos_fecha ON movimientos(fecha);

-- Insertar datos de ejemplo: Personas
INSERT INTO personas (nombre, genero, edad, identificacion, direccion, telefono)
VALUES 
    ('Juan Pérez', 'Masculino', 35, '1712345678', 'Av. Amazonas N36-152', '0987654321'),
    ('María López', 'Femenino', 42, '1798765432', 'Calle La Ronda 234', '0998887777'),
    ('Marianela Montalvo', 'Femenino', 38, '1734567890', 'Av. República E5-123', '0976543210'),
    ('José Lema', 'Masculino', 45, '1765432109', 'Av. América N34-567', '0932165487'),
    ('Carlos Sanchez', 'Masculino', 40, '1712131415', 'Av. Galo Plaza Lasso N22-222', '0987654321'),
    ('Paul Salazar', 'Masculino', 36, '1725544444', 'Av. Naciones unidas N10-100', '0999999999');

-- Insertar datos de ejemplo: Clientes
INSERT INTO clientes (personaid, contrasena, estado)
VALUES 
    (1, 'Juan1234', TRUE),
    (2, 'Maria5678', TRUE),
    (3, 'Marianela123', TRUE),
    (4, 'Jose4567', TRUE),
    (5, 'Mipass123', TRUE),
    (6, 'Paul4567', TRUE);

-- Insertar datos de ejemplo: Cuentas
INSERT INTO cuentas (clienteid, tipocuenta, saldoinicial, estado)
VALUES 
    (1, 'Ahorros', 1000.00, TRUE),
    (2, 'Corriente', 2000.00, TRUE),
    (3, 'Ahorros', 0.00, TRUE),
    (4, 'Corriente', 500.00, TRUE),
    (5, 'Ahorros', 1000.00, TRUE),
    (6, 'Corriente', 1500.00, TRUE);

-- Insertar datos de ejemplo: Movimientos iniciales
INSERT INTO movimientos (numerocuenta, fecha, tipomovimiento, valor, saldo)
VALUES 
    (1, CURRENT_TIMESTAMP - INTERVAL '10 days', 'CREDITO', 1000.00, 1000.00),
    (2, CURRENT_TIMESTAMP - INTERVAL '9 days', 'CREDITO', 2000.00, 2000.00),
    (4, CURRENT_TIMESTAMP - INTERVAL '8 days', 'CREDITO', 500.00, 500.00),
    (5, CURRENT_TIMESTAMP - INTERVAL '7 days', 'CREDITO', 1000.00, 1000.00),
    (6, CURRENT_TIMESTAMP - INTERVAL '6 days', 'CREDITO', 1500.00, 1500.00);

-- Insertar datos de ejemplo: Movimientos adicionales
INSERT INTO movimientos (numerocuenta, fecha, tipomovimiento, valor, saldo)
VALUES 
    -- Cuenta 1: Juan Pérez
    (1, CURRENT_TIMESTAMP - INTERVAL '5 days', 'DEBITO', -200.00, 800.00),
    (1, CURRENT_TIMESTAMP - INTERVAL '3 days', 'CREDITO', 300.00, 1100.00),
    (1, CURRENT_TIMESTAMP - INTERVAL '1 day', 'DEBITO', -100.00, 1000.00),
    
    -- Cuenta 2: María López
    (2, CURRENT_TIMESTAMP - INTERVAL '4 days', 'DEBITO', -500.00, 1500.00),
    (2, CURRENT_TIMESTAMP - INTERVAL '2 days', 'CREDITO', 700.00, 2200.00),
    (2, CURRENT_TIMESTAMP - INTERVAL '1 day', 'DEBITO', -300.00, 1900.00),
    
    -- Cuenta 3: Marianela Montalvo (inicialmente sin saldo)
    (3, CURRENT_TIMESTAMP - INTERVAL '3 days', 'CREDITO', 1000.00, 1000.00),
    (3, CURRENT_TIMESTAMP - INTERVAL '1 day', 'DEBITO', -200.00, 800.00),
    
    -- Cuenta 4: José Lema
    (4, CURRENT_TIMESTAMP - INTERVAL '6 days', 'DEBITO', -100.00, 400.00),
    (4, CURRENT_TIMESTAMP - INTERVAL '2 days', 'CREDITO', 200.00, 600.00),
    
    -- Cuenta 5: Carlos Sanchez
    (5, CURRENT_TIMESTAMP - INTERVAL '5 days', 'DEBITO', -300.00, 700.00),
    (5, CURRENT_TIMESTAMP - INTERVAL '1 day', 'CREDITO', 150.00, 850.00),
    
    -- Cuenta 6: Paul Salazar
    (6, CURRENT_TIMESTAMP - INTERVAL '4 days', 'DEBITO', -250.00, 1250.00),
    (6, CURRENT_TIMESTAMP - INTERVAL '2 days', 'CREDITO', 350.00, 1600.00);

-- Vista para obtener saldos actuales
CREATE VIEW saldos_actuales AS
SELECT 
    c.numerocuenta,
    c.tipocuenta,
    p.nombre as nombre_cliente,
    p.identificacion,
    (SELECT m.saldo FROM movimientos m 
     WHERE m.numerocuenta = c.numerocuenta 
     ORDER BY m.fecha DESC LIMIT 1) as saldo_actual,
    c.estado
FROM cuentas c
JOIN clientes cl ON c.clienteid = cl.clienteid
JOIN personas p ON cl.personaid = p.id;

-- Procedimiento almacenado para realizar un depósito
CREATE OR REPLACE FUNCTION realizar_deposito(
    p_numerocuenta BIGINT,
    p_valor NUMERIC(15, 2)
) RETURNS VOID AS $$
DECLARE
    v_saldo_actual NUMERIC(15, 2);
BEGIN
    -- Verificar que la cuenta existe y está activa
    IF NOT EXISTS (SELECT 1 FROM cuentas WHERE numerocuenta = p_numerocuenta AND estado = TRUE) THEN
        RAISE EXCEPTION 'Cuenta no existe o no está activa';
    END IF;
    
    -- Obtener el saldo actual
    SELECT COALESCE(
        (SELECT saldo FROM movimientos 
         WHERE numerocuenta = p_numerocuenta 
         ORDER BY fecha DESC LIMIT 1),
        (SELECT saldoinicial FROM cuentas WHERE numerocuenta = p_numerocuenta)
    ) INTO v_saldo_actual;
    
    -- Registrar el movimiento
    INSERT INTO movimientos (numerocuenta, tipomovimiento, valor, saldo)
    VALUES (p_numerocuenta, 'CREDITO', ABS(p_valor), v_saldo_actual + ABS(p_valor));
END;
$$ LANGUAGE plpgsql;

-- Procedimiento almacenado para realizar un retiro
CREATE OR REPLACE FUNCTION realizar_retiro(
    p_numerocuenta BIGINT,
    p_valor NUMERIC(15, 2)
) RETURNS VOID AS $$
DECLARE
    v_saldo_actual NUMERIC(15, 2);
BEGIN
    -- Verificar que la cuenta existe y está activa
    IF NOT EXISTS (SELECT 1 FROM cuentas WHERE numerocuenta = p_numerocuenta AND estado = TRUE) THEN
        RAISE EXCEPTION 'Cuenta no existe o no está activa';
    END IF;
    
    -- Obtener el saldo actual
    SELECT COALESCE(
        (SELECT saldo FROM movimientos 
         WHERE numerocuenta = p_numerocuenta 
         ORDER BY fecha DESC LIMIT 1),
        (SELECT saldoinicial FROM cuentas WHERE numerocuenta = p_numerocuenta)
    ) INTO v_saldo_actual;
    
    -- Verificar si hay saldo suficiente
    IF v_saldo_actual < ABS(p_valor) THEN
        RAISE EXCEPTION 'Saldo insuficiente';
    END IF;
    
    -- Registrar el movimiento
    INSERT INTO movimientos (numerocuenta, tipomovimiento, valor, saldo)
    VALUES (p_numerocuenta, 'DEBITO', -ABS(p_valor), v_saldo_actual - ABS(p_valor));
END;
$$ LANGUAGE plpgsql;

-- Función para obtener estado de cuenta
CREATE OR REPLACE FUNCTION estado_cuenta(
    p_clienteid BIGINT,
    p_fecha_inicio DATE,
    p_fecha_fin DATE
) RETURNS TABLE (
    numerocuenta BIGINT,
    tipo_cuenta VARCHAR,
    saldo_inicial NUMERIC,
    estado BOOLEAN,
    movimientos_credito NUMERIC,
    movimientos_debito NUMERIC,
    saldo_disponible NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    WITH movs AS (
        SELECT 
            m.numerocuenta,
            COALESCE(SUM(CASE WHEN m.tipomovimiento = 'CREDITO' THEN m.valor ELSE 0 END), 0) as total_creditos,
            COALESCE(SUM(CASE WHEN m.tipomovimiento = 'DEBITO' THEN m.valor ELSE 0 END), 0) as total_debitos
        FROM movimientos m
        WHERE m.fecha BETWEEN p_fecha_inicio::timestamp AND (p_fecha_fin + INTERVAL '1 day')::timestamp
        GROUP BY m.numerocuenta
    )
    SELECT 
        c.numerocuenta,
        c.tipocuenta,
        c.saldoinicial,
        c.estado,
        COALESCE(m.total_creditos, 0) as movimientos_credito,
        COALESCE(m.total_debitos, 0) as movimientos_debito,
        (SELECT saldo FROM movimientos 
         WHERE numerocuenta = c.numerocuenta 
         ORDER BY fecha DESC LIMIT 1) as saldo_disponible
    FROM cuentas c
    LEFT JOIN movs m ON c.numerocuenta = m.numerocuenta
    WHERE c.clienteid = p_clienteid;
END;
$$ LANGUAGE plpgsql;

-- Otorgar permisos (ajustar según sea necesario)
-- GRANT ALL PRIVILEGES ON DATABASE banco_db TO tu_usuario;
-- GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO tu_usuario;
-- GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO tu_usuario;

-- Mensaje final
SELECT 'Base de datos creada exitosamente.' as mensaje;