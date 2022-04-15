import '../api_client/media_type.dart';

class Media<T> {
  final MediaType mediaType;
  List<T> media;
  Media({
    required this.mediaType,
    required this.media,
  });
}