research_lab.war is the web application only containing an arbitrary file upload vulnerability, meaning that its META-INF/jboss-permissions.xml file is not misconfigured, but just allows file uploads to happen.

misconfigured_lab.war is the very same web application, containing several misconfigurations inside the META-INF/jboss-permissions.xml file.

research_lab -> http://localhost:8080/research_lab misconfigured_lab -> http://localhost:8080/misconfigured_lab

all the JSPs (in the JSPs folder) shown in the article are already uploaded inside the uploads folder -> lista JSPS?
