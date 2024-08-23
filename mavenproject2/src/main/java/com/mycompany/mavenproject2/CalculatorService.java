package com.mycompany.mavenproject2;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author arnof
 */
import jakarta.jws.*;

@WebService
public class CalculatorService {

    @WebMethod
    public int Add(@WebParam(name = "intA") int intA, @WebParam(name = "intB") int intB) {
        return intA + intB;
    }

    @WebMethod
    public int Subtract(@WebParam(name = "intA") int intA, @WebParam(name = "intB") int intB) {
        return intA - intB;
    }

    @WebMethod
    public int Multiply(@WebParam(name = "intA") int intA, @WebParam(name = "intB") int intB) {
        return intA * intB;
    }

    @WebMethod
    public int Divide(@WebParam(name = "intA") int intA, @WebParam(name = "intB") int intB) {
        if (intB == 0) {
            throw new IllegalArgumentException("Division by zero is not allowed.");
        }
        return intA / intB;
    }
}