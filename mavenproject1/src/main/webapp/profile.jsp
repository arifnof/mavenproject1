<%-- 
    Document   : profile
    Created on : Aug 21, 2024, 9:58:40 AM
    Author     : arnof
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome Page</title>
    </head>
    <body>
        <%
            if(session != null){
                String nama = session.getAttribute("user_name").toString();

                if(nama != null && !nama.trim().isEmpty()){
                    out.print(String.format("<h2>Nama Anda: %s !</h2>", nama));
                }else{
                    out.print("<h2 style=\"color: red\">Nama tidak ditemukan dalam session.</h2>");
                }
            }else{
                out.print("<h2 style=\"color: red\">Session not found!</h2>");
            }
        %>
    </body>
</html>
