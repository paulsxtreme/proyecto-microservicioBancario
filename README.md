<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proyecto Microservicio Bancario</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            line-height: 1.6;
            color: #24292e;
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }
        h1 {
            border-bottom: 1px solid #eaecef;
            padding-bottom: 0.3em;
        }
        h2 {
            border-bottom: 1px solid #eaecef;
            padding-bottom: 0.3em;
            margin-top: 24px;
        }
        h3 {
            margin-top: 24px;
        }
        code {
            font-family: SFMono-Regular, Consolas, "Liberation Mono", Menlo, monospace;
            background-color: rgba(27, 31, 35, 0.05);
            padding: 0.2em 0.4em;
            border-radius: 3px;
        }
        pre {
            background-color: #f6f8fa;
            border-radius: 6px;
            padding: 16px;
            overflow: auto;
        }
        pre code {
            background-color: transparent;
            padding: 0;
        }
        .json {
            color: #032f62;
        }
        .endpoint {
            color: #6f42c1;
            font-weight: bold;
        }
        .section {
            margin-bottom: 40px;
        }
        .emoji {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <h1><span class="emoji">🏦</span>Proyecto Microservicio Bancario</h1>
    <p>Proyecto microservicio Bancario desarrollado con Java y Maven que permite realizar operaciones bancarias como crear, editar y eliminar clientes, así como generar movimientos para acreditar y debitar el estado de cuenta.</p>

    <div class="section">
        <h2><span class="emoji">📋</span>Contenido</h2>
        <ul>
            <li><a href="#clientes">Operaciones de Clientes</a>
                <ul>
                    <li><a href="#crear-cliente">Crear Cliente</a></li>
                    <li><a href="#editar-cliente">Editar Cliente</a></li>
                    <li><a href="#eliminar-cliente">Eliminar Cliente</a></li>
                </ul>
            </li>
            <li><a href="#cuentas">Operaciones de Cuentas</a>
                <ul>
                    <li><a href="#crear-cuenta">Crear Cuenta</a></li>
                    <li><a href="#editar-cuenta">Editar Cuenta</a></li>
                </ul>
            </li>
            <li><a href="#movimientos">Operaciones de Movimientos</a>
                <ul>
                    <li><a href="#deposito">Realizar Depósito</a></li>
                    <li><a href="#retiro">Realizar Retiro</a></li>
                    <li><a href="#consultar">Consultar Movimientos</a></li>
                </ul>
            </li>
        </ul>
    </div>

    <div class="section">
        <h2><span class="emoji">🔧</span>Tecnologías</h2>
        <ul>
            <li>Java</li>
            <li>Spring Boot</li>
            <li>Maven</li>
            <li>PostgreSQL</li>
            <li>JPA/Hibernate</li>
        </ul>
    </div>

    <div class="section" id="clientes">
        <h2><span class="emoji">🚀</span>Operaciones de Clientes</h2>

        <div id="crear-cliente">
            <h3>1. Crear Cliente</h3>
            <p><strong>Endpoint:</strong> <code class="endpoint">POST http://localhost:8080/clientes</code></p>
            <p><strong>Request Body:</strong></p>
            <pre><code class="json">{
  "persona": {
    "nombre": "Carlos Sanchez",
    "genero": "Masculino",
    "edad": 40,
    "identificacion": "1712131415",
    "direccion": "Av. Galo Plaza Lasso N22-222",
    "telefono": "0987654321"
  },
  "contrasena": "Mipass123",
  "estado": true
}</code></pre>
            <p><strong>Response (200 OK):</strong></p>
            <pre><code class="json">{
  "clienteid": 10,
  "persona": {
    "id": 10,
    "nombre": "Carlos Sanchez",
    "genero": "Masculino",
    "edad": 40,
    "identificacion": "1712131415",
    "direccion": "Av. Galo Plaza Lasso N22-222",
    "telefono": "0987654321",
    "version": 0
  },
  "contrasena": "Mipass123",
  "estado": true,
  "version": null
}</code></pre>
        </div>

        <div id="editar-cliente">
            <h3>2. Editar Cliente</h3>
            <p><strong>Endpoint:</strong> <code class="endpoint">PUT http://localhost:8080/clientes/{id}</code></p>
            <p><strong>Ejemplo:</strong> <code>PUT http://localhost:8080/clientes/9</code></p>
            <p><strong>Request Body:</strong></p>
            <pre><code class="json">{
  "persona": {
    "nombre": "Paul Salazar",
    "genero": "Masculino",
    "edad": 36,
    "identificacion": "1725544444",
    "direccion": "Av. Naciones unidas N10-100",
    "telefono": "0999999999"
  },
  "contrasena": "Paul4567",
  "estado": true
}</code></pre>
            <p><strong>Response (200 OK):</strong></p>
            <pre><code class="json">{
  "clienteid": 9,
  "persona": {
    "id": 9,
    "nombre": "Paul Salazar",
    "genero": "Masculino",
    "edad": 36,
    "identificacion": "1725544444",
    "direccion": "Av. Naciones unidas N10-100",
    "telefono": "0999999999",
    "version": 0
  },
  "contrasena": "Paul4567",
  "estado": true,
  "version": null
}</code></pre>
        </div>

        <div id="eliminar-cliente">
            <h3>3. Eliminar Cliente</h3>
            <p><strong>Endpoint:</strong> <code class="endpoint">DELETE http://localhost:8080/clientes/{id}</code></p>
            <p><strong>Ejemplo:</strong> <code>DELETE http://localhost:8080/clientes/8</code></p>
            <p><strong>Response (204 No Content)</strong></p>
        </div>
    </div>

    <div class="section" id="cuentas">
        <h2><span class="emoji">📊</span>Operaciones de Cuentas</h2>

        <div id="crear-cuenta">
            <h3>4. Crear Cuenta</h3>
            <p><strong>Endpoint:</strong> <code class="endpoint">POST http://localhost:8080/cuentas</code></p>
            <p><strong>Request Body:</strong></p>
            <pre><code class="json">{
  "clienteid": 10,
  "tipocuenta": "Ahorros",
  "saldoinicial": 1000.00,
  "estado": true
}</code></pre>
            <p><strong>Response (201 Created):</strong></p>
            <pre><code class="json">{
  "numerocuenta": 5,
  "clienteid": 10,
  "nombreCliente": "Carlos Sanchez",
  "tipocuenta": "Ahorros",
  "saldoinicial": 1000.00,
  "estado": true
}</code></pre>
        </div>

        <div id="editar-cuenta">
            <h3>5. Editar Cuenta</h3>
            <p><strong>Endpoint:</strong> <code class="endpoint">PUT http://localhost:8080/cuentas/{numerocuenta}</code></p>
            <p><strong>Ejemplo:</strong> <code>PUT http://localhost:8080/cuentas/5</code></p>
            <p><strong>Request Body:</strong></p>
            <pre><code class="json">{
  "clienteid": 10,
  "tipocuenta": "Corriente",
  "saldoinicial": 1000.00,
  "estado": true
}</code></pre>
            <p><strong>Response (200 OK):</strong></p>
            <pre><code class="json">{
  "numerocuenta": 5,
  "clienteid": 10,
  "nombreCliente": "Carlos Sanchez",
  "tipocuenta": "Corriente",
  "saldoinicial": 1000.00,
  "estado": true
}</code></pre>
        </div>
    </div>

    <div class="section" id="movimientos">
        <h2><span class="emoji">💰</span>Operaciones de Movimientos</h2>

        <div id="deposito">
            <h3>6. Realizar Depósito</h3>
            <p><strong>Endpoint:</strong> <code class="endpoint">POST http://localhost:8080/movimientos</code></p>
            <p><strong>Request Body:</strong></p>
            <pre><code class="json">{
  "numerocuenta": 4,
  "tipomovimiento": "CREDITO",
  "valor": 500.00
}</code></pre>
            <p><strong>Response (201 Created):</strong></p>
            <pre><code class="json">{
  "id": 6,
  "numerocuenta": 4,
  "fecha": "2025-05-20T15:30:45-05:00",
  "tipomovimiento": "CREDITO",
  "valor": 500.00,
  "saldo": 5500.00,
  "nombreCliente": "Marianela Montalvo",
  "tipoCuenta": "Ahorros"
}</code></pre>
        </div>

        <div id="retiro">
            <h3>7. Realizar Retiro</h3>
            <p><strong>Endpoint:</strong> <code class="endpoint">POST http://localhost:8080/movimientos</code></p>
            <p><strong>Request Body:</strong></p>
            <pre><code class="json">{
  "numerocuenta": 4,
  "tipomovimiento": "DEBITO",
  "valor": 300.00
}</code></pre>
            <p><strong>Response (201 Created):</strong></p>
            <pre><code class="json">{
  "id": 7,
  "numerocuenta": 4,
  "fecha": "2025-05-20T15:35:20-05:00",
  "tipomovimiento": "DEBITO",
  "valor": -300.00,
  "saldo": 5200.00,
  "nombreCliente": "Marianela Montalvo",
  "tipoCuenta": "Ahorros"
}</code></pre>
        </div>

        <div id="consultar">
            <h3>8. Consultar Movimientos</h3>
            <p><strong>Endpoint:</strong> <code class="endpoint">GET http://localhost:8080/movimientos/cuenta/{numerocuenta}</code></p>
            <p><strong>Ejemplo:</strong> <code>GET http://localhost:8080/movimientos/cuenta/4</code></p>
            <p><strong>Response (200 OK):</strong></p>
            <pre><code class="json">[
  {
    "id": 5,
    "numerocuenta": 4,
    "fecha": "2025-05-01T10:15:00-05:00",
    "tipomovimiento": "CREDITO",
    "valor": 5000.00,
    "saldo": 5000.00,
    "nombreCliente": "Marianela Montalvo",
    "tipoCuenta": "Ahorros"
  },
  {
    "id": 6,
    "numerocuenta": 4,
    "fecha": "2025-05-20T15:30:45-05:00",
    "tipomovimiento": "CREDITO",
    "valor": 500.00,
    "saldo": 5500.00,
    "nombreCliente": "Marianela Montalvo",
    "tipoCuenta": "Ahorros"
  },
  {
    "id": 7,
    "numerocuenta": 4,
    "fecha": "2025-05-20T15:35:20-05:00",
    "tipomovimiento": "DEBITO",
    "valor": -300.00,
    "saldo": 5200.00,
    "nombreCliente": "Marianela Montalvo",
    "tipoCuenta": "Ahorros"
  }
]</code></pre>
        </div>
    </div>

    <div class="section">
        <h2><span class="emoji">⚙️</span>Instalación y Configuración</h2>
        <ol>
            <li>
                <p>Clonar el repositorio:</p>
                <pre><code>git clone https://github.com/tu-usuario/proyecto-microservicioBancario.git
cd proyecto-microservicioBancario</code></pre>
            </li>
            <li>
                <p>Compilar el proyecto:</p>
                <pre><code>mvn clean install</code></pre>
            </li>
            <li>
                <p>Ejecutar la aplicación:</p>
                <pre><code>mvn spring-boot:run</code></pre>
            </li>
            <li>
                <p>La API estará disponible en: <a href="http://localhost:8080/">http://localhost:8080/</a></p>
            </li>
        </ol>
    </div>

    <div class="section">
        <h2><span class="emoji">🧪</span>Tests</h2>
        <p>Para ejecutar las pruebas:</p>
        <pre><code>mvn test</code></pre>
    </div>

    <div class="section">
        <h2><span class="emoji">📄</span>Licencia</h2>
        <p>Este proyecto está bajo la Licencia MIT.</p>
    </div>

    <div class="section">
        <h2><span class="emoji">👨‍💻</span>Autor</h2>
        <p>Desarrollado por [Tu Nombre]</p>
    </div>
</body>
</html>
