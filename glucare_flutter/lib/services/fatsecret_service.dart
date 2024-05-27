import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class FatSecretService {
  final String apiKey;
  final String apiSecret;
  final String apiUrl = 'https://platform.fatsecret.com/rest/server.api';

  FatSecretService(this.apiKey, this.apiSecret);

  Future<http.Response> searchFood(String query) async {
    final timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    final nonce = _generateNonce();

    final params = {
      'method': 'foods.search',
      'format': 'json',
      'oauth_consumer_key': apiKey,
      'oauth_nonce': nonce,
      'oauth_signature_method': 'HMAC-SHA1',
      'oauth_timestamp': timestamp,
      'oauth_version': '1.0',
      'search_expression': query,
    };

    final baseString = _generateBaseString('GET', apiUrl, params);
    final signingKey = '${apiSecret}&';
    final signature = _generateSignature(baseString, signingKey);

    params['oauth_signature'] = signature;

    final uri = Uri.parse(apiUrl).replace(queryParameters: params);
    return http.get(uri);
  }

  String _generateNonce() {
    final random = Random();
    final values = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Url.encode(values).replaceAll('=', '');
  }

  String _generateBaseString(String method, String url, Map<String, String> params) {
    final sortedParams = params.keys.toList()..sort();
    final normalizedParams = sortedParams.map((key) => '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(params[key]!)}').join('&');
    return '${method.toUpperCase()}&${Uri.encodeComponent(url)}&${Uri.encodeComponent(normalizedParams)}';
  }

  String _generateSignature(String baseString, String key) {
    final hmacSha1 = Hmac(sha1, utf8.encode(key));
    final digest = hmacSha1.convert(utf8.encode(baseString));
    return base64Encode(digest.bytes);
  }
}
