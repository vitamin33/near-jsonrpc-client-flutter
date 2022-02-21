//General signing interface, can be used for in memory signing, RPC singing, external wallet, HSM, etc.
import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:near_jsonrpc_client/store/in_memory_keystore.dart';
import 'package:near_jsonrpc_client/store/keystore.dart';
import 'package:near_jsonrpc_client/struct/key_pair.dart';

abstract class Signer {
  //Creates new key and returns public key.
  Future<PublicKey> createKey(String accountId, String networkId);

  // Returns public key for given account / network.
  // @param accountId accountId to retrieve from.
  // @param networkId The targeted network. (ex. default, betanet, etc…)
  Future<PublicKey?> getPublicKey(String accountId, String networkId);

  // Signs given message, by first hashing with sha256.
  // @param message message to sign.
  // @param accountId accountId to use for signing.
  // @param networkId The targeted network. (ex. default, betanet, etc…)
  Future<Signature> signMessage(
      Uint8List message, String? accountId, String networkId);
}

// Signs using in memory key store.
class InMemorySigner extends Signer {
  final KeyStore keyStore;

  InMemorySigner(this.keyStore);

  // Creates a single account Signer instance with account, network and keyPair provided.
//
// Intended to be useful for temporary keys (e.g. claiming a Linkdrop).
//
// @param networkId The targeted network. (ex. default, betanet, etc…)
// @param accountId The NEAR account to assign the key pair to
// @param keyPair The keyPair to use for signing
  static Future<Signer> fromKeyPair(
      String networkId, String accountId, KeyPair keyPair) async {
    var keyStore = InMemoryKeyStore();
    await keyStore.setKey(networkId, accountId, keyPair);
    return InMemorySigner(keyStore);
  }

  // Creates a public key for the account given
  // @param accountId The NEAR account to assign a public key to
  // @param networkId The targeted network. (ex. default, betanet, etc…)
  // @returns {Promise<PublicKey>}
  @override
  Future<PublicKey> createKey(String accountId, String networkId) async {
    var keyPair = KeyPair.fromRandom('ed25519');
    await keyStore.setKey(networkId, accountId, keyPair);
    return keyPair.getPublicKey();
  }

  // Gets the existing public key for a given account
  // @param accountId The NEAR account to assign a public key to
  // @param networkId The targeted network. (ex. default, betanet, etc…)
  // @returns {Promise<PublicKey>} Returns the public key or null if not found

  @override
  Future<PublicKey?> getPublicKey(String accountId, String networkId) async {
    var keyPair = await keyStore.getKey(networkId, accountId);
    if (keyPair == null) {
      return null;
    }
    return keyPair.getPublicKey();
  }

  // @param message A message to be signed, typically a serialized transaction
  // @param accountId the NEAR account signing the message
  // @param networkId The targeted network. (ex. default, betanet, etc…)
  // @returns {Promise<Signature>}

  @override
  Future<Signature> signMessage(
      Uint8List message, String? accountId, String networkId) async {
    var stringHash = sha256.convert(message).toString();
    var hash = Uint8List.fromList(utf8.encode(stringHash));
    if (accountId == null) {
      throw Exception("InMemorySigner requires provided account id");
    }
    var keyPair = await keyStore.getKey(networkId, accountId);
    if (keyPair == null) {
      throw Exception("Key for $accountId not found in $networkId");
    }
    return keyPair.sign(hash);
  }

  @override
  String toString() {
    return 'InMemorySigner($keyStore)';
  }
}
