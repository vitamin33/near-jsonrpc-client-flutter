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

  static stringifyJsonOrBytes(Uint8List args) {
    //TODO add ability to pass objects as arguments
    return args;
  }

  // Constructs {@link Action} instance representing contract method call.
  // @param methodName the name of the method to call
  // @param args arguments to pass to method. Can be either plain JS object which gets serialized as JSON automatically
  //  or `Uint8Array` instance which represents bytes passed as is.
  // @param gas max amount of gas that method call can use
  // @param deposit amount of NEAR (in yoctoNEAR) to send together with the call
  // @param stringify Convert input arguments into bytes array.
  static IAction functionCall(
      String methodName, Uint8List args, BigInt gas, BigInt deposit) {
    return FunctionCall(Action.functionCall, methodName, args, gas, deposit);
  }

  static IAction transfer(BigInt deposit) {
    return Transfer(Action.transfer, deposit);
  }

  static IAction stake(BigInt stake, PublicKey publicKey) {
    return Stake(Action.stake, stake, publicKey);
  }

  static IAction addKey(PublicKey publicKey, AccessKey accessKey) {
    return AddKey(Action.addKey, publicKey, accessKey);
  }

  static IAction deleteKey(PublicKey publicKey) {
    return DeleteKey(Action.deleteKey, publicKey);
  }

  static IAction deleteAccount(String beneficiaryId) {
    return DeleteAccount(Action.deleteAccount, beneficiaryId);
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

  FunctionCall(
      Action action, this.methodName, this.args, this.gas, this.deposit)
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
