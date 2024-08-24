/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Helper;

/**
 *
 * @author arnof
 */
import org.xml.sax.InputSource;
import jakarta.xml.soap.*;
import java.util.*;
import java.io.*;
import java.net.URL;
import javax.xml.namespace.QName;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.Transformer;
import org.w3c.dom.Document;

public class SoapHelper {
    public static String getOptionalElement(SOAPElement element, String tagName) {
        Iterator<?> iterator = element.getChildElements(new QName(tagName));
        if (iterator.hasNext()) {
            return ((SOAPElement) iterator.next()).getTextContent();
        }
        return "";
    }
    
    public static String getPrettyPrint(String soapResponse){
        
        String prettyPrintedXml = "";
        
        try {
            // Mengubah string XML menjadi DOM Document
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            Document doc = factory.newDocumentBuilder().parse(new InputSource(new StringReader(soapResponse)));

            // Membuat Transformer untuk melakukan pretty print
            Transformer transformer = TransformerFactory.newInstance().newTransformer();
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");
            transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");

            // Mengonversi DOM Document kembali menjadi string dengan format yang rapi
            StringWriter writer = new StringWriter();
            transformer.transform(new DOMSource(doc), new StreamResult(writer));

            // Mendapatkan string XML yang sudah diformat
            prettyPrintedXml = writer.toString();

            // Menampilkan string XML dalam format HTML untuk menjaga tampilan
            // out.println("<h3>Pretty Print XML:</h3>");
            // out.println("<pre>" + prettyPrintedXml.replaceAll("<", "&lt;").replaceAll(">", "&gt;") + "</pre>");
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return prettyPrintedXml;
    }
}