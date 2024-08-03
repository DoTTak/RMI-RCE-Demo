FROM ubuntu:22.04

WORKDIR /src

# Install netcat
RUN apt-get update;apt-get install -y netcat-traditional
RUN echo 2 | update-alternatives --config nc

# # Install Java6
# COPY ./bin/jdk-6u29-linux-x64.bin jdk-6u29.bin
# RUN chmod +x jdk-6u29.bin
# RUN ./jdk-6u29.bin
# RUN mv ./jdk1.6.0_29 /usr/local
# RUN rm -rf jdk-6u29.bin
# # Set PATH 
# ENV JAVA_HOME /usr/local/jdk1.6.0_29
# ENV PATH $PATH:$JAVA_HOME/bin

# Install Java8
COPY ./bin/jdk-8u181-linux-x64.tar.gz jdk-8u181.tar.gz
RUN tar -xzf jdk-8u181.tar.gz
RUN mv ./jdk1.8.0_181 /usr/local
RUN rm -rf jdk-8u181.tar.gz
# Set PATH 
ENV JAVA_HOME /usr/local/jdk1.8.0_181
ENV PATH $PATH:$JAVA_HOME/bin

# Move Source
RUN mkdir build
COPY ./libs ./libs
COPY ./src ./src


# Build
RUN javac -d ./build -classpath libs/tomcat-embed-el-8.5.3.jar:libs/tomcat-catalina-8.5.3.jar ./src/RmiClient.java 
RUN javac -d ./build -classpath libs/tomcat-embed-el-8.5.3.jar:libs/tomcat-catalina-8.5.3.jar ./src/RmiServer.java 

# Keep...
CMD ["tail", "-f", "/dev/null"]
