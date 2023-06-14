import 'dart:developer';
import 'dart:typed_data';
import 'package:food_xyz_project/repositories.dart';

class PdfViewModel extends ViewModel {

  final pdf = Get.arguments[0];

  @override
  void init() {
    if (pdf is! Uint8List) {
      log("Argument Tidak Sesuai dengan dibutuhkan");
      Get.back();
    } 
  }
}