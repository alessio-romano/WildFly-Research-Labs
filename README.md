# WildFly Research Labs

This repository provides two example standalone applications running on WildFly 37 shown in my research blog post.</br>
The lab is intended for learning, testing and research in a controlled environments.

## Run Instructions

Clone the repository and move inside it</br>
```git clone https://github.com/alessio-romano/WildFly-Research-Labs.git && cd /WildFly-Research_Labs```

Build the docker instance</br>
```sudo docker build --no-cache -t wildfly37-java25 .```

Run the Instance and allow accessing the web application from local port 8080</br>
```sudo docker run -p 8080:8080 wildfly37-java25```

The Dockerfile will automatically download the war packages meant for the exercise, which you will be able to access at</br>
```localhost:8080/research_lab/```</br>
```localhost:8080/misconfigured_lab/```
