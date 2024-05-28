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