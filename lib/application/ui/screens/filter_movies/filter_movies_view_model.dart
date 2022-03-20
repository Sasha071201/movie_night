import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../widgets/dialog_widget.dart';

enum DateTimeType { from, before }

class FilterMoviesViewModel extends ChangeNotifier {
  final _listShowMe = [
    'I haven\'t seen',
    'Watched',
  ];
  List<String> get listShowMe => _listShowMe;

  final _listReleaseDate = [
    'All releases',
    'Premier',
    'Theatrical',
  ];
  List<String> get listReleaseDate => _listReleaseDate;

  final _listCountries = [
    'United States',
    'Russia',
    'Ukraine',
    'Germany',
  ];
  List<String> get listCountries => _listCountries;

  final _listGenres = [
    'Action',
    'Drama',
    'Criminal',
    'Trailer',
  ];
  List<String> get listGenres => _listGenres;

  final _listCertification = [
    'NO',
    'G',
    'PG',
  ];
  List<String> get listCertification => _listCertification;

  final _listLanguage = [
    'United States',
    'Russia',
    'Ukraine',
    'Germany',
  ];
  List<String> get listLanguage => _listLanguage;

  var _currentIndexShowMe = 0;
  int get currentIndexShowMe => _currentIndexShowMe;

  var _currentIndexReleaseDate = 0;
  int get currentIndexReleaseDate => _currentIndexReleaseDate;

  var _currentIndexCountry = -1;
  int get currentIndexCountry => _currentIndexCountry;

  bool _isAllCountriesSelected = true;
  bool get isAllCountriesSelected => _isAllCountriesSelected;

  var _currentIndicesGenre = <int>[];
  List<int> get currentIndicesGenre => _currentIndicesGenre;

  var _currentIndexCertification = -1;
  int get currentIndexCertification => _currentIndexCertification;

  var _currentIndexLanguage = -1;
  int get currentIndexLanguage => _currentIndexLanguage;

  DateTime? _fromReleaseDate;
  String get fromReleaseDate => _stringFromDate(_fromReleaseDate);

  DateTime? _beforeReleaseDate;
  String get beforeReleaseDate => _stringFromDate(_beforeReleaseDate);

  late DateFormat _dateFormat;
  String _locale = '';

  String _stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : 'not selected';

  void setupLocale(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
  }

  void selectShowMeItem(int index) {
    _currentIndexShowMe = index;
    notifyListeners();
  }

  void selectReleaseDateItem(int index) {
    _currentIndexReleaseDate = index;
    _fromReleaseDate = null;
    _beforeReleaseDate = null;
    notifyListeners();
  }

  Future<void> pickDate(BuildContext context, DateTimeType dateTimeType) async {
    final dateNow = DateTime.now();
    final minDate = DateTime(1000);
    final maxDate = DateTime(dateNow.year + 1000);

    final date = await DialogWidget.showDataPicker(
      context: context,
      initialDate: dateNow,
      firstDate: minDate,
      lastDate: maxDate,
    );
    _selectReleaseDate(date, dateTimeType);
  }

  void _selectReleaseDate(DateTime? date, DateTimeType dateTimeType) {
    if (date != null) {
      _currentIndexReleaseDate = -1;
      switch (dateTimeType) {
        case DateTimeType.before:
          _beforeReleaseDate = date;
          break;
        case DateTimeType.from:
          _fromReleaseDate = date;
          break;
      }
      notifyListeners();
    }
  }

  void selectAllCountries() {
    _isAllCountriesSelected = true;
    _currentIndexCountry = -1;
    notifyListeners();
  }

  void selectCountry(int index) {
    _isAllCountriesSelected = false;
    _currentIndexCountry = index;
    notifyListeners();
  }

  void selectGenre(int index) {
    if (_currentIndicesGenre.contains(index)) {
      _currentIndicesGenre.remove(index);
    } else {
      _currentIndicesGenre.add(index);
    }
    notifyListeners();
  }

  void selectCertificationItem(int index) {
    _currentIndexCertification = index;
    notifyListeners();
  }
  
  void selectLanguageItem(int index) {
    _currentIndexLanguage = index;
    notifyListeners();
  }
}
