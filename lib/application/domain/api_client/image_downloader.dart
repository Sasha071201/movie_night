import 'package:movie_night/application/configuration/network_configuration.dart';

class ImageDownloader {
  static String imageUrl(String path) => NetworkConfiguration.imageUrl+ path;
  static String imageHighQualityUrl(String path) => NetworkConfiguration.imageHighQualityUrl+ path;
}
