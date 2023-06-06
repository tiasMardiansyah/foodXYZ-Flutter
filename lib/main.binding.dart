import 'package:food_xyz_project/repositories.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
  }
}