<%-- 
    Document   : karyawan/tambah
    Created on : Aug 20, 2024, 11:29:22?AM
    Author     : arnof
--%>

<%@ page import="java.sql.Connection, java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="Config.DatabaseConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Tambah Karyawan</title>
</head>
<body>
    <h2>Tambah Karyawan Baru</h2>

    <%
        // Mengecek apakah form telah di-submit
        String action = request.getParameter("btnAdd");
        String idParam = request.getParameter("id");
        String namaParam = request.getParameter("name");
        String umurParam = request.getParameter("age");
        String alamat = request.getParameter("alamat");
        String jabatan = request.getParameter("jabatan");

        if (action != null && action.equals("add")){
            if (idParam != null && namaParam != null && umurParam != null) {
                int id = 0;
                try {
                    id = Integer.parseInt(idParam);
                } catch (NumberFormatException e) {
                    out.println("<p style='color:red;'>ID tidak valid. Harap masukkan angka.</p>");
                }

                int umur = 0;
                try {
                    umur = Integer.parseInt(umurParam);
                } catch (NumberFormatException e) {
                    out.println("<p style='color:red;'>Umur tidak valid. Harap masukkan angka.</p>");
                }

                // Pisahkan nama menjadi array menggunakan spasi
                String[] namaArray = namaParam.split(" ");

                // Tentukan nama belakang sebagai elemen terakhir dari array
                String nama_belakang = namaArray[namaArray.length - 1];

                // Tentukan nama depan sebagai gabungan dari elemen sebelum nama belakang
                StringBuilder namaDepan = new StringBuilder();
                for (int i = 0; i < namaArray.length - 1; i++) {
                    namaDepan.append(namaArray[i]);
                    if (i != namaArray.length - 2) {
                        namaDepan.append(" "); // Tambahkan spasi di antara kata-kata nama depan
                    }
                }
                String nama_depan = namaDepan.toString();

                if (umur > 0) {
                    Connection conn = null;
                    PreparedStatement pstmt = null;

                    try {
                        // Membuka koneksi ke database
                        conn = DatabaseConnection.getConnection();

                        // Menyusun SQL untuk menambahkan karyawan baru
                        String sql = "INSERT INTO karyawan (id, first, last, age, alamat, jabatan) VALUES (?, ?, ?, ?, ?, ?)";
                        pstmt = conn.prepareStatement(sql);

                        // Mengisi parameter PreparedStatement
                        pstmt.setInt(1, id);
                        pstmt.setString(2, nama_depan);
                        pstmt.setString(3, nama_belakang);
                        pstmt.setInt(4, umur);
                        pstmt.setString(5, alamat);
                        pstmt.setString(6, jabatan);

                        // Eksekusi query untuk menyimpan data
                        int rowsInserted = pstmt.executeUpdate();

                        if (rowsInserted > 0) {
                            out.println("<p style='color:green;'>Karyawan berhasil ditambahkan.</p>");
                        } else {
                            out.println("<p style='color:red;'>Gagal menambahkan karyawan.</p>");
                        }

                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<p style='color:red;'>Kesalahan dalam menyimpan data ke database.</p>");
                    } finally {
                        // Menutup resource
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                }else{
                    out.println("<p style='color:red;'>Umur harus lebih besar dari 0.</p>");
                }
            }
        }
    %>

    <!-- Form input data karyawan baru -->
    <form method="post" action="./tambah.jsp">
        <a href="./">List Karyawan</a>
        <br/>
        <label for="nama">ID:</label><br>
        <input type="text" id="id" name="id" required><br><br>

        <label for="jabatan">Nama:</label><br>
        <input type="text" id="name" name="name" required><br><br>

        <label for="age">Umur:</label><br>
        <input type="number" id="age" name="age" step="1" required><br><br>
        
        <label for="jabatan">Jabatan:</label><br>
        <input type="text" id="jabatan" name="jabatan" required><br><br>
        
        <label for="alamat">Alamat:</label><br>
        <textarea id="alamat" name="alamat" required></textarea><br><br>

        <button type="submit" name="btnAdd" value="add">Simpan</button>
    </form>
</body>
</html>
