<%-- 
    Document   : umur_json
    Created on : Aug 23, 2024, 2:25:59 PM
    Author     : arnof
--%>

<%@page import="java.time.*"%>
<%@page import="org.json.*"%>
<%@page import="java.io.*"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>

<%
    // Menerima data JSON dari request
    BufferedReader reader = request.getReader();
    StringBuilder jsonInput = new StringBuilder();
    String line;
    while ((line = reader.readLine()) != null) {
        jsonInput.append(line);
    }
    
    JSONObject inputJson;
    String input = "";
    if(jsonInput.toString().equals("")){
        out.print("{\"status\":\"error\",\"message\":\"body is empty\"}");
        return;
    }
    
    JSONObject responseJson;

    try{
        // Mengubah string JSON menjadi objek JSONObject
        inputJson = new JSONObject(jsonInput.toString());

        // Mengambil nama dan tahun dari JSON
        String nama = inputJson.getString("nama");
        int tahunLahir = inputJson.getInt("tahun");

        // Menghitung usia berdasarkan tahun lahir
        int currentYear = Year.now().getValue();
        int usia = currentYear - tahunLahir;

        // Membuat JSON untuk respons
        responseJson = new JSONObject();
        responseJson.put("nama", nama);
        responseJson.put("usia", usia);

        // Mengembalikan JSON sebagai respons
        out.print(responseJson.toString());
    }catch(Exception e){
        responseJson = new JSONObject();
        responseJson.put("status", "error");
        responseJson.put("message", e.getMessage());

        // Output JSON
        out.println(responseJson.toString());
    }
%>
