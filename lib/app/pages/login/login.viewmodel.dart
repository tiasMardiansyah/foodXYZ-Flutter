import 'package:food_xyz_project/repositories.dart';

class LoginViewModel extends ViewModel {
  final formkey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void goToDaftar() => Get.toNamed(Routes.daftar);

  void validate() {
    if (formkey.currentState!.validate()) {
      Get.offNamed(Routes.mainMenu);
    }
  }
}