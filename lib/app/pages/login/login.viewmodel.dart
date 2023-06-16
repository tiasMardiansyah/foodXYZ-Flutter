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
  void init() async {
    apiCall = Get.find<ApiProvider>();
  }

  //digunakan untuk mengecek apakah user sudah login

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
        errorHandler(e, warningText: {
          401: [
            "Akun Tidak Ditemukan, Coba Cek password dan username yang dimasukan"
          ]
        });
      } finally {
        isBusy = false;
      }
    }
  }

  void goToDaftar() => Get.toNamed(
        Routes.daftar,
      );
}
