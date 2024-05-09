FROM --platform=linux/amd64 alpine:latest
LABEL maintainer="vpsss@xiumail.com"
ENV TZ "Asia/Shanghai"

ARG VERSION
ENV VERSION ${VERSION}
ENV ROOT_DIR /usr/local/goedge
ENV TAR_FILE edge-admin-linux-amd64-plus-${VERSION}.zip

# remote official repository
ENV TAR_URL "https://dl.goedge.cn/edge/${VERSION}/edge-admin-linux-amd64-plus-${VERSION}.zip"

RUN apk add --no-cache tzdata wget unzip
RUN mkdir ${ROOT_DIR}; \
    cd ${ROOT_DIR}; \
    wget ${TAR_URL} -O ${TAR_FILE}; \
    unzip ${TAR_FILE}; \
    rm -f ${TAR_FILE}

RUN echo -e "#!/usr/bin/env sh\n\n/usr/local/goedge/edge-admin/bin/edge-admin\n" > ${ROOT_DIR}/run.sh; \
    chmod u+x ${ROOT_DIR}/run.sh

EXPOSE 7788 8001

ENTRYPOINT ["/usr/local/goedge/run.sh"]
