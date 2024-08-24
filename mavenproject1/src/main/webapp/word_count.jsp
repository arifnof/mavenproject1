<%@ page import="java.util.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Word Count</title>
</head>
<body>
    <h1>Word Count Application</h1>
    <form method="post">
        <label for="inputString">Input a string:</label><br>
        <textarea name="inputString" id="inputString" rows="5" cols="50"></textarea><br/><br/>
        <input type="submit" value="Submit">
    </form>

    <%
        // Get input from user
        String inputString = request.getParameter("inputString");
        
        if (inputString != null && !inputString.trim().isEmpty()) {
            // Normalize to lower case (case insensitive)
            inputString = inputString.toLowerCase();
            
            // Define a regex pattern to match words (ignoring symbols)
            Pattern pattern = Pattern.compile("\\b[a-zA-Z]+\\b");
            Matcher matcher = pattern.matcher(inputString);
            
            // Store word counts in a map
            Map<String, Integer> wordCountMap = new HashMap<>();
            
            while (matcher.find()) {
                String word = matcher.group();
                wordCountMap.put(word, wordCountMap.getOrDefault(word, 0) + 1);
            }

            // Display the results in a table
            out.println("<h2>Word Count Results</h2>");
            out.println("<table border='1' cellpadding='5' cellspacing='0'>");
            out.println("<tr><th>Word</th><th>Count</th></tr>");

            for (Map.Entry<String, Integer> entry : wordCountMap.entrySet()) {
                out.println("<tr><td>" + entry.getKey() + "</td><td>" + entry.getValue() + "</td></tr>");
            }

            out.println("</table>");
        }
    %>
</body>
</html>
