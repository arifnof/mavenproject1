<%-- 
    Document   : home
    Created on : Aug 19, 2024, 2:12:45 PM
    Author     : arnof
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalTime" %>

<%
String message = request.getParameter("message");

String pesanWaktu = "";
// Dapatkan waktu saat ini
LocalTime waktuSekarang = LocalTime.now();

// Tentukan pesan berdasarkan waktu
if (waktuSekarang.isAfter(LocalTime.of(1, 0)) && waktuSekarang.isBefore(LocalTime.of(10, 0))) {
    pesanWaktu = "Selamat Pagi!";
} else if (waktuSekarang.isAfter(LocalTime.of(10, 0)) && waktuSekarang.isBefore(LocalTime.of(17, 0))) {
    pesanWaktu = "Selamat Siang!";
} else {
    pesanWaktu = "Selamat Sore!";
}

// Tampilkan pesan waktu
// out.println("<h3>" + pesanWaktu + "</h3>");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
    </head>
    <body>
        <h1><%= pesanWaktu %></h1>
        
        <form action="hello.jsp" method="POST">
            <textarea name="message"><%= (message != null ? message : "") %></textarea>
            <br/>
            <button name="btnAction" value="submit">Submit</button>
        </form>
    </body>
</html>
