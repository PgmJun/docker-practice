# 🐳 도커 - Docker
컨테이너 기반 가상화를 통해 강력한 기능을 제공하는 오픈 소스 프로젝트

도커를 통한 빌드와 배포의 이점
- 기존 가상화 방식(VmWare 등)보다 자원 소모가 적다 = 빠르다
- 서버 환경에 영향을 거의 받지 않고 간편하다.
- 하나의 서버에 여러 프로그램을 설치하는 것에 최적화되어 있다.

<br>

## 🐋 Docker Hub

https://hub.docker.com/

Docker는 만들어진 이미지를 저장하고, 검색하고, 받아올 수 있는 저장소인 repository를 구성할 수 있다.

사용자는 자신이 만든 image를 repository에 올려 관리하거나 다른 사람들과 공유할 수 있다.


## 🐋 Docker 이미지 & 컨테이너

<hr>

## 📃 Docker 기본 명령어

### run
Docker 컨테이너를 실행하는 명령어

예시 코드
```
docker run --rm -d -p 8080:8080 \
-e MYSQL_ALLOW_EMPTY_PASSWORD=true \
-v /my/own/datadir:/var/lib/mysql \
--name mysql \
mysql:8.0
```
#### run
docker를 통해 이미지를 실행할 때 사용한다. (예시 코드에서 이미지명은 <strong>mysql:8.0</strong>)

#### --rm
도커의 컨테이너가 종료시 컨테이너를 삭제시키는 옵션이다.

#### -d
백그라운드에서 컨테이너를 실행하겠다는 뜻이다.

#### -p 
도커 컨테이너의 포트포워딩 설정이다.

구조는 <strong> [host port number]:[container port number]/[protocol] </strong> 형태로 구성되어 있다. <br>

예를 들어 `-p 8080:80/tcp` 설정을 하게 되면 호스트 시스템의 8080번 TCP포트로 유입되는 트래픽은 모두 도커의 80번 TCP 포트로 전달된다. <br>
protocol은 udp, tcp 등 다양하지만 설정을 하지 않으면 `default=tcp` 이다.

#### -e
도커 컨테이너의 환경 변수 설정 옵션이다.

예시 코드에선 MYSQL_ALLOW_EMPTY_PASSWORD 라는 환경변수에 true 라는 값을 입력하여 사용하였다. <br>
환경변수를 여러개 지정할 수 있는 `--env` <br>
환경변수가 입력되어 있는 파일을 통해 환경변수를 설정하는 `--env-file` <br>
옵션도 존재한다.

#### -v
볼륨을 설정한다.

구조는 <strong> [host path]:[mounting point path in container] </strong> 형태로 구성되어 있다. <br>
볼륨을 mount하여 host path에 영구적으로 데이터를 저장하기 때문에 container가 종료되어도 데이터가 삭제되지 않는다.

#### --name
컨테이너의 이름을 설정한다.

이름없이 생성된 컨테이너는 `ai4112490afajiz` 등과 같이 어떤 이미지가 컨테이너로 돌아가고 있는지 눈으로만 봐선 파악하기 어렵다. <br>
해당 옵션을 통해 컨테이너의 이름을 설정하여 위와 같은 문제를 해결할 수 있다.

#### Image
run하게 될 Image를 지정한다.

예시 코드에선 `mysql:8.0` 이라는 이미지를 선택하였는데 <br>
이미지의 이름은 search 명령어를 통해 서칭이 가능하다.

### search
도커 이미지를 찾는 명령어

예시 코드
```
docker search mysql
```

위 명령어처럼 찾고자하는 이미지를 검색하면<br>
찾고자하는 이미지의 공식 이미지를 포함하여 여려 Public 이미지들이 Stars 기준 내림차순으로 보여진다.

Stars는 Docker Hub를 사용하는 누군가가 해당 레퍼지토리를 즐겨찾기 한 것이다.


### pull
도커 이미지 다운로드 명령어

예시 코드
```
docker pull mysql:8.0
```

