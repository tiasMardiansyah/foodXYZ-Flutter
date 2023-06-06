import 'package:food_xyz_project/repositories.dart';

class LoginViewModel extends ViewModel {
  final formkey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late ApiProvider apiCall;

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
      Map<String, dynamic> result = await apiCall.login(
        username: usernameController.text,
        password: passwordController.text,
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      //set preferenceKey
      await prefs.setString('loginCredentials', result['accessToken']);

      Get.offNamed(Routes.mainMenu);
    }
  }

  void goToDaftar() => Get.toNamed(Routes.daftar);
}
