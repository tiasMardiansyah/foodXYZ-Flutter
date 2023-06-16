import 'package:food_xyz_project/repositories.dart';

class LogTransaksiViewModel extends ViewModel {
  List<LogTransaksiModel>? logsTransaksi = [];
  late ApiProvider apiCall;
  final tokenStorage = const FlutterSecureStorage();

  bool _isBusy = false;
  bool get isBusy => _isBusy;
  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  @override
  void init() async {
    apiCall = Get.find<ApiProvider>();
    await getLogTransaksi();
  }

  void goToDetail(int index) async {
    final logIsDeleted = await Get.toNamed(Routes.detailLogTransaksi,
        arguments: [logsTransaksi?[index]]);

    if (logIsDeleted is bool && logIsDeleted == true) {
      logsTransaksi!.removeAt(index);
      notifyListeners();
    }
  }

  Future<void> getLogTransaksi() async {
    try {
      isBusy = true;
      final token = await tokenStorage.read(key: 'accessToken');
      if (token == null) {
        throw AppError.tokenNotFound;
      }

      final result = await apiCall.getLogTransaksi(token);
      for (var n = 0; n < result.length; n++) {
        logsTransaksi?.add((LogTransaksiModel.fromJson(result[n])));
      }
    } catch (e) {
      errorHandler(e);
    } finally {
      isBusy = false;
    }
  }

  //void goToLogDetail() => Get.toNamed();
  void back() => Get.back();
}
