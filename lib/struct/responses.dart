class SyncInfo {
  final String latestBlockHash;
  final int latestBlockHeight;
  final String latestBlockTime;
  final String latestStateRoot;
  final bool syncing;

  SyncInfo.name(this.latestBlockHash, this.latestBlockHeight,
      this.latestBlockTime, this.latestStateRoot, this.syncing);
}

class Version {
  final String version;
  final String build;

  Version.name(this.version, this.build);
}

class NodeStatusResult {
  final String chainId;
  final String rpcAddr;
  final SyncInfo syncInfo;
  final List<String> validators;
  final Version version;

  NodeStatusResult.name(
      this.chainId, this.rpcAddr, this.syncInfo, this.validators, this.version);
}

