<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*" %>
<%
    StringBuilder output = new StringBuilder();
    File file = new File("/etc/hosts");
    BufferedReader br = null;

    try {
        br = new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF-8"));
        String line;
        while ((line = br.readLine()) != null) {
            output.append(line).append("\n");
        }
    } catch (Exception e) {
        StringWriter sw = new StringWriter();
        e.printStackTrace(new PrintWriter(sw));
        output.append(sw.toString());
    } finally {
        try { if (br != null) br.close(); } catch (IOException ignore) {}
    }
    String safe = output.toString()
        .replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;");
%>
<!doctype html>
<html>
<head>
  <meta charset="utf-8"/>
  <title>Read /etc/hosts</title>
</head>
<body>
  <pre><%= safe %></pre>
</body>
</html>
