<%@ page import="java.util.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Training JSP</title>
</head>
<body>
    
    <h1>Training JSP</h1>
    
    <h2>Day 1</h2>
    <ul>
        <li>Word Count <a href="./word_count.jsp">/word_count.jsp</a></li>
        <li>Login (native form) <a href="./login.jsp">/login.jsp</a></li>
        <!--<li>Message <a href="./home.jsp">/home.jsp</a></li>-->
        <li>Tugas 1 <a href="./tugas1.jsp">/tugas1.jsp</a></li>
    </ul>

    <h2>Day 2 - 3</h2>
    <ul>
        <li>Cek Koneksi DB <a href="./koneksi.jsp">/koneksi.jsp</a></li>
        <li>Karyawan (CRUD) <a href="./karyawan">/karyawan</a></li>
        <li>Session <a href="./latinput.jsp">/latinput.jsp</a></li>
        <li>Hello <a href="./hello.jsp">/hello.jsp</a></li>
        <li>Trip Validation <a href="./trip.jsp">/trip.jsp</a></li>
    </ul>
    
    <h2>Day 4</h2>
    <ul>
        <li>Temperature Conversion (SOAP) <a href="./temperature_soap.jsp">/temperature_soap.jsp</a></li>
        <li>Calculator (SOAP) <a href="./sum_soap.jsp">/sum_soap.jsp</a></li>
    </ul>
    <p>* jalankan project mavenproject2 (pastikan port 8081 tidak ada service yg berjalan agar tidak bentrok)</p>
    <ul>
        <li>KaryawanService (SOAP) <a href="http://localhost:8081/KaryawanService">http://localhost:8081/KaryawanService</a></li>
        <li>Karyawan List and Detail (SOAP) <a href="./karyawan_soap.jsp">/karyawan_soap.jsp</a></li>
        <li>CalculatorService (SOAP) <a href="http://localhost:8081/CalculatorService">http://localhost:8081/CalculatorService</a></li>
    </ul>
    
    <h2>Day 5</h2>
    <ul>
        <li>Umur (JSON) with POST <a href="./umur_json.jsp">/umur_json.jsp</a></li>
        <li>Karyawan List and Detail (JSON) <a href="./karyawan/json.jsp">/karyawan/json.jsp</a></li>
        <li>JSON Manipulation <a href="./batas_json.jsp">/batas_json.jsp</a></li>
    </ul>
    
</body>
</html>
