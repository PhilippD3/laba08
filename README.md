## Homework  

Первым делом я установил docker на свой компьютер [гайд на установку с сайте](https://help.reg.ru/support/servery-vps/oblachnyye-servery/ustanovka-programmnogo-obespecheniya/kak-ustanovit-docker-na-ubuntu#1) и обновил драйвера.  
Далее я добавил **Docherfile** со следущим содержимым
```bash
FROM ubuntu:18.04
RUN apt update
RUN apt  install -yy gcc g++ cmake
COPY . /solver_application
WORKDIR /solver_application
RUN cmake -H. -B_build -DDCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install
RUN cmake --build _build
RUN cmake --build _build --target install
ENV LOG_PATH /home/logs/log.txt
VOLUME /home/logs
WORKDIR /solver_application/_build/
ENTRYPOINT ./equation
```
И обновил yml файл
```cpp
name: Actions
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs: 
 build_Linux:

  runs-on: ubuntu-latest

  steps:
  - uses: actions/checkout@v4

  - name: Build the Docker
    run: docker build -t logger .

  - name: Put logs
    run: docker run -v "$(pwd)/logs/:/home/logs/" logger

```
Далее я проверил работоспособность на локальной машине
```bash
docker build -t logger .
docker run -it -v "$(pwd)/logs/:/home/logs/" logger
```
Получил сначала:
```bash
[+] Building 13.6s (14/14) FINISHED                              docker:default
 => [internal] load build definition from Dockerfile                       0.1s
 => => transferring dockerfile: 419B                                       0.0s
 => [internal] load metadata for docker.io/library/ubuntu:18.04            1.7s
 => [internal] load .dockerignore                                          0.1s
 => => transferring context: 2B                                            0.0s
 => [1/9] FROM docker.io/library/ubuntu:18.04@sha256:152dc042452c496007f0  0.0s
 => [internal] load build context                                          0.1s
 => => transferring context: 3.88kB                                        0.0s
 => CACHED [2/9] RUN apt update                                            0.0s
 => CACHED [3/9] RUN apt  install -yy gcc g++ cmake                        0.0s
 => [4/9] COPY . /solver_application                                       1.4s
 => [5/9] WORKDIR /solver_application                                      0.4s
 => [6/9] RUN cmake -H. -B_build -DDCMAKE_BUILD_TYPE=Release -DCMAKE_INST  2.9s
 => [7/9] RUN cmake --build _build                                         2.9s 
 => [8/9] RUN cmake --build _build --target install                        1.2s 
 => [9/9] WORKDIR /solver_application/_build/                              0.4s 
 => exporting to image                                                     1.3s 
 => => exporting layers                                                    1.1s 
 => => writing image sha256:6b4274e9833396129e6b48e84639bc9dc2888a9df4ae3  0.0s 
 => => naming to docker.io/library/logger                                  0.0s 
```
а далее
```bash
-------------------------
x1 = -1.000000
-------------------------
-------------------------
x2 = -1.000000
-------------------------
```
Чтобы у githubActions были все необходимые права, изменил настройки на возможность записи.
