import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'package:near_jsonrpc_client/struct/key_pair.dart';
import 'package:near_jsonrpc_client/struct/responses.dart';
import 'package:tuple/tuple.dart';

import 'connection/connection.dart';
import 'struct/transaction/transactions.dart';

class AccountBalance {
  String total;
  String stateStaked;
  String staked;
  String available;

  AccountBalance(this.total, this.stateStaked, this.staked, this.available);
}

class AccountAuthorizedApp {
  String contractId;
  String amount;
  String publicKey;

  AccountAuthorizedApp(this.contractId, this.amount, this.publicKey);
}

// Options used to initiate sining and sending transactions
class SignAndSendTransactionOptions {
  String receiverId;
  List<Action> actions;

  // Metadata to send the NEAR Wallet if using it to sign transactions.
  // @see {@link RequestSignTransactionsOptions}
  String? walletMeta;

  // Callback url to send the NEAR Wallet if using it to sign transactions.
  // @see {@link RequestSignTransactionsOptions}
  String? walletCallbackUrl;
  bool returnError;

  SignAndSendTransactionOptions(this.receiverId, this.actions, this.walletMeta,
      this.walletCallbackUrl, this.returnError);
}

// Options used to initiate a function call (especially a change function call)
// @see {@link viewFunction} to initiate a view function call
class FunctionCallOptions {
  // The NEAR account id where the contract is deployed
  String contractId;

  //The name of the method to invoke
  String methodName;

  // named arguments to pass the method `{ messageText: 'my message' }`
  dynamic args;

  // max amount of gas that method call can use
  BigInt? gas;

  // amount of NEAR (in yoctoNEAR) to send together with the call
  BigInt? attachedDeposit;

  // Metadata to send the NEAR Wallet if using it to sign transactions.
  // @see {@link RequestSignTransactionsOptions}
  String? walletMeta;

  // Callback url to send the NEAR Wallet if using it to sign transactions.
  // @see {@link RequestSignTransactionsOptions}
  String? walletCallbackUrl;

  // Convert input arguments into bytes array.
  Function(int input)? stringify;

  FunctionCallOptions(
      this.contractId,
      this.methodName,
      this.args,
      this.gas,
      this.attachedDeposit,
      this.walletMeta,
      this.walletCallbackUrl,
      this.stringify);
}

String parseJsonFromRawResponse(Uint8List response) {
  return response.toString();
}

Uint8List bytesJsonStringify(String input) {
  return Uint8List.fromList(utf8.encode(input));
}

// This class provides common account related RPC calls including signing transactions with a {@link KeyPair}.
//
// @example {@link https://docs.near.org/docs/develop/front-end/naj-quick-reference#account}
// @hint Use {@link WalletConnection} in the browser to redirect to {@link https://docs.near.org/docs/tools/near-wallet | NEAR Wallet} for Account/key management using the {@link BrowserLocalStorageKeyStore}.
// @see {@link https://nomicon.io/DataStructures/Account.html | Account Spec}

abstract class Account {
  final Connection connection;
  final String accountId;

  Future<void> ready();

  Account(this.connection, this.accountId);

  Future<void> fetchState();

  // Returns basic NEAR account information via the `view_account` RPC query method
  // @see {@link https://docs.near.org/docs/develop/front-end/rpc#view-account}
  Future<AccountView> state();

  // Create a signed transaction which can be broadcast to the network
  // @param receiverId NEAR account receiving the transaction
  // @param actions list of actions to perform as part of the transaction
  // @see {@link JsonRpcProvider.sendTransaction}
  Future<Tuple2<Uint8List, SignedTransaction>> signTransaction(
      String receiverId, List<Action> actions);

  // Sign a transaction to preform a list of actions and broadcast it using the RPC API.
  // @see {@link JsonRpcProvider.sendTransaction}
  Future<FinalExecutionOutcome> signAndSendTransactionWithOption(
      SignAndSendTransactionOptions options);

  /// @deprecated
  /// Sign a transaction to preform a list of actions and broadcast it using the RPC API.
  /// @see {@link JsonRpcProvider.sendTransaction}
  ///
  /// @param receiverId NEAR account receiving the transaction
  /// @param actions list of actions to perform as part of the transaction
  Future<FinalExecutionOutcome> signAndSendTransaction(
      String receiverId, List<Action> actions);

  Map<String, AccessKeyView> accessKeyByPublicKeyCache = HashMap();

