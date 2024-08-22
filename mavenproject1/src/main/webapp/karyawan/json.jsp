<%-- 
    Document   : karyawan/json
    Created on : Aug 21, 2024, 19:28:10?AM
    Author     : arnof
--%>

<%@ page import="Config.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>

<%
    // Koneksi ke database
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // JSON Array untuk menyimpan hasil query
    JSONArray jsonArray = new JSONArray();

    try {
        // Membuka koneksi ke database (Ganti dengan detail database kamu)
        conn = DatabaseConnection.getConnection();

        // Menjalankan query SELECT
        String query = "SELECT * FROM karyawan";
        pstmt = conn.prepareStatement(query);
        rs = pstmt.executeQuery();

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
    out.print(jsonArray.toString());
%>
