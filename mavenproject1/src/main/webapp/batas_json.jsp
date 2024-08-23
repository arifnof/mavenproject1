<%-- 
    Document   : batas_json
    Created on : Aug 23, 2024, 10:30:43 AM
    Author     : arnof
--%>

<%@page import="org.json.*"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>

<%    
    JSONObject orang1 = new JSONObject();
    orang1.put("nama", "arif");
    orang1.put("usia", "30");
    orang1.put("kota", "jakarta");
    orang1.put("negara", "Indonesia");

    JSONObject orang2 = new JSONObject();
    orang2.put("nama", "rizki");
    orang2.put("usia", "35");
    orang2.put("kota", "bogor");
    orang2.put("negara", "Malaysia");

    JSONObject orang3 = new JSONObject();
    orang3.put("nama", "bran");
    orang3.put("usia", "20");
    orang3.put("kota", "bogor");
    orang3.put("negara", "indonesia");

    JSONObject orang4 = new JSONObject();
    orang4.put("nama", "mia");
    orang4.put("usia", "25");
    orang4.put("kota", "depok");
    orang4.put("negara", "Singapura");

    JSONArray jsonArray = new JSONArray();
    jsonArray.put(orang1);
    jsonArray.put(orang2);
    jsonArray.put(orang3);
    jsonArray.put(orang4);

    JSONArray jsonNama = new JSONArray();
    for (int i = 0; i < Math.min(jsonArray.length(), 3); i++) {
        JSONObject person = jsonArray.getJSONObject(i);
        jsonNama.put(person.getString("nama"));
    }

    JSONArray jsonUsia = new JSONArray();
    for (int i = 0; i < Math.min(jsonArray.length(), 1); i++) {
        JSONObject person = jsonArray.getJSONObject(i);
        jsonUsia.put(person.getString("usia"));
    }

    JSONArray jsonKota = new JSONArray();
    for (int i = 0; i < Math.min(jsonArray.length(), 3); i++) {
        JSONObject person = jsonArray.getJSONObject(i);
        jsonKota.put(person.getString("kota"));
    }

    JSONArray jsonNegara = new JSONArray();
    for (int i = 0; i < Math.min(jsonArray.length(), 1); i++) {
        JSONObject person = jsonArray.getJSONObject(i);
        jsonNegara.put(person.getString("negara"));
    }

    JSONObject hasil = new JSONObject();
    hasil.put("nama", jsonNama);
    hasil.put("usia", jsonUsia);
    hasil.put("kota", jsonKota);
    hasil.put("negara", jsonNegara);

    response.setContentType("application/json");
    out.print(hasil.toString());
%>