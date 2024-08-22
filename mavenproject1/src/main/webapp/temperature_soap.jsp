<%-- 
    Document   : temperature_soap
    Created on : Aug 22, 2024, 9:43:10 AM
    Author     : arnof
--%>

<%@page import="java.io.*"%>
<%@page import="jakarta.xml.soap.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            try {

                SOAPConnectionFactory soapConFactory = SOAPConnectionFactory.newInstance();
                SOAPConnection soapCon = soapConFactory.createConnection();

                MessageFactory messageFactory = MessageFactory.newInstance();
                SOAPMessage soapMessage = messageFactory.createMessage();
                SOAPPart soapPart = soapMessage.getSOAPPart();

                SOAPEnvelope envelope = soapPart.getEnvelope();
                envelope.addNamespaceDeclaration("tem", "https://www.w3schools.com/xml/");

                SOAPBody soapBody = envelope.getBody();
                SOAPElement soapBodyElem = soapBody.addChildElement("CelsiusToFahrenheit", "tem");
                SOAPElement soapBodyElem1 = soapBodyElem.addChildElement("Celsius", "tem");
                soapBodyElem1.addTextNode("100");

                soapMessage.saveChanges();
                
                MimeHeaders headers = soapMessage.getMimeHeaders();
                headers.addHeader("SOAPAction", "https://www.w3schools.com/xml/CelsiusToFahrenheit");
                
                SOAPMessage soapResponse = soapCon.call(soapMessage, "https://www.w3schools.com/xml/tempconvert.asmx");

                ByteArrayOutputStream responseOutputStream = new ByteArrayOutputStream();
                soapResponse.writeTo(responseOutputStream);
                String result = new String(responseOutputStream.toByteArray());

                out.print("<pre>"+ result +"</pre>");
                soapCon.close();
            } catch (Exception e){
                out.print("Error : " + e.getMessage());
            }
            
        %>
    </body>
</html>
