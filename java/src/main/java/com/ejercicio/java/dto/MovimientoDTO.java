package com.ejercicio.java.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.ZonedDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MovimientoDTO {

    private Long id;

    @NotNull(message = "El número de cuenta es obligatorio")
    private Long numerocuenta;

    private ZonedDateTime fecha;

    @NotBlank(message = "El tipo de movimiento es obligatorio")
    @Pattern(regexp = "^(DEBITO|CREDITO)$", message = "El tipo de movimiento debe ser DEBITO o CREDITO")
    private String tipomovimiento;

    @NotNull(message = "El valor es obligatorio")
    private BigDecimal valor;

    private BigDecimal saldo;

    // Campos adicionales para mostrar en respuestas
    private String nombreCliente;
    private String tipoCuenta;
    private Long version; // Añadir este campo
}