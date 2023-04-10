# Этот скрипт демонстрирует пример использования шифрования RSA для защиты данных. Сначала он генерирует пару ключей RSA: приватный ключ (key1.private_key) и открытый ключ (key1.public_key). Затем он шифрует сообщение "Secret message" с помощью открытого ключа и сохраняет зашифрованные данные в файл encrypted_data.bin. Далее он дешифрует зашифрованные данные с помощью приватного ключа, сохраненного в файле key1.private_key, а затем с помощью другого приватного ключа, который был сгенерирован из первого (зашифрованный приватный ключ был сохранен в файле key2.private_key). Это демонстрирует, что данные могут быть расшифрованы с использованием любого из приватных ключей, сгенерированных из первоначального приватного ключа.
# Затем скрипт повторяет этот процесс для другого открытого ключа, который был сгенерирован из того же приватного ключа. Он шифрует сообщение "Secret message" с помощью этого ключа и сохраняет зашифрованные данные в файл encrypted_data_2.bin. Затем он дешифрует зашифрованные данные с помощью приватного ключа, сохраненного в файле key1.private_key, а затем с помощью другого зашифрованного приватного ключа (key2.private_key), который был сгенерирован из первоначального приватного ключа.
# В результате этого скрипта демонстрируется, как можно использовать шифрование RSA для защиты данных, а также как можно генерировать защищенные ключи RSA, которые могут использоваться для расшифровки данных.

openssl genpkey -algorithm RSA -out key1.private_key
openssl rsa -aes256 -in key1.private_key -out key2.private_key

openssl rsa -in key1.private_key -pubout -out key1.public_key
openssl rsa -in key2.private_key -pubout -out key2.public_key

echo "Secret message" | openssl rsautl -encrypt -pubin -inkey key1.public_key -out encrypted_data.bin
openssl rsautl -decrypt -inkey key1.private_key -in encrypted_data.bin
openssl rsautl -decrypt -inkey key2.private_key -in encrypted_data.bin

echo "Secret message2" | openssl rsautl -encrypt -pubin -inkey key2.public_key -out encrypted_data2.bin
openssl rsautl -decrypt -inkey key1.private_key -in encrypted_data2.bin
openssl rsautl -decrypt -inkey key2.private_key -in encrypted_data2.bin
