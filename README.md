# openvpn

```
docker run --name ovpn-data -v /etc/openvpn busybox

docker run --volumes-from ovpn-data --rm ovpn-srv genconfig
docker run --volumes-from ovpn-data --rm -it ovpn-srv initpki
docker run --volumes-from ovpn-data -d -p 1194:1194/udp -p 943:943/tcp --cap-add=NET_ADMIN ovpn-srv run

docker run --volumes-from ovpn-data --rm -it ovpn-srv easyrsa build-client-full egor-imac nopass
docker run --volumes-from ovpn-data --rm ovpn-srv openssl rsa -in pki/private/egor-imac.key -out pki/private/egor-imac_rsa.key
docker run --volumes-from ovpn-data --rm -it ovpn-srv easyrsa build-client-full egor-iphone nopass
docker run --volumes-from ovpn-data --rm ovpn-srv openssl rsa -in pki/private/egor-iphone.key -out pki/private/egor-iphone_rsa.key

docker run --volumes-from ovpn-data --rm -it ovpn-srv openssl \
	pkcs12 -export -in pki/issued/egor-iphone.crt \
	-inkey pki/private/egor-iphone_rsa.key \
	-certfile pki/ca.crt \
	-name ios \
	-out egor-iphone.p12
docker run --volumes-from ovpn-data --rm ovpn-srv getclient egor-imac > egor-imac.ovpn

docker run --volumes-from ovpn-data --rm ovpn-srv cat egor-iphone.p12 > egor-iphone.p12
docker run --volumes-from ovpn-data --rm ovpn-srv getclient egor-iphone > egor-iphone.ovpn
docker run --volumes-from ovpn-data --rm ovpn-srv getclient egor-imac > egor-imac.ovpn
```
