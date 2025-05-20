# proyecto-microservicioBancario
proyecto microservicio Bancario con java y maven



1-.Pasos para crear un cliente

{
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
Resultado:
{
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
