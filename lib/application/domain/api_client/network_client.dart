import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/retry.dart';
import 'package:movie_night/application/domain/api_client/api_client_exception.dart';

import '../../configuration/network_configuration.dart';
import 'network_cache_manager.dart';
import 'package:http/http.dart' as http;

class NetworkClient {
  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('${NetworkConfiguration.host}$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<T> getWithCache<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    try {
      final url = _makeUri(path, urlParameters);
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

  Future<T> get<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    final _client = RetryClient(http.Client());
    try {
      final _client = RetryClient(http.Client());
      final url = _makeUri(path, urlParameters);
      final response = await _client.get(url);
      _handleResponse(response);
      final json = (await jsonDecode(response.body));
      final result = parser(json);
      return result;
    } on SocketException catch (_) {
      throw ApiClientException(
        'network-error',
      );
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
    } finally {
      _client.close();
    }
  }

  Future<T> post<T>(
    String path,
    Map<String, dynamic> bodyParameters,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    final _client = RetryClient(http.Client());
    try {
      final url = _makeUri(path, urlParameters);
      final response = await _client.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bodyParameters,
      );
      _handleResponse(response);
      final json = (await jsonDecode(response.body));
      final result = parser(json);
      return result;
    } on SocketException catch (_) {
      throw ApiClientException('network-error');
    } on ApiClientException catch (_) {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw ApiClientException("unknown-error");
    } finally {
      _client.close();
    }
  }

  void _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    if (statusCode != 200) {
      log('statusCode: $statusCode');
      throw ApiClientException('unknown-error');
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
