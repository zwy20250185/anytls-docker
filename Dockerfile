FROM alpine:3.22
LABEL maintainer="Zeng <zerozwy@gmail.com>"
ARG VERSION=0.0.8
ENV PASS=your_password
ENV PORT=8443
EXPOSE 8443
RUN apk add --no-cache \
        curl \
        unzip \
        && curl -L -o anytls.zip "https://github.com/anytls/anytls-go/releases/download/v${VERSION}/anytls_${VERSION}_linux_amd64.zip" \
        && unzip anytls.zip -x "anytls-client" "readme.md" -d /usr/local/bin/ \
        && chmod +x /usr/local/bin/anytls-server
RUN rm -f anytls.zip \
        && apk del --no-cache curl unzip \
        && rm -rf /var/cache/apk/*
ENTRYPOINT [ "/bin/sh", "-c", "anytls-server -l 0.0.0.0:${PORT} -p ${PASS}" ]
