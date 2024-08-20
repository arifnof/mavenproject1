<%-- 
    Document   : tugas1
    Created on : Aug 19, 2024, 2:52:16 PM
    Author     : arnof
--%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
String hapusKomaTerakhir(List<Integer> numbers){
    StringBuilder numberString = new StringBuilder();
        for (int num : numbers) {
            numberString.append(num).append(", ");
        }

        // Remove the last comma and space, if present
        if (numberString.length() > 0) {
            numberString.setLength(numberString.length() - 2);
        }
    return numberString.toString();
}
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tugas Hari-1</title>
    </head>
    <body>
        <h1>1. Tampilkan *** format 5x5</h1>
        <div>
            <%
                for(int i=1; i<=5; i++){
                    for(int j=1; j<=5; j++){
                        out.print("*");
                    }
                    out.print("<br/>");
                }
            %>
        </div>
        <h1>2. Tampilkan angka 0 - 100 </h1>
        <h2>a. genap </h2>
        <div>
            <%
                List<Integer> genap = new ArrayList<>();
                for(int i=0; i<=100; i++){
                    if(i % 2 == 0){
                        genap.add(i);
                    }
                }
                out.print(hapusKomaTerakhir(genap));
            %>
        </div>
        <h2>b. ganjil </h2>
        <div>
            <%
                List<Integer> ganjil = new ArrayList<>();
                for(int i=0; i<=100; i++){
                    if(i % 2 == 1){
                        ganjil.add(i);
                    }
                }
                out.print(hapusKomaTerakhir(ganjil));
            %>
        </div>
        <h2>c. genap bersusun format 5x10 </h2>
        <table>
            <%
                int n=0;
                for(int i=0; i<=100; i++){
                    if(i % 2 == 0){
                        if(n == 0){
                            out.print("<tr>");
                        }
                        out.print("<td>" + i + "</td>");
                        n++;
                        if(n == 5){
                            out.print("</tr>");
                            n=0;
                        }
                    }
                }
            %>
        </table>
        <h1>
            3. Budi usia 10 tahun <br/> 
               Andi usia 11 tahun <br/> 
               Indah usia 20 tahun <br/> 
               Irwan usia 25 tahun <br/> 
        </h1>
        <h2>
            Ani usia lebih muda dari Indah <br/>
            Tetapi Ani lebih tua dari Andi <br/>
            Berapa jangka usia Ani dengan Budi <br/>
        </h2>
        <div>
            <%
                int usiaBudi = 10;
                int usiaAndi = 11;
                int usiaIndah = 20;
                int usiaIrwan = 25;
                
                // Batas minimum dan maksimum usia Ani berdasarkan informasi sebelumnya
                int minUsiaAni = 12; // Usia minimal Ani lebih tua dari Andi
                int maxUsiaAni = 19; // Usia maksimal Ani lebih muda dari Indah

                // Hitung minimum dan maksimum jarak usia Ani dengan Budi
                int minJarakUsia = minUsiaAni - usiaBudi;
                int maxJarakUsia = maxUsiaAni - usiaBudi;

                // Menampilkan hasil
                out.println("<h3>Hasil Perhitungan:</h3>");
                out.println("<p>Usia Andi: " + usiaAndi + " tahun</p>");
                out.println("<p>Usia Indah: " + usiaIndah + " tahun</p>");
                out.println("<p>Usia Budi: " + usiaBudi + " tahun</p>");
                out.println("<h4>Perhitungan Jarak Usia:</h4>");
                out.println("<p>Minimum jarak usia Ani dengan Budi (Usia Ani 12 tahun): " + minJarakUsia + " tahun</p>");
                out.println("<p>Maksimum jarak usia Ani dengan Budi (Usia Ani 19 tahun): " + maxJarakUsia + " tahun</p>");
            %>
        </div>
    </body>
</html>
