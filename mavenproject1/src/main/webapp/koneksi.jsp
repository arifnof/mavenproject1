<%-- 
    Document   : koneksi
    Created on : Aug 20, 2024, 10:18:40?AM
    Author     : arnof
--%>

<%@ page import="java.sql.*" %>

<%
    Connection conn = null;
    String url = "jdbc:mysql://localhost:8889/latihan_jsp3"; // URL Database
    String user = "root"; // Username database
    String password = "root"; // Password database
    try {
        // Memuat driver JDBC
        Class.forName("com.mysql.cj.jdbc.Driver");
        // Membuat koneksi
        conn = DriverManager.getConnection(url, user, password);
        out.println( "Koneksi ke database berhasil!");
    } catch (ClassNotFoundException e){
        out.println ("Driver JDBC tidak ditemukan!") ;
        e.printStackTrace();
    } catch (SQLException e){
        out.println("Koneksi ke database gagal!");
        e.printStackTrace();
    } finally {
        // Tutup koneksi jika tidak null
        if (conn != null){
            try {
                conn. close();
            } catch (SQLException e) {
                e. printStackTrace();
            }
        }
    }
%>