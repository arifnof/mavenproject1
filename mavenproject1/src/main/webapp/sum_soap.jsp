<%-- 
    Document   : sum_soap
    Created on : Aug 22, 2024, 11:21:36?AM
    Author     : arnof
--%>

<%@page import="Helper.*"%>
<%@ page import="jakarta.xml.soap.*" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.net.URL" %>

<!DOCTYPE html>
<html>
<head>
    <title>Consume SOAP Web Service - Calculator Add</title>
</head>
<body>
    <h2>Consume SOAP Web Service - Calculator Add</h2>

    <%
    try {
        // Membuat SOAP Connection
        SOAPConnectionFactory soapConnFactory = SOAPConnectionFactory.newInstance();
        SOAPConnection soapConnection = soapConnFactory.createConnection();

        // URL dari Web Service
        URL endpoint = new URL("http://www.dneonline.com/calculator.asmx");

        // Membuat pesan SOAP
        MessageFactory messageFactory = MessageFactory.newInstance();
        SOAPMessage soapMessage = messageFactory.createMessage();
        SOAPPart soapPart = soapMessage.getSOAPPart();

        // Mendapatkan envelope
        SOAPEnvelope envelope = soapPart.getEnvelope();
        envelope.addNamespaceDeclaration("tem", "http://tempuri.org/");

        // Menyusun SOAP body
        SOAPBody soapBody = envelope.getBody();
        SOAPElement soapBodyElem = soapBody.addChildElement("Add", "tem");
        SOAPElement soapBodyElem1 = soapBodyElem.addChildElement("intA", "tem");
        soapBodyElem1.addTextNode("10");  // Ganti dengan angka pertama
        SOAPElement soapBodyElem2 = soapBodyElem.addChildElement("intB", "tem");
        soapBodyElem2.addTextNode("25");  // Ganti dengan angka kedua

        // Simpan perubahan ke SOAP message
        soapMessage.saveChanges();

        // Menambahkan header SOAPAction
        MimeHeaders headers = soapMessage.getMimeHeaders();
        headers.addHeader("SOAPAction", "http://tempuri.org/Add");

        // Mengirimkan pesan SOAP ke server dan menerima respons
        SOAPMessage soapResponse = soapConnection.call(soapMessage, endpoint);

        // Konversi respons SOAP ke string
        ByteArrayOutputStream outStream = new ByteArrayOutputStream();
        soapResponse.writeTo(outStream);
        String soapResponseString = new String(outStream.toByteArray());

        String prettyPrintedXml = SoapHelper.getPrettyPrint(soapResponseString);

        
        // Menampilkan respons SOAP sebagai string (raw XML)
        out.println("<h3>SOAP Response:</h3>");
        out.println("<pre>" + prettyPrintedXml.replaceAll("<", "&lt;").replaceAll(">", "&gt;") + "</pre>");

        // Menampilkan hasil dari response XML
        SOAPBody responseBody = soapResponse.getSOAPBody();
        SOAPElement resultElement = (SOAPElement) responseBody.getElementsByTagName("AddResult").item(0);

        if (resultElement != null) {
            String result = resultElement.getValue();
            out.println("<h3>Result: " + result + "</h3>");
        } else {
            out.println("<p>Hasil tidak ditemukan dalam respons SOAP.</p>");
        }

        // Menutup koneksi
        soapConnection.close();

    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
    %>

</body>
</html>
