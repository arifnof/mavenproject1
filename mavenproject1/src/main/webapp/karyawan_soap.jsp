<%-- 
    Document   : karyawan_soap
    Created on : Aug 22, 2024, 11:21:36?AM
    Author     : arnof
--%>

<%@ page import="Helper.SoapHelper"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="javax.xml.namespace.QName"%>
<%@ page import="jakarta.xml.soap.*" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.net.URL" %>

<!DOCTYPE html>
<html>
<head>
    <title>Consume SOAP Web Service - Karyawan</title>
</head>
<body>
    <h2>Consume SOAP Web Service - Karyawan</h2>

    <%
    try {
        // Membuat SOAP Connection
        SOAPConnectionFactory soapConnFactory = SOAPConnectionFactory.newInstance();
        SOAPConnection soapConnection = soapConnFactory.createConnection();

        // URL dari Web Service
        URL endpoint = new URL("http://localhost:8082/KaryawanService");

        // Membuat pesan SOAP
        MessageFactory messageFactory = MessageFactory.newInstance();
        SOAPMessage soapMessage = messageFactory.createMessage();
        SOAPPart soapPart = soapMessage.getSOAPPart();

        // Mendapatkan envelope
        SOAPEnvelope envelope = soapPart.getEnvelope();
        envelope.addNamespaceDeclaration("tem", "http://mavenproject2.mycompany.com/");

        // Menyusun SOAP body
        SOAPBody soapBody = envelope.getBody();
        SOAPElement soapBodyElem = soapBody.addChildElement("getKaryawanList", "tem");

        // Simpan perubahan ke SOAP message
        soapMessage.saveChanges();

        // Menambahkan header SOAPAction
        MimeHeaders headers = soapMessage.getMimeHeaders();
        headers.addHeader("SOAPAction", "http://localhost:8082/getKaryawanList");
        
        // Mengirimkan pesan SOAP ke server dan menerima respons
        SOAPMessage soapResponse = soapConnection.call(soapMessage, endpoint);

        // Konversi respons SOAP ke string
        ByteArrayOutputStream outStream = new ByteArrayOutputStream();
        soapResponse.writeTo(outStream);
        String soapResponseString = new String(outStream.toByteArray());

        // Menampilkan respons SOAP sebagai string (raw XML)
        out.println("<h3>SOAP Response (Raw XML):</h3>");
        out.println("<pre>" + soapResponseString.replaceAll("<", "&lt;").replaceAll(">", "&gt;") + "</pre>");

        // Mengambil data karyawan dari response XML
        SOAPBody responseBody = soapResponse.getSOAPBody();
        java.util.Iterator<?> it = responseBody.getChildElements();
        
        out.println("<h3>Daftar Karyawan:</h3>");
        out.println("<ul>");

        
        // Memeriksa apakah elemen getKaryawanListResponse ada
        Iterator<?> responseIterator = responseBody.getChildElements(new QName("http://mavenproject2.mycompany.com/", "getKaryawanListResponse"));

        if (responseIterator.hasNext()) {
            SOAPElement getKaryawanListResponseElement = (SOAPElement) responseIterator.next();

            // Menemukan elemen <return> yang berisi data karyawan
            Iterator<?> karyawanIterator = getKaryawanListResponseElement.getChildElements(new QName("return"));

            // Membuat tabel untuk menampilkan data karyawan
            out.println("<table>");
            out.println("<tr><th>ID</th><th>First Name</th><th>Last Name</th><th>Age</th><th>Alamat</th><th>Jabatan</th></tr>");

            // Iterasi melalui hasil response dan menampilkan data karyawan dalam tabel
            while (karyawanIterator.hasNext()) {
                SOAPElement karyawanElement = (SOAPElement) karyawanIterator.next();

                String id = karyawanElement.getChildElements(new QName("id")).next().getTextContent();
                String first = SoapHelper.getOptionalElement(karyawanElement, "first");
                String last = SoapHelper.getOptionalElement(karyawanElement, "last");
                String age = SoapHelper.getOptionalElement(karyawanElement, "age");
                String alamat = SoapHelper.getOptionalElement(karyawanElement, "alamat");
                String jabatan = SoapHelper.getOptionalElement(karyawanElement, "jabatan");

                out.println("<tr>");
                out.println("<td>" + id + "</td>");
                out.println("<td>" + (first.isEmpty() ? "-" : first) + "</td>");
                out.println("<td>" + (last.isEmpty() ? "-" : last) + "</td>");
                out.println("<td>" + (age.isEmpty() ? "-" : age) + "</td>");
                out.println("<td>" + (alamat.isEmpty() ? "-" : alamat) + "</td>");
                out.println("<td>" + (jabatan.isEmpty() ? "-" : jabatan) + "</td>");
                out.println("</tr>");
            }

            out.println("</table>");
        } else {
            out.println("<p>Hasil tidak ditemukan dalam respons SOAP.</p>");
        }

        // Menutup koneksi SOAP
        soapConnection.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

    %>

</body>
</html>
