/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.mavenproject2;

/**
 *
 * @author arnof
 */
import Helper.DatabaseConnection;
import jakarta.jws.*;
import java.sql.*;
import java.util.*;
import model.*;

@WebService
public class KaryawanService {

    // Method untuk mendapatkan daftar karyawan
    @WebMethod
    public List<Karyawan> getKaryawanList() {
        List<Karyawan> karyawanList = new ArrayList<>();
        
        // Koneksi ke database
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            // Koneksi ke database MySQL (ganti dengan detail koneksi yang benar)
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DatabaseConnection.getConnection();

            // Menjalankan query
            stmt = conn.createStatement();
            String sql = "SELECT id, age, first, last, alamat, jabatan FROM karyawan";
            rs = stmt.executeQuery(sql);

            // Menambahkan data karyawan ke list
            while (rs.next()) {
                Karyawan karyawan = new Karyawan();
                karyawan.setId(rs.getInt("id"));
                karyawan.setAge(rs.getInt("age"));
                karyawan.setFirst(rs.getString("first"));
                karyawan.setLast(rs.getString("last"));
                karyawan.setAlamat(rs.getString("alamat"));
                karyawan.setJabatan(rs.getString("jabatan"));
                karyawanList.add(karyawan);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return karyawanList;
    }
    
    @WebMethod
    public Karyawan getKaryawanById(String id) {
        Integer idInt = null;
        try{
            idInt = Integer.parseInt(id);
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
        
        Karyawan karyawan = null;
        
        // Koneksi ke database
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Koneksi ke database MySQL (ganti dengan detail koneksi yang benar)
            conn = DatabaseConnection.getConnection();

            // Menjalankan query
            String sql = "SELECT id, age, first, last, alamat, jabatan FROM karyawan WHERE id = ? ";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idInt);
            rs = pstmt.executeQuery();

            // Menambahkan data karyawan ke list
            if (rs.next()) {
                karyawan = new Karyawan();
                karyawan.setId(rs.getInt("id"));
                karyawan.setAge(rs.getInt("age"));
                karyawan.setFirst(rs.getString("first"));
                karyawan.setLast(rs.getString("last"));
                karyawan.setAlamat(rs.getString("alamat"));
                karyawan.setJabatan(rs.getString("jabatan"));
                
                return karyawan;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return karyawan;
    }
}