ARG BASE_IMAGE
FROM ${BASE_IMAGE:-debian:bookworm-slim} AS BASE

# https://www.signalyst.eu/bins/naa/linux/bookworm/networkaudiod_5.0.0-59_armhf.deb
# https://www.signalyst.eu/bins/naa/linux/bookworm/networkaudiod_5.0.0-59_arm64.deb
# https://www.signalyst.eu/bins/naa/linux/bookworm/networkaudiod_5.0.0-59_amd64.deb

RUN mkdir -p /app/bin

COPY app/bin/install-pkg.sh /app/bin
RUN chmod u+x /app/bin/install-pkg.sh
RUN /app/bin/install-pkg.sh
RUN rm /app/bin/install-pkg.sh

RUN mkdir -p /app/release
WORKDIR /app/release

ARG NAA_VERSION=5.0.0-59
ARG FORCE_ARCH=

COPY app/bin/download.sh /app/bin
RUN chmod u+x /app/bin/download.sh
RUN /app/bin/download.sh
RUN rm /app/bin/download.sh

COPY app/bin/post-download.sh /app/bin
RUN chmod u+x /app/bin/post-download.sh
RUN /app/bin/post-download.sh
RUN rm /app/bin/post-download.sh

COPY app/bin/write-config.sh /app/bin
RUN chmod u+x /app/bin/write-config.sh
RUN /app/bin/write-config.sh
RUN rm /app/bin/write-config.sh

WORKDIR /app/bin

COPY app/bin/cleanup.sh /app/bin
RUN chmod u+x /app/bin/cleanup.sh
RUN /app/bin/cleanup.sh
RUN rm /app/bin/cleanup.sh

COPY app/bin/run.sh /app/bin
RUN chmod +x /app/bin/run.sh
WORKDIR /app/bin

ENV NAA_NAME ""

ENTRYPOINT [ "/app/bin/run.sh" ]