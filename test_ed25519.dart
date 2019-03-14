import 'package:tweetnacl/tweetnacl.dart';
import "package:test/test.dart";
import "dart:convert";
import 'dart:typed_data';

final String SECRET_KEY = "bd18c434476ed0e6e8479235b93a20b22db06b28b20148f24b44c1d50816e90ab2d286e6e2b37269c13160affba4498925ad103b5f2c196ad9f83dde5856b303";
final String PUBLIC_KEY = "b2d286e6e2b37269c13160affba4498925ad103b5f2c196ad9f83dde5856b303";

void main(){
  test('digital signing using ed25519 algo', () {
      List<int> sk = TweetNaclFast.hexDecode(SECRET_KEY);
    KeyPair kp = Signature.keyPair_fromSecretKey(sk);

    print("secretKey: \"${TweetNaclFast.hexEncodeToString(kp.secretKey)}\"");
    print("publicKey: \"${TweetNaclFast.hexEncodeToString(kp.publicKey)}\"");

    Uint8List bytes = utf8.encode("abc");
    
    Signature s1 = Signature(kp.publicKey, kp.secretKey);
    Uint8List signature = s1.detached(bytes);
    print("signature: \"${TweetNaclFast.hexEncodeToString(signature)}\"");

    Signature s2 = Signature(kp.publicKey, null);
    bool result = s2.detached_verify(bytes,  signature);
    expect(result, true);
    print("verify: \"${result}\"");
  });
}
