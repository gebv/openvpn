FROM alpine:3.3

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories && \
    apk add --update openvpn iptables bash easy-rsa curl nano && \
    ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

VOLUME ["/etc/openvpn"]

EXPOSE 1194/udp 943/tcp

ENV TERM 			xterm
ENV OPENVPN 			/etc/openvpn
ENV EASYRSA 			/usr/share/easy-rsa
ENV EASYRSA_PKI 		$OPENVPN/pki
ENV EASYRSA_VARS_FILE 		$OPENVPN/vars

ENV EASYRSA_REQ_COUNTRY		"FR"
ENV EASYRSA_REQ_PROVINCE	"OpenVPN"
ENV EASYRSA_REQ_CITY		"OpenVPN"
ENV EASYRSA_REQ_ORG		"OpenVPN"
ENV EASYRSA_REQ_EMAIL		"OepnVPN"
ENV EASYRSA_REQ_OU		"OpenVPN"

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

WORKDIR /etc/openvpn
