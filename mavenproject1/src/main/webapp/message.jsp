<%-- 
    Document   : message
    Created on : Aug 19, 2024, 2:31:02 PM
    Author     : arnof
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    String message = ""; 
    if(request.getParameter("btnAction").equals("delete")){
        message = "Data sudah dihapus";
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Message</title>
    </head>
    <body>
        <p><%= message %></p>
        <a href="login.jsp">Back to Home</a>
    </body>
</html>