  /// Create a new account and deploy a contract to it
  ///
  /// @param contractId NEAR account where the contract is deployed
  /// @param publicKey The public key to add to the created contract account
  /// @param data The compiled contract code
  /// @param amount of NEAR to transfer to the created contract account. Transfer enough to pay for storage https://docs.near.org/docs/concepts/storage-staking
  Future<Account> createAndDeployContract(
      String contractId, PublicKey publicKey, Uint8List data, BigInt amount);

  /// @param receiverId NEAR account receiving Ⓝ
  /// @param amount Amount to send in yoctoⓃ
  Future<FinalExecutionOutcome> sendMoney(String receiverId, BigInt amount);

  /// @param newAccountId NEAR account name to be created
  /// @param publicKey A public key created from the masterAccount
  Future<FinalExecutionOutcome> createAccount(
      String newAccountId, PublicKey publicKey, BigInt amount);

  /// @param beneficiaryId The NEAR account that will receive the remaining Ⓝ balance from the account being deleted
  Future<FinalExecutionOutcome> deleteAccount(String beneficiaryId);

  /// @param data The compiled contract code
  Future<FinalExecutionOutcome> deployContract(Uint8List data);

  Future<FinalExecutionOutcome> functionCall(FunctionCallOptions props);

// /// @deprecated
// ///
// /// @param contractId NEAR account where the contract is deployed
// /// @param methodName The method name on the contract as it is written in the contract code
// /// @param args arguments to pass to method. Can be either plain JS object which gets serialized as JSON automatically
// ///  or `Uint8Array` instance which represents bytes passed as is.
// /// @param gas max amount of gas that method call can use
// /// @param amount amount of NEAR (in yoctoNEAR) to send together with the call
// /// @returns {Promise<FinalExecutionOutcome>}
// Future<FinalExecutionOutcome> functionCallFull(String contractId, String methodName, dynamic args, BigInt? gas, BigInt? amount);

  /// @see {@link https://docs.near.org/docs/concepts/account#access-keys}
  /// @todo expand this API to support more options.
  /// @param publicKey A public key to be associated with the contract
  /// @param contractId NEAR account where the contract is deployed
  /// @param methodNames The method names on the contract that should be allowed to be called. Pass null for no method names and '' or [] for any method names.
  /// @param amount Payment in yoctoⓃ that is sent to the contract during this function call
  Future<FinalExecutionOutcome> addKey(String publicKey, String? contractId,
      List<String> methodNames, BigInt? amount);

  /// @param publicKey The public key to be deleted
  /// @returns {Promise<FinalExecutionOutcome>}
  Future<FinalExecutionOutcome> deleteKey(String publicKey);

  /// @see {@link https://docs.near.org/docs/validator/staking-overview}
  ///
  /// @param publicKey The public key for the account that's staking
  /// @param amount The account to stake in yoctoⓃ
  Future<FinalExecutionOutcome> stake(String publicKey, BigInt amount);

  /// Invoke a contract view function using the RPC API.
  /// @see {@link https://docs.near.org/docs/develop/front-end/rpc#call-a-contract-function}
  ///
  /// @param contractId NEAR account where the contract is deployed
  /// @param methodName The view-only method (no state mutations) name on the contract as it is written in the contract code
  /// @param args Any arguments to the view contract method, wrapped in JSON
  /// @param options.parse Parse the result of the call. Receives a Buffer (bytes array) and converts it to any object. By default result will be treated as json.
  /// @param options.stringify Convert input arguments into a bytes array. By default the input is treated as a JSON.
  /// @returns {Promise<any>}
  Future<dynamic> viewFunction(
      String contractId, String methodName, dynamic args);

  /// Returns the state (key value pairs) of this account's contract based on the key prefix.
  /// Pass an empty string for prefix if you would like to return the entire state.
  /// @see {@link https://docs.near.org/docs/develop/front-end/rpc#view-contract-state}
  ///
  /// @param prefix allows to filter which keys should be returned. Empty prefix means all keys. String prefix is utf-8 encoded.
  /// @param blockQuery specifies which block to query state at. By default returns last "optimistic" block (i.e. not necessarily finalized).
  Future<Map<String, String>> viewState(
      String prefix, String blockId, Finality finality);

  /// Get all access keys for the account
  /// @see {@link https://docs.near.org/docs/develop/front-end/rpc#view-access-key-list}
  Future<AccessKeyInfoView> getAccessKeys();

  /// Returns a list of authorized apps
  /// @todo update the response value to return all the different keys, not just app keys.
  Future<List<AccountAuthorizedApp>> getAccountDetails();

  /// Returns calculated account balance
  Future<AccountBalance> getAccountBalance();
}
