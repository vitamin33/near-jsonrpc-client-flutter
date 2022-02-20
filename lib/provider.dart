import 'package:near_jsonrpc_client/struct/responses.dart';
import 'package:near_jsonrpc_client/struct/transaction/transactions.dart';

abstract class Provider {
  Future<NodeStatusResult> status();

  Future<FinalExecutionOutcome> sendTransaction(SignedTransaction signedTransaction);
  //sendTransactionAsync(signedTransaction: SignedTransaction): Promise<FinalExecutionOutcome>;

  Future<FinalExecutionOutcome> txStatus(String txHash, String accountId);
  Future<FinalExecutionOutcome> txStatusReceipts(String txHash, String accountId);
  Future<T> query<T extends QueryResponseKind>(RpcQueryRequest params);

  // abstract query<T extends QueryResponseKind>(path: string, data: string): Promise<T>;
  // // TODO: BlockQuery type?
  // abstract block(blockQuery: BlockId | BlockReference): Promise<BlockResult>;
  // abstract blockChanges(blockQuery: BlockId | BlockReference): Promise<BlockChangeResult>;
  // abstract chunk(chunkId: ChunkId): Promise<ChunkResult>;
  // // TODO: Use BlockQuery?
  // abstract validators(blockId: BlockId): Promise<EpochValidatorInfo>;
  // abstract experimental_genesisConfig(): Promise<NearProtocolConfig>;
  // abstract experimental_protocolConfig(blockReference: BlockReference): Promise<NearProtocolConfig>;
  // abstract lightClientProof(request: LightClientProofRequest): Promise<LightClientProof>;
  // abstract gasPrice(blockId: BlockId): Promise<GasPrice>;
}