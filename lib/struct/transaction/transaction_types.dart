import 'dart:typed_data';

import '../key_pair.dart';
import 'transactions.dart';

class IAction {
  Action action;

  IAction(this.action);

  static IAction createAccount() {
    return CreateAccount(Action.createAccount);
  }

  static IAction deployContract(Uint8List code) {
  return DeployContract(Action.deployContract, code);
  }
}

class CreateAccount extends IAction {
  CreateAccount(Action action) : super(action);
}

class DeployContract extends IAction {
  Uint8List code;

  DeployContract(Action action, this.code) : super(action);
}
class FunctionCall extends IAction {
  String methodName;
  Uint8List args;
  BigInt gas;
  BigInt deposit;

  FunctionCall(Action action, this.methodName, this.args, this.gas, this.deposit)
  : super(action);
}

class Transfer extends IAction {
  BigInt deposit;

  Transfer(Action action, this.deposit) : super(action);
}

class Stake extends IAction {
  BigInt stake;
  PublicKey publicKey;

  Stake(Action action, this.stake, this.publicKey) : super(action);
}

class AddKey extends IAction {
  PublicKey publicKey;
  AccessKey accessKey;

  AddKey(Action action, this.publicKey, this.accessKey) : super(action);
}

class DeleteKey extends IAction {
  PublicKey publicKey;

  DeleteKey(Action action, this.publicKey) : super(action);
}

class DeleteAccount extends IAction {
  String beneficiaryId;

  DeleteAccount(Action action, this.beneficiaryId) : super(action);
}

