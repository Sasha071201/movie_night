import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class NetworkCacheManager {
  NetworkCacheManager._();
  static const key = 'NetworkCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      maxNrOfCacheObjects: 110,
    ),
  );
}