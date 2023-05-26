import 'package:food_xyz_project/repositories.dart';

class Routes {
  static String login = '/login';
  static String daftar = '/daftar';
  static String invoice = '/invoice';
  static String mainMenu = '/mainmenu';
}

var routes = [
  GetPage(
    name: Routes.login,
    page: () => const Login(),
  ),
  GetPage(
    name: Routes.daftar,
    page: () => const Daftar(),
  ),
  GetPage(
    name: Routes.invoice,
    page: () => const Invoice(),
  ),
  GetPage(
    name: Routes.mainMenu,
    page: () => const MainMenu(),
  ),
];
