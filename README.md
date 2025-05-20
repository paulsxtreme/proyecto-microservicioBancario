# proyecto-microservicioBancario
proyecto microservicio Bancario con java y maven



1-.Pasos para crear un cliente





2-.Pasos para editar un cliente

http://localhost:8080/clientes/9 método "PUT"

{
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
Resultado:
{
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
