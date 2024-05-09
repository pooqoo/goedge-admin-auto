FROM --platform=linux/amd64 alpine:latest
LABEL maintainer="vpsss@xiumail.com"
ENV TZ "Asia/Shanghai"
ENV VERSION 1.3.8
ENV ROOT_DIR /usr/local/goedge
ENV TAR_FILE edge-admin-linux-amd64-plus-v${VERSION}.zip

# remote official repository
ENV TAR_URL "https://dl.goedge.cn/edge/v${VERSION}/edge-admin-linux-amd64-plus-v${VERSION}.zip"

RUN apk add --no-cache tzdata

RUN apk add wget
RUN mkdir ${ROOT_DIR}; \
	cd ${ROOT_DIR}; \
	wget ${TAR_URL} -O ${TAR_FILE}; \
	apk add unzip; \
	unzip ${TAR_FILE}; \
	rm -f ${TAR_FILE}

RUN echo -e "#!/usr/bin/env sh\n\n/usr/local/goedge/edge-admin/bin/edge-admin\n" > ${ROOT_DIR}/run.sh; \
    chmod u+x ${ROOT_DIR}/run.sh

EXPOSE 7788
EXPOSE 8001

ENTRYPOINT [ "/usr/local/goedge/run.sh" ]
