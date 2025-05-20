package com.ejercicio.java.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PersonaDTO {

    private Long id;

    @NotBlank(message = "El nombre es obligatorio")
    @Size(min = 2, max = 100, message = "El nombre debe tener entre 2 y 100 caracteres")
    private String nombre;

    private String genero;

    private Integer edad;

    @NotBlank(message = "La identificación es obligatoria")
    @Pattern(regexp = "^[0-9]{10,13}$", message = "La identificación debe tener entre 10 y 13 dígitos")
    private String identificacion;

    private String direccion;

    @Pattern(regexp = "^[0-9]{7,10}$", message = "El teléfono debe tener entre 7 y 10 dígitos")
    private String telefono;

    // Añadir el campo version
    private Long version;

}