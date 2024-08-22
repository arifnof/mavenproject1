/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Helper;

/**
 *
 * @author arnof
 */
import jakarta.xml.soap.SOAPElement;
import javax.xml.namespace.QName;
import java.util.Iterator;

public class SoapHelper {
    public static String getOptionalElement(SOAPElement element, String tagName) {
        Iterator<?> iterator = element.getChildElements(new QName(tagName));
        if (iterator.hasNext()) {
            return ((SOAPElement) iterator.next()).getTextContent();
        }
        return "";
    }
}