명령어의 구조는 <strong>docker pull [옵션] [이미지명]:[태그명]</strong> 이다.

해당 이미지의 모든 버전을 다운받고 싶다면 `-a 옵션`을 주면 된다.<br>

#### Docker Hub이 아닌 다른 곳에서 이미지 다운받기
pull 명령어는 기본적으로 Docker Hub에서 다운 받는 것을 default로 하는데
만약 다른 곳에서 다운받고 싶다면 이미지명 앞에 url을 입력하면 된다.

예시 코드
```
docker pull exampleUrl/mysql:8.0
```


### ps
도커 컨테이너 리스트를 반환해주는 명령어

예시 코드
```
docker ps [옵션]
```

만약 옵션 없이 그냥 입력하면 실행중인 컨테이너의 리스트만 반환한다.

#### -a
멈춘 컨테이너와 가동중인 컨테이너 모두 출력한다.

#### -f
리스트를 필터링하여 검색한다.

예시 코드
```
docker ps -f "name=app"
```

- name : 컨테이너 이름
- labal : run 등의 커맨드에서 붙인 라벨
- status : 컨테이너의 상태
- exit : 종료된 컨테이너의 종료 코드
- ancestor : 이미지를 공유받은 컨테이너 출력
- before or since : 설정 컨테이너를 기준으로 전에 or 이후에 만들어진 컨테이너 확인이 가능하다.

#### --latest
마지막으로 생성한 컨테이너를 출력한다.

#### -q
컨테이너 아이디만 출력한다.

#### -s
컨테이너 사이즈를 표기한다.

### logs
도커 컨테이너의 로그를 확인할 수 있는 명령어

예시 코드
```
docker logs [컨테이너명]
```

### images
다운받은 도커 이미지를 확인할 수 있는 명령어

예시 코드
```
docker images
```

### stop
컨테이너 ID를 입력해 docker를 중지할 수 있습니다. 여러 개를 중지하고 싶은 경우 컨테이너 ID를 띄어쓰기로 구별하면 됩니다. 

예시 코드
```
docker stop 88000ba1d2 100084dc12
```

docker stop은 <strong>Gracefully(우아)하게 작업을 중지</strong>시킵니다. 이 뜻은, 하고 있는 작업을 마친 후에 컨테이너를 중지한다는 것입니다.

반대로 kill 명령어는 작업을 기다리지 않고 종료시킵니다.

### rm
컨테이너 이름 또는 컨테이너ID로 컨테이너를 삭제하는 명령어

예시 코드
```
docker rm [컨테이너이름]

docker rm [컨테이너ID]
```

<hr>

## 🗂 Docker 볼륨(Volume)이란?
<strong> docker 컨테이너(container)에 쓰여진 데이터 </strong> 는 기본적으로 컨테이너가 삭제될 때 함께 사라지게 된다. <br>
이는 컨테이너를 시작한 후 만들어진 파일이 persistent filesystem에 저장된 것이 아니라 in-memory file system에 쓰이는 것이기 때문에 컨테이너 종료시 삭제되는 것이다. <br>
Docker를 사용하다보면 애플리케이션이 컨테이너의 생명 주기와 관계없이 데이터를 영속적으로 저장을 해야하며 <br>
뿐만 아니라 여러 개의 Docker 컨테이너가 하나의 저장 공간을 공유해서 데이터를 읽거나 써야하는 경우도 있다. <br>
이처럼 Docker 컨테이너의 생명 주기와 관계없이 데이터를 영속적으로 저장할 수 있도록 Docker는 두가지 옵션을 제공한다. <br>
그 중 하나가 Docker 볼륨(volume)이다. <br>

### 볼륨의 종류
<strong>익명 볼륨</strong> <br>
익명 볼륨이란 컨테이너가 존재하는 동안에만 실제로 존재하는 볼륨을 의미한다. <br>

<strong>명명 볼륨</strong> <br>
명명 볼륨이란 컨테이너가 컨테이너가 종료된 후에도 볼륨이 유지가 되는 것을 의미한다. <br>
