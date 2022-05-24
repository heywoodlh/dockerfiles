FROM alpine as build

RUN apk add --no-cache ca-certificates git make gcc libc-dev g++ autoconf

# Compile ncrack
RUN git clone https://github.com/nmap/ncrack /opt/ncrack &&\
	cd /opt/ncrack &&\
	./configure &&\
	make &&\
	make install

# Clone tsunami-security-scanner-plugins repo
RUN mkdir -p /usr/tsunami/repos && cd /usr/tsunami/repos &&\
	git clone --depth 1 "https://github.com/google/tsunami-security-scanner-plugins"

# Clone tsunami repo
RUN mkdir -p /usr/repos/ &&\
	git clone https://github.com/google/tsunami-security-scanner /usr/repos/tsunami-security-scanner


FROM alpine
LABEL maintainer=heywoodlh


# Install dependencies
RUN apk add --no-cache nmap nmap-scripts openjdk8

# Install ncrack
COPY --from=build /usr/local/bin/ncrack /usr/local/bin/ncrack
COPY --from=build /usr/local/share/ncrack /usr/local/share/ncrack

# Clone the plugins repo

# Build plugins
COPY --from=build /usr/tsunami /usr/tsunami
RUN apk --no-cache add bash coreutils &&\
	cd /usr/tsunami/repos/tsunami-security-scanner-plugins/google &&\
	chmod +x build_all.sh &&\ 
	./build_all.sh

RUN mkdir -p /usr/tsunami/plugins &&\
	cp /usr/tsunami/repos/tsunami-security-scanner-plugins/google/build/plugins/*.jar /usr/tsunami/plugins

# Compile the Tsunami scanner

## Install glibc
ENV ALPINE_PKG_GLIBC_VERSION="2.32-r0"

ADD https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub /etc/apk/keys/sgerrand.rsa.pub
ADD https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$ALPINE_PKG_GLIBC_VERSION/glibc-$ALPINE_PKG_GLIBC_VERSION.apk /tmp/glibc.apk
RUN apk --no-cache add /tmp/glibc.apk &&\
	rm /etc/apk/keys/sgerrand.rsa.pub /tmp/glibc.apk

COPY --from=build /usr/repos/tsunami-security-scanner /usr/repos/tsunami-security-scanner
RUN cd /usr/repos/tsunami-security-scanner &&\
	./gradlew shadowJar &&\
	cp $(find "./" -name 'tsunami-main-*-cli.jar') /usr/tsunami/tsunami.jar &&\
	cp ./tsunami.yaml /usr/tsunami

WORKDIR /usr/tsunami

RUN mkdir -p /usr/tsunami/logs

ENTRYPOINT ["java", "-cp", "/usr/tsunami/tsunami.jar:/usr/tsunami/plugins/*", "-Dtsunami-config.location=/usr/tsunami/tsunami.yaml", "com.google.tsunami.main.cli.TsunamiCli"]
