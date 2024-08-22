/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.mavenproject2;

import jakarta.xml.ws.Endpoint;

/**
 *
 * @author arnof
 */
public class Mavenproject2 {

    public static void main(String[] args) {
        // System.out.println("Hello World!");
        
        // URL untuk CalculatorService
        String calculatorUrl = "http://localhost:8082/CalculatorService";
        // URL untuk KaryawanService
        String karyawanUrl = "http://localhost:8082/KaryawanService";

        // Publikasikan kedua layanan web
        Endpoint.publish(calculatorUrl, new CalculatorService());
        Endpoint.publish(karyawanUrl, new KaryawanService());

        System.out.println("CalculatorService published at " + calculatorUrl);
        System.out.println("KaryawanService published at " + karyawanUrl);
    }
}
