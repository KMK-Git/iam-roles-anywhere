# openssl commands are adapted from https://jimmydqv.com/iam-anywhere/

# The following files are required:
# - certificate_authority.conf Configuration for CA certificate
# - client.conf Configuration for client CSR
# - client_v3.ext Extensions file for CSR
# See repository code for samples

# Generate private key for CA
openssl genrsa -out certificate_authority_private.key 4096
# Generate certificate for CA
openssl req -new -x509 -days 365 -config certificate_authority.conf -key certificate_authority_private.key -out certificate_authority_cert.pem -extensions v3_ca
# Show certificate for CA
openssl x509 -text -noout -in certificate_authority_cert.pem

# Generate private key for client
openssl genrsa -out client_private.key 4096
# Generate Certificate Signing Request
openssl req -new -config client.conf -key client_private.key -out client.csr
# Show CSR
openssl req -text -in client.csr
# Generate certificate signed using CA
openssl x509 -req -in client.csr -CA certificate_authority_cert.pem -CAkey certificate_authority_private.key -set_serial 01 -out client_cert.pem -days 365 -sha256 -extfile client_v3.ext
# Show certificate for client
openssl x509 -text -noout -in client_cert.pem
