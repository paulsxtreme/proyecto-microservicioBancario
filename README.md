🏦 Proyecto Microservicio Bancario
Proyecto microservicio Bancario desarrollado con Java y Maven que permite realizar operaciones bancarias como crear, editar y eliminar clientes, así como generar movimientos para acreditar y debitar el estado de cuenta.
📋 Contenido

Operaciones de Clientes

Crear Cliente
Editar Cliente
Eliminar Cliente


Operaciones de Cuentas

Crear Cuenta
Editar Cuenta


Operaciones de Movimientos

Realizar Depósito
Realizar Retiro
Consultar Movimientos



🔧 Tecnologías

Java
Spring Boot
Maven
PostgreSQL
JPA/Hibernate

🚀 Operaciones de Clientes
1. Crear Cliente
Endpoint: POST http://localhost:8080/clientes
Request Body:
json{
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
}
Response (200 OK):
json{
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
}
2. Editar Cliente
Endpoint: PUT http://localhost:8080/clientes/{id}
Ejemplo: PUT http://localhost:8080/clientes/9
Request Body:
json{
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
}
Response (200 OK):
json{
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
}
3. Eliminar Cliente
Endpoint: DELETE http://localhost:8080/clientes/{id}
Ejemplo: DELETE http://localhost:8080/clientes/8
Response (204 No Content)
📊 Operaciones de Cuentas
4. Crear Cuenta
Endpoint: POST http://localhost:8080/cuentas
Request Body:
json{
  "clienteid": 10,
  "tipocuenta": "Ahorros",
  "saldoinicial": 1000.00,
  "estado": true
}
Response (201 Created):
json{
  "numerocuenta": 5,
  "clienteid": 10,
  "nombreCliente": "Carlos Sanchez",
  "tipocuenta": "Ahorros",
  "saldoinicial": 1000.00,
  "estado": true
}
5. Editar Cuenta
Endpoint: PUT http://localhost:8080/cuentas/{numerocuenta}
Ejemplo: PUT http://localhost:8080/cuentas/5
Request Body:
json{
  "clienteid": 10,
  "tipocuenta": "Corriente",
  "saldoinicial": 1000.00,
  "estado": true
}
Response (200 OK):
json{
  "numerocuenta": 5,
  "clienteid": 10,
  "nombreCliente": "Carlos Sanchez",
  "tipocuenta": "Corriente",
  "saldoinicial": 1000.00,
  "estado": true
}
💰 Operaciones de Movimientos
6. Realizar Depósito
Endpoint: POST http://localhost:8080/movimientos
Request Body:
json{
  "numerocuenta": 4,
  "tipomovimiento": "CREDITO",
  "valor": 500.00
}
Response (201 Created):
json{
  "id": 6,
  "numerocuenta": 4,
  "fecha": "2025-05-20T15:30:45-05:00",
  "tipomovimiento": "CREDITO",
  "valor": 500.00,
  "saldo": 5500.00,
  "nombreCliente": "Marianela Montalvo",
  "tipoCuenta": "Ahorros"
}
7. Realizar Retiro
Endpoint: POST http://localhost:8080/movimientos
Request Body:
json{
  "numerocuenta": 4,
  "tipomovimiento": "DEBITO",
  "valor": 300.00
}
Response (201 Created):
json{
  "id": 7,
  "numerocuenta": 4,
  "fecha": "2025-05-20T15:35:20-05:00",
  "tipomovimiento": "DEBITO",
  "valor": -300.00,
  "saldo": 5200.00,
  "nombreCliente": "Marianela Montalvo",
  "tipoCuenta": "Ahorros"
}
8. Consultar Movimientos
Endpoint: GET http://localhost:8080/movimientos/cuenta/{numerocuenta}
Ejemplo: GET http://localhost:8080/movimientos/cuenta/4
Response (200 OK):
json[
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
]
⚙️ Instalación y Configuración

Clonar el repositorio:
bashgit clone https://github.com/tu-usuario/proyecto-microservicioBancario.git
cd proyecto-microservicioBancario

Compilar el proyecto:
bashmvn clean install

Ejecutar la aplicación:
bashmvn spring-boot:run

La API estará disponible en: http://localhost:8080/

🧪 Tests
Para ejecutar las pruebas:
bashmvn test
📄 Licencia
Este proyecto está bajo la Licencia MIT.
👨‍💻 Autor
Desarrollado por [Tu Nombre]
