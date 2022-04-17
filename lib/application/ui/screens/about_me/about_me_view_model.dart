import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_night/application/repository/account_repository.dart';
import 'package:movie_night/application/utils/image_helper.dart';
import 'package:path/path.dart' as path;

class AboutMeViewModel extends ChangeNotifier {
  final _repository = AccountRepository();
  var isLoadingSave = false;
  String profileImageUrl = '';
  File? profileImageFile;
  var _nameFromDB = '';
  String _locale = '';
  late BuildContext _context;
  final _nameController = TextEditingController();
  TextEditingController get  nameController => _nameController;

  AboutMeViewModel() {
    loadData();
  }

  void setupLocale(BuildContext context) {
    _context = context;
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
  }

  Future<void> loadData() async {
    isLoadingSave = true;
    Future.microtask(() => notifyListeners());
    final name = await _repository.fetchUserName();
    _nameFromDB = name;
    nameController.text = name;
    profileImageUrl = await _repository.fetchUserProfileImageUrl();
    isLoadingSave = false;
    Future.microtask(() => notifyListeners());
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      final path = result?.files.single.path;
      if (result != null && path != null) {
        final croppedFile = await ImageHelper.cropImage(
          path: path,
          context: _context,
        );
        if (croppedFile != null) {
          final compressedFile = await ImageHelper.compressFile(croppedFile);
          if (compressedFile != null) {
            profileImageFile = File(compressedFile.path);
            notifyListeners();
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> save() async {
    final name = nameController.text.trim();
    nameController.text = name;
    FocusManager.instance.primaryFocus?.unfocus();
    if (name.isNotEmpty && name.compareTo(_nameFromDB) != 0) {
      isLoadingSave = true;
      notifyListeners();
      await _repository.setUserName(name);
    }
    if (profileImageFile != null) {
      isLoadingSave = true;
      notifyListeners();
      String fileName = path.basename(profileImageFile!.path);
      final success = await _repository.uploadProfileImage(
        fileName: fileName,
        file: profileImageFile!,
      );
      if (success) {
        profileImageUrl = await _repository.fetchUserProfileImageUrl();
      }
    }
    isLoadingSave = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
