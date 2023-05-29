import 'package:food_xyz_project/repositories.dart';

class BrowseViewModel extends ViewModel {
  final searchController = TextEditingController();

  List<String> masterData = [
    'Anggur',
    'Anggur Merah',
    'Jeruk',
    'Nanas',
    'Pisang',
    'Manga',
  ];

  @override
  void init() {
    result = masterData;
  }

  List<String> _result = [];
  List<String> get result => _result;
  set result(List<String> value) {
    _result = value;
    notifyListeners();
  }

  void onKeywordChanged(String value) {
    String searchValue = value.toLowerCase();
    List<String> temp = [];

    for (var element in masterData) {
      if (element.toLowerCase().contains(searchValue)) {
        temp.add(element);
      }
    }

    result = temp;
  }

  /*
  String _keyword = '';
  String get keyword => _keyword;
  set keyword(String value) {
    _keyword = value;
    notifyListeners();
  }
  */

  void goToInvoice() => Get.toNamed(Routes.invoice);
}
