import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:http/retry.dart';

const startWaitTimeMs = 1000;
const backOffMultiplayer = 1.5;
const retryNumber = 10;

var logger = Logger(
  printer: PrettyPrinter(),
);

class ConnectionInfo {
  String url;
  String? user;
  String? password;
  bool allowInsecure;
  int timeout;
  Map<String, String> headers;

  ConnectionInfo(this.url, this.user, this.password, this.allowInsecure,
      this.timeout, this.headers);

  static Future<http.Response> fetchJson(
      String url, String? json, Map<String, String>? headers) {
    var response = computeResult(url, json, headers);
    return response;
  }

// Sleep given number of millis.
  static Future<dynamic> sleep(int millis) async {
    return Future.delayed(Duration(milliseconds: millis));
  }
}

Future<http.Response> computeResult(
    String url, String? json, Map<String, String>? headers) async {
  http.Response response;
  final client = RetryClient(http.Client());

  Map<String, String> headerList;
  if (headers != null) {
    headerList = {...headers, 'Content-Type': 'application/json'};
  } else {
    headerList = {'Content-Type': 'application/json'};
  }
  if (json == null) {
    response = await client.get(Uri.parse(url), headers: headerList);
  } else {
    response = await client.post(Uri.parse(url), headers: headerList);
  }
  if (response.statusCode != 200) {
    if (response.statusCode == 503) {
      logger.d("Retrying HTTP request for $url as it's not available now");
    } else {
      logger.d("Retrying HTTP request for $url as it's not available now");
    }
  }
  return response;
}
