import 'package:food_xyz_project/repositories.dart';

class DaftarViewModel extends ViewModel {

  final formKey = GlobalKey<FormState>();
  final namaLengkapController = TextEditingController();
  final usernameController = TextEditingController();
  final alamatController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    namaLengkapController.dispose();
    usernameController.dispose();
    alamatController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
  }

  void goToLogin() => Get.back();

  void registration() {
    if (formKey.currentState!.validate()) {
      goToLogin();
    }
  }

}