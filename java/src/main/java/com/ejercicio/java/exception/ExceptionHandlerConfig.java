package com.ejercicio.java.exception;

import com.ejercicio.java.exception.ErrorResponse;
import com.ejercicio.java.exception.RecursoNoEncontradoException;
import com.ejercicio.java.exception.SaldoNoDisponibleException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.ConstraintViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

@RestControllerAdvice
public class ExceptionHandlerConfig {

    @ExceptionHandler(RecursoNoEncontradoException.class)
    public ResponseEntity<ErrorResponse> handleRecursoNoEncontradoException(
            RecursoNoEncontradoException ex, HttpServletRequest request) {
        ErrorResponse errorResponse = new ErrorResponse(
                ZonedDateTime.now(),
                HttpStatus.NOT_FOUND.value(),
                HttpStatus.NOT_FOUND.getReasonPhrase(),
                ex.getMessage(),
                request.getRequestURI()
        );
        return new ResponseEntity<>(errorResponse, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(SaldoNoDisponibleException.class)
    public ResponseEntity<ErrorResponse> handleSaldoNoDisponibleException(
            SaldoNoDisponibleException ex, HttpServletRequest request) {
        ErrorResponse errorResponse = new ErrorResponse(
                ZonedDateTime.now(),
                HttpStatus.BAD_REQUEST.value(),
                HttpStatus.BAD_REQUEST.getReasonPhrase(),
                ex.getMessage(),
                request.getRequestURI()
        );
        return new ResponseEntity<>(errorResponse, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidationExceptions(
            MethodArgumentNotValidException ex, HttpServletRequest request) {

        BindingResult result = ex.getBindingResult();
        List<FieldError> fieldErrors = result.getFieldErrors();

        ErrorResponse errorResponse = processFieldErrors(fieldErrors, request);

        return new ResponseEntity<>(errorResponse, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(ConstraintViolationException.class)
    public ResponseEntity<ErrorResponse> handleConstraintViolationException(
            ConstraintViolationException ex, HttpServletRequest request) {

        ErrorResponse errorResponse = new ErrorResponse(
                ZonedDateTime.now(),
                HttpStatus.BAD_REQUEST.value(),
                HttpStatus.BAD_REQUEST.getReasonPhrase(),
                "Error de validación",
                request.getRequestURI()
        );

        ex.getConstraintViolations().forEach(violation -> {
            String field = violation.getPropertyPath().toString();
            field = field.substring(field.lastIndexOf('.') + 1);
            errorResponse.getErrors().add(new ErrorResponse.ValidationError(field, violation.getMessage()));
        });

        return new ResponseEntity<>(errorResponse, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleGenericException(
            Exception ex, HttpServletRequest request) {
        ErrorResponse errorResponse = new ErrorResponse(
                ZonedDateTime.now(),
                HttpStatus.INTERNAL_SERVER_ERROR.value(),
                HttpStatus.INTERNAL_SERVER_ERROR.getReasonPhrase(),
                "Error interno del servidor: " + ex.getMessage(),
                request.getRequestURI()
        );
        return new ResponseEntity<>(errorResponse, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    private ErrorResponse processFieldErrors(List<FieldError> fieldErrors, HttpServletRequest request) {
        ErrorResponse errorResponse = new ErrorResponse(
                ZonedDateTime.now(),
                HttpStatus.BAD_REQUEST.value(),
                HttpStatus.BAD_REQUEST.getReasonPhrase(),
                "Error de validación",
                request.getRequestURI()
        );

        List<ErrorResponse.ValidationError> validationErrors = new ArrayList<>();
        for (FieldError fieldError : fieldErrors) {
            validationErrors.add(new ErrorResponse.ValidationError(fieldError.getField(), fieldError.getDefaultMessage()));
        }

        errorResponse.setErrors(validationErrors);
        return errorResponse;
    }
}