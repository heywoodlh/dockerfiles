FROM golang:1.18beta1-alpine3.15

RUN export VERSION=$(go list -m -versions github.com/falzm/instafeed | awk '{print $(NF)}') \
	&& go install github.com/falzm/instafeed@${VERSION} \
	&& mkdir -p /app \
	&& echo ${VERSION} > /app/if-version.txt

VOLUME /root/.instafeed

ENTRYPOINT ["instafeed"] 
