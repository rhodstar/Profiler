rm -rf certs/
rm -rf private/

mkdir certs
mkdir private

# 1. Generate CA's private key and self-signed certificate
openssl req -x509 \
  -nodes \
  -newkey rsa:2048 \
  -days 365 \
  -keyout "private/${1}".key \
  -out "certs/${1}".crt \
  -subj "/C=MX/ST=Mexico City/L=Mexico/O=TSII/OU=Education/CN=${1}"

openssl dhparam -out certs/"${1}".pem 2048

cp -R /etc/pki/tls/certs/* certs/

chown -R root:root certs/*