import 'package:movie_night/application/domain/api_client/media_type.dart';

MediaType? parseMediaTypeFromString(String rawType) {
  if (rawType.isEmpty) return null;
  if (rawType.compareTo('movie') == 0) {
    return MediaType.movie;
  } else if (rawType.compareTo('tv') == 0) {
    return MediaType.tv;
  }
  return null;
}
