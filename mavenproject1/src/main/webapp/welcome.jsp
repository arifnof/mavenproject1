<%-- 
    Document   : welcome
    Created on : Aug 21, 2024, 9:28:36 AM
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
            String nama = request.getParameter("nama");
            
            if(nama != null && !nama.trim().isEmpty()){
                session.setAttribute("user_name", nama);
                
                out.print(String.format("<h2>Selamat Datang, %s !</h2>", session.getAttribute("user_name").toString()));
                out.print("<br/>");
                out.print("<br/>");
                out.print("<a href=\"./profile.jsp\">Halaman Profil</a>");
            }else{
                out.print("<h2 style=\"\">Nama belum diinput.</h2>");
            }
        %>
    </body>
</html>
