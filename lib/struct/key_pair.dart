import 'dart:typed_data';
import 'dart:convert';
import 'package:near_jsonrpc_client/struct/transaction/transactions.dart';
import 'package:tweetnacl/tweetnacl.dart' as tweetnacl;

class Signature {
  Uint8List signature;
  PublicKey publicKey;

  Signature(this.signature, this.publicKey);
}

/**
 * PublicKey representation that has type and bytes of the key.
 */
class PublicKey {
  final String keyType = ed25519;
  final Uint8List data;

  PublicKey(this.data);

  PublicKey from(String value) {
    return PublicKey.fromString(value);
  }

  static PublicKey fromString(String encodedKey) {
    var parts = encodedKey.split(':');
    if (parts.length == 1) {
      var list = parts[0].codeUnits;
      var uintList = Uint8List.fromList(list);
      return PublicKey(uintList);
    } else {
      throw Exception(
          'Invalid encoded key format, must be <curve>:<encoded key>');
    }
  }

  bool verify(Uint8List message, Uint8List signature) {
    switch (this.keyType) {
      case ed25519:
      //return nacl.sign.detached.verify(message, signature, data);
      default:
        throw Exception('Unknown key type');
    }
  }
}

abstract class KeyPair {
  sign(Uint8List message);

  bool verify(Uint8List message, Uint8List signature);

  String toString();

  PublicKey getPublicKey();

   // @param curve Name of elliptical curve, case-insensitive
   // @returns Random KeyPair based on the curve
  static KeyPair fromRandom(String curve) {
    switch (curve.toUpperCase()) {
      case 'ED25519':
        return KeyPairEd25519.fromRandom();
      default:
        throw Exception('Unknown curve: ' + curve);
    }
  }

  static KeyPair fromString(String encodedKey) {
    var parts = encodedKey.split(':');
    if (parts.length == 1) {
      return KeyPairEd25519(parts[0]);
    } else if (parts.length == 2) {
      switch (parts[0].toUpperCase()) {
        case 'ED25519':
          return KeyPairEd25519(parts[1]);
        default:
          throw Exception('Unknown curve: ${parts[0]}');
      }
    } else {
      throw Exception(
          'Invalid encoded key format, must be <curve>:<encoded key>');
    }
  }
}

// This class provides key pair functionality for Ed25519 curve:
// generating key pairs, encoding key pairs, signing and verifying.
class KeyPairEd25519 extends KeyPair {
  late PublicKey publicKey;
  late String secretKey;

  // Construct an instance of key pair given a secret key.
  // It's generally assumed that these are encoded in base58.
  // @param {string} secretKey
  KeyPairEd25519(String secret) {
    tweetnacl.KeyPair keyPair = tweetnacl.Signature.keyPair_fromSecretKey(
        Uint8List.fromList(utf8.encode(secret)));
    secretKey = secret;
    publicKey = PublicKey(keyPair.publicKey);
  }

  // Generate a new random keypair.
  // @example
  // const keyRandom = KeyPair.fromRandom();
  // keyRandom.publicKey
  //     returns [PUBLIC_KEY]
  // keyRandom.secretKey
  //     returns [SECRET_KEY]

  static fromRandom() {
    var newKeyPair = tweetnacl.Signature.keyPair();
    return KeyPairEd25519(utf8.decode(newKeyPair.secretKey));
  }

  @override
  Signature sign(Uint8List message) {
    var secret = utf8.encode(secretKey);
    var signature = tweetnacl.Signature(null, Uint8List.fromList(secret)).detached(message);
    return Signature(signature, publicKey);
  }

  @override
  bool verify(Uint8List message, Uint8List signature) {
    return publicKey.verify(message, signature);
  }

  @override
  String toString() {
    return 'ed25519:$secretKey ';
  }

  @override
  PublicKey getPublicKey() {
    return publicKey;
  }
}
