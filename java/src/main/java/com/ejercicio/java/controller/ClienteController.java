package com.ejercicio.java.controller;

import com.ejercicio.java.dto.ClienteDTO;
import com.ejercicio.java.service.ClienteService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/clientes")
@RequiredArgsConstructor
public class ClienteController {

    private final ClienteService clienteService;

    @GetMapping
    public ResponseEntity<List<ClienteDTO>> listarClientes() {
        return ResponseEntity.ok(clienteService.listarClientes());
    }

    @GetMapping("/{clienteid}")
    public ResponseEntity<ClienteDTO> obtenerClientePorId(@PathVariable Long clienteid) {
        return ResponseEntity.ok(clienteService.obtenerClientePorId(clienteid));
    }

    @PostMapping
    public ResponseEntity<ClienteDTO> crearCliente(@Valid @RequestBody ClienteDTO clienteDTO) {
        ClienteDTO clienteCreado = clienteService.crearCliente(clienteDTO);
        return new ResponseEntity<>(clienteCreado, HttpStatus.CREATED);
    }

    // CORREGIDO: La variable en la ruta ahora coincide con el parámetro del método
    @PutMapping("/{id}")
    public ResponseEntity<ClienteDTO> actualizarCliente(
            @PathVariable Long id,  // Nombre coincide con la URL
            @Valid @RequestBody ClienteDTO clienteDTO) {
        return ResponseEntity.ok(clienteService.actualizarCliente(id, clienteDTO));
    }

    // CORREGIDO: La variable en @PathVariable ahora coincide con la de la ruta
    @DeleteMapping("/{clienteid}")
    public ResponseEntity<Void> eliminarCliente(@PathVariable Long clienteid) {
        clienteService.eliminarCliente(clienteid);
        return ResponseEntity.noContent().build();
    }
}