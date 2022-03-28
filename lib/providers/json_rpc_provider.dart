import 'dart:convert';

import 'package:http/http.dart';
import 'package:near_jsonrpc_client/connection/web.dart';
import 'package:near_jsonrpc_client/struct/responses.dart';
import 'package:near_jsonrpc_client/struct/transaction/transactions.dart';

import 'provider.dart';

// Default number of retries before giving up on a request.
const requestRetryNumber = 12;

// Default wait until next retry in millis.
const requestRetryWait = 500;

// Exponential back off for waiting to retry.
const requestRetryWaitBackoff = 1.5;

const jsonRpcVersion = "2.0";

var _nextId = 123;

/// Client class to interact with the NEAR RPC API.
/// @see {@link https://github.com/near/nearcore/tree/master/chain/jsonrpc}
class JsonRpcProvider extends Provider {

  final ConnectionInfo connection;

  JsonRpcProvider(this.connection);

  @override
  Future<BlockResult> block(BlockId blockId) {
    // TODO: implement block
    throw UnimplementedError();
  }

  @override
  Future<BlockChangeResult> blockChanges(BlockId blockId) {
    // TODO: implement blockChanges
    throw UnimplementedError();
  }

  @override
  Future<BlockChangeResult> blockChangesWithReference(BlockReference blockReference) {
    // TODO: implement blockChangesWithReference
    throw UnimplementedError();
  }

  @override
  Future<BlockResult> blockWithReference(BlockReference blockReference) {
    // TODO: implement blockWithReference
    throw UnimplementedError();
  }

  @override
  Future<ChunkResult> chunk(ChunkId chunkId) {
    // TODO: implement chunk
    throw UnimplementedError();
  }

  @override
  Future<NearProtocolConfig> experimental_genesisConfig() {
    // TODO: implement experimental_genesisConfig
    throw UnimplementedError();
  }

  @override
  Future<NearProtocolConfig> experimental_protocolConfig(BlockReference blockReference) {
    // TODO: implement experimental_protocolConfig
    throw UnimplementedError();
  }

  @override
  Future<GasPrice> gasPrice(BlockId blockId) {
    // TODO: implement gasPrice
    throw UnimplementedError();
  }

  @override
  Future<LightClientProof> lightClientProof(LightClientProofRequest request) {
    // TODO: implement lightClientProof
    throw UnimplementedError();
  }

  @override
  Future<T> query<T extends QueryResponseKind>(RpcQueryRequest params) {
    // TODO: implement query
    throw UnimplementedError();
  }

  @override
  Future<T> queryWithPath<T extends QueryResponseKind>(String path, String data) {
    // TODO: implement queryWithPath
    throw UnimplementedError();
  }

  @override
  Future<FinalExecutionOutcome> sendTransaction(SignedTransaction signedTransaction) {
    // TODO: implement sendTransaction
    throw UnimplementedError();
  }

  /// Gets the RPC's status
  /// @see {@link https://docs.near.org/docs/develop/front-end/rpc#general-validator-status}
  @override
  Future<NodeStatusResult> status() async {
    return this.sendJsonRpc("status", {});
  }

  @override
  Future<FinalExecutionOutcome> txStatus(String txHash, String accountId) {
    // TODO: implement txStatus
    throw UnimplementedError();
  }

  @override
  Future<FinalExecutionOutcome> txStatusReceipts(String txHash, String accountId) {
    // TODO: implement txStatusReceipts
    throw UnimplementedError();
  }

  @override
  Future<EpochValidatorInfo> validators(BlockId blockId) {
    // TODO: implement validators
    throw UnimplementedError();
  }


  /// Directly call the RPC specifying the method and params
  ///
  /// @param method RPC method
  /// @param params Parameters to the method
  Future<T> sendJsonRpc<T>(String method, Map<String, String> params) async {
    var request = Request(
        method,
        _nextId++,
        jsonRpcVersion,
        params
    );
    var result = await fetchJson();
    return result;
  }
}

class Request {
  final String method;
  final int id;
  final dynamic params;
  final String jsonrpc;

  Request(this.method, this.id, this.jsonrpc, this.params);

  Request.fromJson(Map<String, dynamic> json)
      : method = json['method'],
        params = json['params'].fromJson(),
        jsonrpc = json['jsonrpc'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
    'method': method,
    'id': id,
    'params': params.toJson(),
    'jsonrpc': jsonrpc
  };
}

class Params {
  final Map<String, String> params;

  Params(this.params);

  factory Params.fromJson(String json) => Params(jsonDecode(json));

  String toJson() =>  jsonEncode(params);
}