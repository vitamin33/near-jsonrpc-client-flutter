import 'dart:convert';

import 'package:near_jsonrpc_client/account.dart';
import 'package:near_jsonrpc_client/struct/key_pair.dart';
import 'package:near_jsonrpc_client/connection/web.dart';

import 'connection/connection.dart';

/// Account creator provides an interface for implementations to actually create accounts
abstract class AccountCreator {
  Future<void> createAccount(String newAccountId, PublicKey publicKey);
}
class LocalAccountCreator extends AccountCreator {
  final Account masterAccount;
  final BigInt initialBalance;

  LocalAccountCreator(this.masterAccount, this.initialBalance);

  /// Creates an account using a masterAccount, meaning the new account is created from an existing account
  /// @param newAccountId The name of the NEAR account to be created
  /// @param publicKey The public key from the masterAccount used to create this account
  /// @returns {Promise<void>}
  @override
  Future<void> createAccount(String newAccountId, PublicKey publicKey) {
    return masterAccount.createAccount(newAccountId, publicKey, initialBalance);
  }
}
class UrlAccountCreator extends AccountCreator {
  final Connection connection;
  final String helperUrl;
  UrlAccountCreator(this.connection, this.helperUrl);

  /// Creates an account using a helperUrl
  /// This is [hosted here](https://helper.nearprotocol.com) or set up locally with the [near-contract-helper](https://github.com/nearprotocol/near-contract-helper) repository
  /// @param newAccountId The name of the NEAR account to be created
  /// @param publicKey The public key from the masterAccount used to create this account
  /// @returns {Promise<void>}
  @override
  Future<void> createAccount(String newAccountId, PublicKey publicKey) async {
    //TODO add needed headers
    var jsonObject = {'newAccountId': newAccountId, 'newAccountPublicKey': publicKey.toString()};
    await ConnectionInfo.fetchJson(
        '$helperUrl/account',
        jsonEncode(jsonObject),
        null
    );
  }
}
