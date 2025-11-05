<%@ page import="java.util.*" %>
<%
    StringBuilder output = new StringBuilder();

    try {
        // Lettura variabili d'ambiente
        Map<String, String> env = System.getenv();
        output.append("=== Environment Variables ===\n");
        for (String key : env.keySet()) {
            output.append(key).append(" = ").append(env.get(key)).append("\n");
        }
    } catch (Exception e) {
        output.append("Exception reading environment variables: ").append(e.toString()).append("\n");
    }

    output.append("\n");

    try {
        Properties props = System.getProperties();
        output.append("=== System Properties ===\n");
        for (String key : props.stringPropertyNames()) {
            output.append(key).append(" = ").append(props.getProperty(key)).append("\n");
        }
    } catch (Exception e) {
        output.append("Exception reading system properties: ").append(e.toString()).append("\n");
    }
%>

<pre><%= output.toString() %></pre>
