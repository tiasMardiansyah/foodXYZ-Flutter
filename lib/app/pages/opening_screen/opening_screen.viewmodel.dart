import 'package:food_xyz_project/repositories.dart';

class OpeningScreenViewModel extends ViewModel {
  @override
  void init() async {
    String? accessToken =
        await const FlutterSecureStorage().read(key: 'accessToken');

      print("Access Token get");
      accessToken != null
          ? Get.offNamed(Routes.mainMenu)
          : Get.offNamed(Routes.login);
  }
}
