# Developer Workstation

## 1. 프로젝트 소개

개발 환경을 직접 구성하면서 터미널 기본 명령어, Docker 컨테이너 실행, 웹 서버 구축, 바인드 마운트와 Docker Volume의 동작을 실습한 프로젝트입니다.

## 2. 개발 환경

- OS: Windows
- Shell: Windows PowerShell 5.1
- Terminal: VS Code Integrated Terminal
- Docker: 29.9.3
- Git: 2.56.0.windows.4
- Editor: Visual Studio Code

## 3. 수행 항목

- [x] Docker Desktop 설치 및 실행
- [x] Docker 기본 정보 확인
- [x] `hello-world` 컨테이너 실행
- [x] Ubuntu 컨테이너 실행 및 명령어 실습
- [x] Docker 이미지 및 컨테이너 목록 확인
- [x] Docker 컨테이너 리소스 사용량 확인
- [x] Dockerfile 작성
- [x] Nginx 기반 웹 이미지 빌드
- [x] 컨테이너 포트 매핑
- [x] 브라우저에서 웹 서버 접속 확인
- [x] Bind Mount 적용 및 파일 변경 반영 확인
- [x] Docker Volume 생성 및 데이터 영속성 확인
- [x] 터미널 파일 생성·복사·이동·삭제 실습
- [x] 파일 및 디렉터리 권한 변경
- [x] Git 사용자 정보 설정
- [x] GitHub 저장소 연결

## 4. Docker 기본 명령어

Docker 버전을 확인했습니다.

```bash
docker --version
```

결과:

```text
Docker version 29.9.3, build 5457199
```

Docker 환경 정보와 이미지 및 컨테이너 상태도 확인했습니다.

```bash
docker info
docker images
docker ps
docker ps -a
docker stats --no-stream
```

### Hello World

```bash
docker run hello-world
```

`Hello from Docker!` 메시지가 출력되는 것을 확인했습니다.

### Ubuntu 컨테이너

```bash
docker run -it ubuntu bash
ls
echo "Hello from Ubuntu container!"
```

Ubuntu 컨테이너 내부에 직접 접속하여 기본 명령어가 정상적으로 실행되는 것을 확인했습니다.

## 5. Dockerfile 웹 서버

Nginx Alpine 이미지를 기반으로 간단한 웹 서버를 구성했습니다.

Dockerfile:

```dockerfile
FROM nginx:alpine

LABEL org.opencontainers.image.title="developer-workstation"

COPY site/ /usr/share/nginx/html/
```

이미지 빌드:

```bash
docker build -t my-workstation-web:1.0 .
```

컨테이너 실행 및 포트 매핑:

```bash
docker run -d -p 8080:80 --name my-web my-workstation-web:1.0
```

브라우저에서 아래 주소로 접속하여 직접 만든 페이지가 표시되는 것을 확인했습니다.

```text
http://localhost:8080
```

호스트의 `8080` 포트와 컨테이너의 `80` 포트를 연결했습니다.

## 6. Bind Mount

호스트의 `site` 디렉터리를 Nginx 웹 디렉터리에 연결했습니다.

`index.html`을 수정한 뒤 이미지를 다시 빌드하지 않고 브라우저를 새로고침했을 때 변경된 내용이 바로 반영되는 것을 확인했습니다.

변경 후 표시 문구:

```text
Bind mount update successful!
```

이를 통해 호스트 파일의 변경 사항이 컨테이너에 바로 반영되는 것을 확인했습니다.

## 7. Docker Volume 영속성

Docker Volume을 생성했습니다.

```bash
docker volume create mydata
```

Volume을 연결한 컨테이너를 실행하고 파일을 생성했습니다.

```bash
docker run -d --name vol-test -v mydata:/data ubuntu sleep 300
docker exec vol-test bash -c "echo hello-volume > /data/hello.txt"
docker exec vol-test cat /data/hello.txt
```

출력:

```text
hello-volume
```

기존 컨테이너를 삭제했습니다.

```bash
docker rm -f vol-test
```

같은 Volume을 새로운 컨테이너에 연결했습니다.

```bash
docker run -d --name vol-test2 -v mydata:/data ubuntu sleep 300
docker exec vol-test2 cat /data/hello.txt
```

다시 다음 내용이 출력되었습니다.

```text
hello-volume
```

컨테이너를 삭제하고 새로 생성해도 Volume 내부 데이터가 유지되는 것을 확인했습니다.

## 8. 터미널 기본 명령어

Ubuntu 컨테이너에서 기본 파일 및 디렉터리 명령어를 실습했습니다.

```bash
mkdir -p /workspace/practice
cd /workspace/practice
pwd

touch sample.txt empty.txt
echo "hello" > sample.txt
cat sample.txt
ls -la

cp sample.txt copy.txt
mv copy.txt renamed.txt
rm renamed.txt
```

### 절대 경로와 상대 경로

`/workspace/practice`처럼 `/`부터 시작하는 경로는 절대 경로이며, 현재 위치를 기준으로 파일이나 디렉터리를 지정하는 방식은 상대 경로입니다.

## 9. 파일 및 디렉터리 권한

변경 전 권한:

```bash
chmod 600 permission.txt
chmod 700 permission-dir
ls -ld permission.txt permission-dir
```

파일은 `600`, 디렉터리는 `700` 권한으로 설정했습니다.

변경 후:

```bash
chmod 644 permission.txt
chmod 755 permission-dir
ls -ld permission.txt permission-dir