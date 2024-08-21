<%-- 
    Document   : karyawan/tambah
    Created on : Aug 20, 2024, 11:29:22?AM
    Author     : arnof
--%>

<%@ page import="java.sql.*" %>
<%@ page import="Config.DatabaseConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Karyawan</title>
</head>
<body>
    <h2>Edit Data Karyawan</h2>

    <%
        String action = request.getParameter("btnEdit");
        String idx = request.getParameter("id");
        String idParam = request.getParameter("idParam");
        String namaParam = request.getParameter("name");
        String umurParam = request.getParameter("age");

        int id = 0;
        int umur = 0;
        String nama_depan = "";
        String nama_belakang = "";

        Connection conn = null;
        PreparedStatement pstmt = null;

        if (action != null && action.equals("edit")) {
            // Proses pengeditan data karyawan
            if (idParam != null && namaParam != null && umurParam != null) {
                try {
                    try {
                        id = Integer.parseInt(idParam);
                    } catch (NumberFormatException e) {
                        out.println("<p style='color:red;'>ID tidak valid. Harap masukkan angka.</p>");
                    }
                    
                    try {
                        umur = Integer.parseInt(umurParam);
                    } catch (NumberFormatException e) {
                        out.println("<p style='color:red;'>Umur tidak valid. Harap masukkan angka.</p>");
                    }

                    // Pisahkan nama menjadi array menggunakan spasi
                    String[] namaArray = namaParam.split(" ");
                    nama_belakang = namaArray[namaArray.length - 1];
                    StringBuilder namaDepan = new StringBuilder();
                    for (int i = 0; i < namaArray.length - 1; i++) {
                        namaDepan.append(namaArray[i]);
                        if (i != namaArray.length - 2) {
                            namaDepan.append(" "); // Tambahkan spasi di antara kata-kata nama depan
                        }
                    }
                    nama_depan = namaDepan.toString();

                    // Proses update ke database
                    conn = DatabaseConnection.getConnection();
                    String sql = "UPDATE karyawan "
                               + "SET first=?, last=?, age=? "
                               + "WHERE id=? ";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, nama_depan);
                    pstmt.setString(2, nama_belakang);
                    pstmt.setInt(3, umur);
                    pstmt.setInt(4, id);

                    int rowsUpdated = pstmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        out.println("<p style='color:green;'>Karyawan berhasil diupdate.</p>");
                    } else {
                        out.println("<p style='color:red;'>Gagal mengupdate karyawan.</p>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Kesalahan dalam menyimpan data ke database.</p>");
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        } else {
            // Menampilkan data karyawan berdasarkan ID sebelum diedit
            if (idx != null && !idx.isEmpty()) {
                try {
                    id = Integer.parseInt(idx);
                    conn = DatabaseConnection.getConnection();
                    String sql = "SELECT * FROM karyawan WHERE id=?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, id);
                    ResultSet rs = pstmt.executeQuery();

                    if (rs.next()) {
                        umur = rs.getInt("age");
                        nama_depan = rs.getString("first");
                        nama_belakang = rs.getString("last");
                    } else {
                        out.println("<p style='color:red;'>Karyawan tidak ditemukan.</p>");
                    }
                } catch (NumberFormatException e) {
                    out.println("<p style='color:red;'>ID tidak valid. Harap masukkan angka.</p>");
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Kesalahan dalam mengambil data dari database.</p>");
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            } else {
                out.println("<p style='color:red;'>ID tidak ditemukan.</p>");
            }
        }
    %>

    <!-- Form input data karyawan yang akan diedit -->
    <form method="post" action="edit.jsp?id=<%= id %>">
        <a href="./">List Karyawan</a>
        <br/>
        <label for="id">ID:</label><br>
        <input type="text" id="idParam" name="idParam" value="<%= id %>" readonly><br><br>

        <label for="name">Nama:</label><br>
        <input type="text" id="name" name="name" value="<%= (namaParam != null ? namaParam : nama_depan + " " + nama_belakang) %>" required><br><br>

        <label for="age">Umur:</label><br>
        <input type="number" id="age" name="age" value="<%= (umurParam != null ? umurParam : umur) %>" required><br><br>

        <button type="submit" name="btnEdit" value="edit">Simpan Perubahan</button>
    </form>
</body>
</html>

