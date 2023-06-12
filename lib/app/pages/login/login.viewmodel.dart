import 'package:food_xyz_project/repositories.dart';

class LoginViewModel extends ViewModel {
  final formkey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final tokenStorage = const FlutterSecureStorage();
  late ApiProvider apiCall;

  bool _isBusy = false;
  bool get isBusy => _isBusy;
  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void init() {
    apiCall = Get.find<ApiProvider>();
  }

  void validate() async {
    if (formkey.currentState!.validate()) {
      Map<String, dynamic>? result;
      isBusy = true;
      try {
        result = await apiCall.login(
          username: usernameController.text,
          password: passwordController.text,
        );
        //save token to
        await tokenStorage.write(
            key: 'accessToken', value: result['accessToken']);
        await tokenStorage.write(
            key: 'refreshToken', value: result['refreshToken']);

        Get.offNamed(Routes.mainMenu);
      } catch (e) {
        if (e 
        is Map<String, dynamic> && e['statusCode'] == 401) {
          showWarningDialog(
            title: 'Akun tidak ditemukan',
            icon: Image.asset('assets/images/not_found.png'),
            texts: [
              'Cek Kembali Password dan username yang dimasukan',
            ],
          );
        } else {
          showWarningDialog(
            title: 'Error besar',
            icon: Image.asset('assets/images/warning_sign.png'),
            texts: [
              'Hubungi developer apabila anda melihat pesan ini',
            ],
          );
        }
      } finally {
        isBusy = false;
      }
    }
  }

  void goToDaftar() => Get.toNamed(Routes.daftar, );
}
