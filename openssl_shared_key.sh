openssl genpkey -algorithm RSA -out key1.private_key
openssl rsa -aes256 -in key1.private_key -out key2.private_key
openssl rsa -in key1.private_key -pubout -out key1.public_key
openssl rsa -in key2.private_key -pubout -out key2.public_key
echo "Secret message" | openssl rsautl -encrypt -pubin -inkey key1.public_key -out encrypted_data.bin
openssl rsautl -decrypt -inkey key1.private_key -in encrypted_data.bin
openssl rsautl -decrypt -inkey key2.private_key -in encrypted_data.bin
echo "Secret message" | openssl rsautl -encrypt -pubin -inkey key2.public_key -out encrypted_data_2.bin
openssl rsautl -decrypt -inkey key1.private_key -in encrypted_data.bin
openssl rsautl -decrypt -inkey key2.private_key -in encrypted_data.bin
