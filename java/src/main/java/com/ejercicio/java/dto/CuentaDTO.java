package com.ejercicio.java.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CuentaDTO {

    private Long numerocuenta;

    @NotNull(message = "El ID del cliente es obligatorio")
    private Long clienteid;

    @NotBlank(message = "El tipo de cuenta es obligatorio")
    @Pattern(regexp = "^(AHORRO|CORRIENTE)$", message = "El tipo de cuenta debe ser AHORRO o CORRIENTE")
    private String tipocuenta;

    @NotNull(message = "El saldo inicial es obligatorio")
    @DecimalMin(value = "0.0", message = "El saldo inicial debe ser mayor o igual a cero")
    private BigDecimal saldoinicial;

    private Boolean estado = true;

    // Campos adicionales para mostrar en respuestas
    private String nombreCliente;
    private Long version; // Añadir este campo
}