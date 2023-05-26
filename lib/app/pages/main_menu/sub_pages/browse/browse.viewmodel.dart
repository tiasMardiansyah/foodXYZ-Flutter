import 'package:food_xyz_project/repositories.dart';

class BrowseViewModel extends ViewModel {
  final searchController = TextEditingController();

   String _display = '';

   // ignore: prefer_final_fields
   String _totalBayar = '';

  /*
    saya tidak tahu apakah getter itu bagus dipakai di sini atau tidak, 
    mungkin akan di ubah di kemudian hari
  */
  String get display => _display;
  String get totalBayar => _totalBayar;


  void goToInvoice() => Get.toNamed(Routes.invoice);

  void search(String controller) {
    _display = controller;
    _totalBayar = controller;
    notifyListeners();
  }
}
