#! /bin/bash -e
# make ca
openssl genrsa -aes256 -out ca-key.pem 4096
openssl req -new -x509 -days 3650 -key ca-key.pem -sha256 -out ca.pem

# make server
openssl genrsa -out server-key.pem 4096
openssl req -sha256 -new -key server-key.pem -out server.csr
openssl x509 -req -days 3650 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server.pem

# make client
openssl genrsa -out key.pem 4096
openssl req -new -key key.pem -out client.csr

echo extendedKeyUsage = clientAuth > extfile.cnf
openssl x509 -req -days 3650 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out cert.pem -extfile extfile.cnf
