<%-- 
    Document   : home
    Created on : Aug 19, 2024, 2:12:45 PM
    Author     : arnof
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String name = request.getParameter("name");
String id = request.getParameter("id");
String address = request.getParameter("address");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
    </head>
    <body>
        <h1>Selamat Datang!</h1>
        
        <form action="message.jsp" method="POST">
            <p>Nama: <span><%= name %></span></p>
            <p>ID: <span><%= id %></span></p>
            <p>Alamat: <span><%= address %></span></p>
            <p></p>
            <p></p>
            <button name="btnAction" value="delete">Hapus</button>
        </form>
    </body>
</html>
