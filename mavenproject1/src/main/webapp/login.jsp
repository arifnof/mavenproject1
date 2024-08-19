<%-- 
    Document   : login
    Created on : Aug 19, 2024, 2:12:36 PM
    Author     : arnof
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <form action="home.jsp" method="POST">
            <h1>Login!</h1>
            <label for="name">Nama: </label><input id='name' name="name" /><br/>
            <label for="id">ID: </label><input id='id' name="id" /><br/>
            <label for="address">Alamat:</label><textarea id='address' name="address" ></textarea><br/>
            <button>Tampil</button>
        </form>
    </body>
</html>
