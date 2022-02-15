import 'dart:collection';
import 'dart:io';

import 'package:http/http.dart' as http;

const String contentType = "content-type";
const String appJsonContentType = "application/json";

class JsonRpcClient {

  final String serverUrl;
  final Map<String, String> headers;

  JsonRpcClient(this.serverUrl, this.headers);

  JsonRpcClient connect(String serverUrl) {
    Map<String, String> headers = {contentType : appJsonContentType};
    return JsonRpcClient(serverUrl, headers);
  }
}