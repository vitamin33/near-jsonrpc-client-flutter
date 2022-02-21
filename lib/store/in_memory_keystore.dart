import 'dart:collection';
import 'package:near_jsonrpc_client/struct/key_pair.dart';
import 'keystore.dart';

//
// Simple in-memory keystore for mainly for testing purposes.
//
// @example {@link https://docs.near.org/docs/develop/front-end/naj-quick-reference#key-store}
// @example
// ```js
// import { connect, keyStores, utils } from 'near-api-js';
//
// const privateKey = '.......';
// const keyPair = utils.KeyPair.fromString(privateKey);
//
// const keyStore = new keyStores.InMemoryKeyStore();
// keyStore.setKey('testnet', 'example-account.testnet', keyPair);
//
// const config = {
//   keyStore, // instance of InMemoryKeyStore
//   networkId: 'testnet',
//   nodeUrl: 'https://rpc.testnet.near.org',
//   walletUrl: 'https://wallet.testnet.near.org',
//   helperUrl: 'https://helper.testnet.near.org',
//   explorerUrl: 'https://explorer.testnet.near.org'
// };
//
// // inside an async function
// const near = await connect(config)
// ```
class InMemoryKeyStore extends KeyStore {
  late Map<String, String> _keys;

  InMemoryKeyStore() {
    _keys = HashMap();
  }

  // Stores a {@KeyPair} in in-memory storage item
  // @param networkId The targeted network. (ex. default, betanet, etc…)
  // @param accountId The NEAR account tied to the key pair
  // @param keyPair The key pair to store in local storage
  @override
  Future<void> setKey(
      String networkId, String accountId, KeyPair keyPair) async {
    _keys['$accountId:$networkId'] = keyPair.toString();
  }

  // Gets a {@link KeyPair} from in-memory storage
  // @param networkId The targeted network. (ex. default, betanet, etc…)
  // @param accountId The NEAR account tied to the key pair
  // @returns {Promise<KeyPair>}
  @override
  Future<KeyPair> getKey(String networkId, String accountId) async {
    var value = _keys['$accountId:$networkId'];
    if (value == null) {
      throw Exception("_keys value shouldn't be null!");
    }
    return KeyPair.fromString(value);
  }

  // Removes a {@link KeyPair} from in-memory storage
  // @param networkId The targeted network. (ex. default, betanet, etc…)
  // @param accountId The NEAR account tied to the key pair

  @override
  Future<void> removeKey(String networkId, String accountId) async {
    _keys.remove('$accountId:$networkId');
  }

  // Removes all {@link KeyPairs} from in-memory storage

  @override
  Future<void> clear() async {
    _keys.clear();
  }

  // Get the network(s) from in-memory storage
  // @returns {Promise<string[]>}
  @override
  Future<List<String>> getNetworks() async {
    var result = <String>{};
    for (var key in _keys.keys) {
      var parts = key.split(":");
      result.add(parts[1]);
    }
    return result.toList();
  }

  // Gets the account(s) from in-memory storage
  // @param networkId The targeted network. (ex. default, betanet, etc…)
  // @returns{Promise<string[]>}
  @override
  Future<List<String>> getAccounts(String networkId) async {
    const result = <String>[];
    for (var key in _keys.keys) {
      var parts = key.split(":");
      if (parts[parts.length - 1] == networkId) {
        result.add(parts.sublist(0, parts.length - 1).join(':'));
      }
      result.add(parts[1]);
    }

    return result;
  }

  @override
  String toString() {
    return 'InMemoryKeyStore';
  }
}
