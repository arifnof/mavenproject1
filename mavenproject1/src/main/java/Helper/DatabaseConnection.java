/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Helper;
// File: DatabaseConnection.java
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author arnof
 */
public class DatabaseConnection {
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_SERVER = "localhost:8889";
    private static final String DB_NAME = "latihan_jsp3";
    private static final String DB_USER = "root"; // Username database
    private static final String DB_PASSWORD = "root"; // Password database
    private static final String URL = String.format("jdbc:mysql://%s/%s", DB_SERVER, DB_NAME); // URL Database
    
    public static Connection getConnection() throws SQLException, Exception {
        Connection conn = null;
        try {
            // Memuat driver JDBC
            Class.forName(JDBC_DRIVER);
            // Membuat koneksi
            conn = DriverManager.getConnection(URL, DB_USER, DB_PASSWORD);
            return conn;
        } catch (ClassNotFoundException e){
            e.printStackTrace();
            throw new Exception( "Driver JDBC tidak ditemukan!") ;
        } catch (SQLException e){
            e.printStackTrace();
            throw new Exception( "Koneksi ke database gagal!");
        } 
//        finally {
//            // Tutup koneksi jika tidak null
//            if (conn != null){
//                try {
//                    conn. close();
//                } catch (SQLException e) {
//                    e. printStackTrace();
//                }
//            }
//        }
    }

}
