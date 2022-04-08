import 'package:near_jsonrpc_client/connection/signer.dart';
import 'package:near_jsonrpc_client/connection/web.dart';
import 'package:near_jsonrpc_client/providers/json_rpc_provider.dart';
import 'package:near_jsonrpc_client/store/in_memory_keystore.dart';
import 'package:near_jsonrpc_client/store/keystore.dart';
import '../providers/provider.dart';

class Config {
  final String networkId;
  final String nodeUrl;
  final Map headers;
  final ProviderType providerType;
  final SignerType signerType;
  final KeystoreType keystoreType;

  Config(
      this.networkId,
      this.nodeUrl,
      this.headers,
      this.providerType,
      this.signerType,
      this.keystoreType
      );
}


// Connects an account to a given network via a given provider
class Connection {
  final String networkId;
  final Provider provider;
  final Signer signer;

  // @param config Contains connection info details
  static Connection fromConfig(Config config) {
    var provider = getProvider(config);
    var signer = getSigner(config);
    return Connection(config.networkId, provider, signer);
  }

  Connection(this.networkId, this.provider, this.signer);

  static Signer getSigner(Config config) {
    var keystore = getKeystore(config.keystoreType);
    switch(config.signerType) {
      case SignerType.inMemory:
        return InMemorySigner(keystore);
      default:
        throw Exception("Unknown signer type.");
    }
  }

  static Provider getProvider(Config config) {
    switch(config.providerType) {
      case ProviderType.jsonRpc:
        return JsonRpcProvider(ConnectionInfo.onlyWithUrlAndHeaders(config.nodeUrl));
      default:
        throw Exception("Unknown provider type.");
    }
  }

  static KeyStore getKeystore(KeystoreType keystoreType) {
    switch(keystoreType) {
      case KeystoreType.inMemory:
        return InMemoryKeyStore();
      case KeystoreType.cache:
        //TODO replace keystore to cache keystore
        return InMemoryKeyStore();
      default:
        throw Exception("Unknown keystore type.");
    }
  }
}

enum SignerType {
  inMemory
}

enum ProviderType {
  jsonRpc
}

enum KeystoreType {
  inMemory,
  cache
}