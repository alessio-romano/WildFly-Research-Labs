<%@ page import="java.net.*, java.io.*" %>
<%
String url = request.getParameter("url");
if (url == null || url.trim().isEmpty()) {
    response.setContentType("text/plain; charset=UTF-8");
    response.getWriter().println("Missing 'url' parameter");
    return;
}

url = url.trim();

if (!url.contains("://")) {
    url = "http://" + url;
}

try {
    URL target = new URL(url);
    HttpURLConnection conn = (HttpURLConnection) target.openConnection();

    response.setStatus(conn.getResponseCode());
    if (conn.getContentType() != null)
        response.setContentType(conn.getContentType());

    InputStream in = conn.getInputStream();
    OutputStream respOut = response.getOutputStream();

    byte[] buffer = new byte[4096];
    int bytesRead;
    while ((bytesRead = in.read(buffer)) != -1) {
        respOut.write(buffer, 0, bytesRead);
    }

    in.close();
    respOut.close();
    conn.disconnect();

} catch (Exception e) {
    response.setContentType("text/plain; charset=UTF-8");
    e.printStackTrace(response.getWriter());
}
%>
