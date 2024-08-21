<%-- 
    Document   : trip
    Created on : Aug 20, 2024, 2:25:03 PM
    Author     : arnof
--%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
// List Nama
List<String> nama = new ArrayList<>();
nama.add("Budi");
nama.add("Andi");
nama.add("Ahmad");

// List Negara
List<String> negara = new ArrayList<>();
negara.add("Jepang");
negara.add("Amerika");
negara.add("Australia");
negara.add("Indonesia");

// Menggunakan Map untuk menyimpan kombinasi (Nama -> Negara -> Frekuensi)
Map<String, Map<String, Integer>> data = new HashMap<>();

// Menambahkan data Andi
data.putIfAbsent("Andi", new HashMap<>());
data.get("Andi").put("Jepang", 5);
data.get("Andi").put("Amerika", 3);
data.get("Andi").put("Australia", 2);
data.get("Andi").put("Indonesia", 1);

// Menambahkan data Budi
data.putIfAbsent("Budi", new HashMap<>());
data.get("Budi").put("Jepang", 1);
data.get("Budi").put("Amerika", 5);
data.get("Budi").put("Australia", 4);
data.get("Budi").put("Indonesia", 1);

// Menambahkan data Ahmad
data.putIfAbsent("Ahmad", new HashMap<>());
data.get("Ahmad").put("Jepang", 2);
data.get("Ahmad").put("Amerika", 4);
data.get("Ahmad").put("Australia", 3);
data.get("Ahmad").put("Indonesia", 2);

// Mengecek apakah form telah di-submit
String inputNama = request.getParameter("nama");
String inputNegara = request.getParameter("negara");
String action = request.getParameter("btnAction");

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Trip Calculation!</h1>
        <!-- Form input nama dan negara -->
        <form method="POST" action="./trip.jsp">
            <label for="nama">Nama:</label><br>
            <input type="text" id="nama" name="nama" required value="<%= (inputNama != null ? inputNama : "") %>"><br><br>
            
            <label for="negara">Negara:</label><br>
            <input type="text" id="negara" name="negara" required value="<%= (inputNegara != null ? inputNegara : "") %>"><br><br>
            
            <button type="submit" id="btnAction" name="btnAction" value="cek">Cek Frekuensi</button>
        </form>

        <br/>
        <br/>
        <div>
            <%
            if(action != null && action.equals("cek")){
                // Mengecek berapa kali kombinasi nama dan negara telah muncul menggunakan for-each loop
                boolean found = false;
                for (String namaKey : data.keySet()) {
                    if (namaKey.equalsIgnoreCase(inputNama)) {
                        for (String negaraKey : data.get(namaKey).keySet()) {
                            if (negaraKey.equalsIgnoreCase(inputNegara)) {
                                out.println(" " + inputNama + " ke " + inputNegara + " maksimal " + data.get(namaKey).get(negaraKey) + " kali.");
                                found = true;
                                break;
                            }
                        }
                    }
                }

                if (!found) {
                    out.println("Data tidak ditemukan.");
                }
            }
            
            %>
        </div>
        
    </body>
</html>
