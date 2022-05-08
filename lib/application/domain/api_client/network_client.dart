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
    try {
      final url = _makeUri(path, urlParameters);
      final request = await _client.getUrl(url);
      final response = await request.close();
      final json = (await response.jsonDecode());
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
      final result = parser(json);
      return result;
    } on SocketException catch (_) {
      throw ApiClientException('network-error');
    } on ApiClientException catch (_) {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw ApiClientException("unknown-error");
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
