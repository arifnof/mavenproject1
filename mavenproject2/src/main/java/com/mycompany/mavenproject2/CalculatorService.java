package com.mycompany.mavenproject2;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author arnof
 */
import jakarta.jws.WebMethod;
import jakarta.jws.WebService;

@WebService
public class CalculatorService {

    @WebMethod
    public int Add(int intA, int intB) {
        return intA + intB;
    }

    @WebMethod
    public int Subtract(int intA, int intB) {
        return intA - intB;
    }

    @WebMethod
    public int Multiply(int intA, int intB) {
        return intA * intB;
    }

    @WebMethod
    public int Divide(int intA, int intB) {
        if (intB == 0) {
            throw new IllegalArgumentException("Division by zero is not allowed.");
        }
        return intA / intB;
    }
}