import 'package:food_xyz_project/repositories.dart';

class ProfileViewModel extends ViewModel {
  
  final dummyName = 'Adrian';
  final dummyPhoneNumber = '0881023641280';
  final dummyAddress = 'Jalan. Situraja';
  void logout() => Get.offNamed(Routes.login);
  
}