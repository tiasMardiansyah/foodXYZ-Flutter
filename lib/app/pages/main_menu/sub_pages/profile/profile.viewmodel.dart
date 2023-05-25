import 'package:food_xyz_project/repositories.dart';

class ProfileViewModel extends ViewModel {
  
  void logout() => Get.off(Routes.login);
  
}