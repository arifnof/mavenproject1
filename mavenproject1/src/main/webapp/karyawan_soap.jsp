<%@page import="java.io.*"%>
<%@page import="jakarta.xml.soap.*"%>
<%@page import="java.net.*"%>
<%@page import="Helper.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.xml.namespace.QName"%>
<!DOCTYPE html>
<html>
<head>
    <title>Consume SOAP Web Service - Karyawan</title>
</head>
<body>
    <h2>Consume SOAP Web Service - Karyawan</h2>

    <!-- Form untuk memasukkan ID Karyawan -->
    <form method="GET">
        <label for="id_karyawan">ID Karyawan:</label>
        <input type="text" id="id_karyawan" name="id_karyawan" placeholder="Kosongkan untuk semua karyawan">
        <button type="submit">Cari</button>
    </form>

    <%
    try {
        // Ambil ID Karyawan dari parameter
        String idKaryawan = request.getParameter("id_karyawan");
        
        // Membuat SOAP Connection
        SOAPConnectionFactory soapConnFactory = SOAPConnectionFactory.newInstance();
        SOAPConnection soapConnection = soapConnFactory.createConnection();

        // URL dari Web Service
        URL endpoint = new URL("http://localhost:8081/KaryawanService");

        // Membuat pesan SOAP
        MessageFactory messageFactory = MessageFactory.newInstance();
        SOAPMessage soapMessage = messageFactory.createMessage();
        SOAPPart soapPart = soapMessage.getSOAPPart();

        // Mendapatkan envelope
        SOAPEnvelope envelope = soapPart.getEnvelope();
        envelope.addNamespaceDeclaration("tem", "http://mavenproject2.mycompany.com/");

        // Menyusun SOAP body
        SOAPBody soapBody = envelope.getBody();
        // Jika id_karyawan tidak kosong, tambahkan ke SOAP request
        if (idKaryawan != null && !idKaryawan.isEmpty()) {
            SOAPElement soapBodyElem = soapBody.addChildElement("getKaryawanById", "tem");
            SOAPElement idKaryawanElem = soapBodyElem.addChildElement("id");
            idKaryawanElem.addTextNode(idKaryawan);
        }else{
            SOAPElement soapBodyElem = soapBody.addChildElement("getKaryawanList", "tem");
        }

        // Simpan perubahan ke SOAP message
        soapMessage.saveChanges();

        // Menambahkan header SOAPAction
        MimeHeaders headers = soapMessage.getMimeHeaders();
        headers.addHeader("SOAPAction", "http://localhost:8081/getKaryawanList");

        // Mengirimkan pesan SOAP ke server dan menerima respons
        SOAPMessage soapResponse = soapConnection.call(soapMessage, endpoint);

        // Konversi respons SOAP ke string
        ByteArrayOutputStream outStream = new ByteArrayOutputStream();
        soapResponse.writeTo(outStream);
        String soapResponseString = new String(outStream.toByteArray());
        
        String prettyPrintedXml = SoapHelper.getPrettyPrint(soapResponseString);
        
        // Menampilkan respons SOAP sebagai string (raw XML)
        out.println("<h3>SOAP Response (Raw XML):</h3>");
        out.println("<pre>" + prettyPrintedXml.replaceAll("<", "&lt;").replaceAll(">", "&gt;") + "</pre>");

        // Mengambil data karyawan dari response XML
        SOAPBody responseBody = soapResponse.getSOAPBody();
        java.util.Iterator<?> it = responseBody.getChildElements();

        out.println("<h3>Daftar Karyawan:</h3>");
        out.println("<ul>");
        
        Iterator<?> responseIterator;
        // Memeriksa apakah elemen getKaryawanListResponse ada
        if (idKaryawan != null && !idKaryawan.isEmpty()) {
            responseIterator = responseBody.getChildElements(new QName("http://mavenproject2.mycompany.com/", "getKaryawanByIdResponse"));
        }else{
            responseIterator = responseBody.getChildElements(new QName("http://mavenproject2.mycompany.com/", "getKaryawanListResponse"));
        }
        
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
