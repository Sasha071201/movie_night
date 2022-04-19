import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:movie_night/application/domain/api_client/api_client_exception.dart';

import '../../configuration/network_configuration.dart';
import 'network_cache_manager.dart';

class NetworkClient {
  final _client = HttpClient();

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('${NetworkConfiguration.host}$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  //With cache
  Future<T> getWithCache<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    try {
      final url = _makeUri(path, urlParameters);
      // print('request');
      // print(url);
      final file =
          await NetworkCacheManager.instance.getSingleFile(url.toString());
      final data = await file.readAsString();
      final json = (jsonDecode(data));
      final result = parser(json);
      return result;
    } on SocketException catch (_) {
      throw ApiClientException('network-error');
    } on HttpException catch (_) {
      throw ApiClientException(
        'network-error',
        ExceptionSolution.update,
      );
    } on ApiClientException catch (_) {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw ApiClientException("unknown-error");
    }
  }

  //Without cache
  Future<T> get<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    try {
      final url = _makeUri(path, urlParameters);
      // print(url);
      final request = await _client.getUrl(url);
      final response = await request.close();
      final json = (await response.jsonDecode());
      _validateResponse(response, json);
      final result = parser(json);
      return result;
    } on SocketException catch (_) {
      throw ApiClientException(
          'network-error');
    } on HttpException catch (_) {
      throw ApiClientException(
        'network-error',
        ExceptionSolution.update,
      );
    } on ApiClientException catch (_) {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw ApiClientException("unknown-error");
    }
  }

  Future<T> post<T>(
    String path,
    Map<String, dynamic> bodyParameters,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    try {
      final url = _makeUri(path, urlParameters);
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      final response = await request.close();
      final json = (await response.jsonDecode());
      _validateResponse(response, json);
      final result = parser(json);
      return result;
    } on SocketException catch (_) {
      throw ApiClientException(
          'network-error');
    } on ApiClientException catch (_) {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw ApiClientException("unknown-error");
    }
  }

  void _validateResponse(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 401) {
      final status = json['status_code'];
      final code = status is int ? status : 0;
      // if (code == 30) {
      //   throw ApiClientException(ApiClientExceptionType.auth);
      // } else if (code == 3) {
      //   throw ApiClientException(ApiClientExceptionType.sessionExpired);
      // } else {
      //   throw ApiClientException(ApiClientExceptionType.other);
      // }
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future jsonDecode() async {
    final rawResult = await transform(utf8.decoder).toList();
    final result = rawResult.join();
    return json.decode(result);
  }
}
