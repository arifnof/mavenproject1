<%-- 
    Document   : karyawan/json
    Created on : Aug 21, 2024, 19:28:10?AM
    Author     : arnof
--%>

<%@ page import="Helper.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>

<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%
    // Koneksi ke database
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // JSON Array untuk menyimpan hasil query
    JSONArray jsonArray = new JSONArray();
    
    String id = request.getParameter("id");
    Integer idInt = null;
    
    JSONObject jsonResponse = new JSONObject();
    
    try {
        try{
            idInt = Integer.parseInt(id);
        }catch(Exception e){
        }

        // Membuka koneksi ke database (Ganti dengan detail database kamu)
        conn = DatabaseConnection.getConnection();

        if(idInt == null){
            // Menjalankan query SELECT
            String query = "SELECT * FROM karyawan";
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();
        }else{
            // Menjalankan query SELECT with filter
            String query = "SELECT * FROM karyawan WHERE id = ? ";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, idInt);
            rs = pstmt.executeQuery();
        }

        // Mendapatkan metadata untuk kolom
        ResultSetMetaData rsmd = rs.getMetaData();
        int columnCount = rsmd.getColumnCount();

        // Iterasi melalui hasil query dan mengonversi ke JSON
        while (rs.next()) {
            // Membuat JSONObject untuk setiap baris
            JSONObject row = new JSONObject();

            for (int i = 1; i <= columnCount; i++) {
                String columnName = rsmd.getColumnName(i);
                Object columnValue = rs.getObject(i);
                row.put(columnName, columnValue);
            }

            // Menambahkan baris ke JSONArray
            jsonArray.put(row);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Menutup resource
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

    // Menampilkan hasil dalam format JSON
    if(jsonArray.length() > 0){
        jsonResponse.put("status", "success");
        jsonResponse.put("data", jsonArray);
    }else{
        jsonResponse.put("status", "error");
        jsonResponse.put("message", "Karyawan tidak ditemukan");
    }
    out.print(jsonResponse.toString());

%>
