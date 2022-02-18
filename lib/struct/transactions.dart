import 'dart:ffi';
import 'dart:typed_data';

import 'key_pair.dart';

const String ed25519 = 'ed25519';

class SignedTransaction {
  final Transaction transaction;
  final Signature signature;

  SignedTransaction(this.transaction, this.signature);
}

class Transaction {
  final String signerId;
  final PublicKey publicKey;
  final int nonce;
  final String receiverId;
  final List<Action> actions;
  final Array<Uint8> blockHash;

  Transaction(this.signerId, this.publicKey, this.nonce, this.receiverId,
      this.actions, this.blockHash);
}

class Signature {
  final String keyType = ed25519;
  final Array<Uint8> data;

  Signature(this.data);
}

 // Contains a list of the valid transaction Actions available with this API
 // @see {@link https://nomicon.io/RuntimeSpec/Actions.html | Actions Spec}
enum Action {
  createAccount,
  deployContract,
  functionCall,
  transfer,
  stake,
  addKey,
  deleteKey,
  deleteAccount
}