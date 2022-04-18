import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../generated/l10n.dart';
import '../ui/themes/app_colors.dart';

class ImageHelper {
  ImageHelper._();

  static Future<File?> cropImage(
          {required String path, required BuildContext context}) =>
      ImageCropper().cropImage(
        sourcePath: path,
        cropStyle: CropStyle.circle,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: S.of(context).crop_image,
          toolbarColor: AppColors.colorPrimary,
          statusBarColor: AppColors.colorPrimary,
          cropFrameColor: AppColors.colorPrimary,
          cropGridColor: AppColors.colorBackground,
          backgroundColor: AppColors.colorBackground,
          dimmedLayerColor: AppColors.colorBackground,
          toolbarWidgetColor: AppColors.colorMainText,
          activeControlsWidgetColor: AppColors.colorPrimary,
          hideBottomControls: true,
        ),
        iosUiSettings: const IOSUiSettings(
          rotateButtonsHidden: true,
          rotateClockwiseButtonHidden: true,
          aspectRatioPickerButtonHidden: true,
        ),
      );

  static Future<File?> compressFile(
    File file,
  ) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    // final appDir = await path.getTemporaryDirectory();
    var result = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      quality: 15,
    );

    return result;
  }
}
