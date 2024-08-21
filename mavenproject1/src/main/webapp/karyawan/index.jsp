<%-- 
    Document   : karyawan/index
    Created on : Aug 20, 2024, 11:29:22?AM
    Author     : arnof
--%>

<%@ page import="java.sql.*" %>
<%@ page import="Config.DatabaseConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Daftar Karyawan</title>
</head>
<body>
    <h2>Daftar Karyawan</h2>
    <a href="./tambah.jsp" >Tambah</a>
    <table border="1" cellpadding="10">
        <thead>
            <tr>
                <th>Action</th>
                <th>ID</th>
                <th>Nama</th>
                <th>Umur</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Membuka koneksi ke database
                    conn = DatabaseConnection.getConnection();
                    stmt = conn.createStatement();

                    // Menjalankan query untuk mengambil data dari tabel karyawan
                    String sql = "SELECT * FROM karyawan";
                    rs = stmt.executeQuery(sql);

                    // Menampilkan data
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        int umur = rs.getInt("age");
                        String nama_depan = rs.getString("first");
                        String nama_belakang = rs.getString("last");

                        // Menampilkan data dalam tabel HTML
                        out.println("<tr>");
                        out.println("<td style=\"text-align: center\"><a href=\"./edit.jsp?id=" + id + "\">Edit</a></td>");
                        out.println("<td>" + id + "</td>");
                        out.println("<td>" + nama_depan + ' ' + nama_belakang + "</td>");
                        out.println("<td>" + umur + "</td>");
                        out.println("</tr>");
                    }

                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='3'>Gagal mengambil data!</td></tr>");
                } finally {
                    // Menutup resource
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </tbody>
    </table>
</body>
</html>
