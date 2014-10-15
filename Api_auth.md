# API Authentication using HMAC Hashing

Source http://websec.io/2013/02/14/API-Authentication-Public-Private-Hashes.html

HMAC means hash-based message authentication code''

## Generate a Secret HASH

Having openssl installed ...

    $secret = base64URL(openssl_random_pseudo_bytes(32));

... or without having it, just use a [RandomLib](https://github.com/ircmaxell/RandomLib)

## Client request

```
$userHash = '3441df0babc2a2dda551d7cd39fb235bc4e09cd1e4556bf261bb49188f548348';
$secret = 'e249c439ed7697df2a4b045d97d4b9b7e1854c3ff8dd668c779013653913572e';
$content    = json_encode(array(
    'test' => 'content'
));

$hash = hash_hmac('sha256', $content, $secret);

$headers = array(
    'X-Public: '.$userHash,
    'X-Hash: '.$hash
);

$ch = curl_init('http://test.localhost:8080/api-test/');
curl_setopt($ch,CURLOPT_HTTPHEADER,$headers);
curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
curl_setopt($ch,CURLOPT_POSTFIELDS,$content);

$result = curl_exec($ch);
curl_close($ch);

echo "RESULT\n======\n".print_r($result, true)."\n\n";
```
