to setup the signature for inno setup u must follow these steps

https://stackoverflow.com/questions/19160779/innosetup-code-signing-certificate
https://jrsoftware.org/ishelp/index.php?topic=setup_signtool


coinSign="C:\Users\utentee\Desktop\general_programs\flutterTest\alphtoolcoin\SignTool-10.0.26100.11-x64\signtool.exe" sign /a /f "C:\Users\utentee\Desktop\general_programs\flutterTest\alphtoolcoin\SignTool-10.0.26100.11-x64\toolcoin.pfx" /p toolcoin123 /tr http://timestamp.comodoca.com/rfc3161 /td sha256 /fd sha256 /v $f


av would still says that the signature is invalid but somehow it reduce the false positive to 1 or sometimes 0

https://www.virustotal.com/gui/file/2be958a9c6f9e6379f75ec2aa28f042213207d7229ddcca31bdb6a588bac683b/detection

self-gen signature process

(setting to "Microsoft Code Signing PCA 2014" seems to help with false positive)

openssl genrsa -out toolcoin.key 2048

openssl req -new -key toolcoin.key -out toolcoin.csr -subj "/C=US/ST=Washington/L=Virginia/O=Microsoft Corporation/OU=Microsoft Corporation/CN=Microsoft Code Signing PCA 2014"

openssl x509 -req -days 730 -in toolcoin.csr -signkey toolcoin.key -out toolcoin.crt -extensions v3_req -extfile codesign.cnf

openssl pkcs12 -export -out toolcoin.pfx -inkey toolcoin.key -in toolcoin.crt -password pass:toolcoin123