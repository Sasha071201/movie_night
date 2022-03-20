import 'package:flutter/material.dart';

class SearchMoviesViewModel extends ChangeNotifier {
  final _listGenres = [
    'Action',
    'Drama',
    'Criminal',
    'Trailer',
    'Action',
    'Drama',
    'Criminal',
    'Trailer',
    'Action',
    'Drama',
    'Criminal',
    'Trailer',
    'Action',
    'Drama',
    'Criminal',
    'Trailer',
  ];
  List<String> get listGenres => _listGenres;
}
