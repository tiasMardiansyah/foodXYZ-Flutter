import 'package:food_xyz_project/repositories.dart';

class Routes {
  static String login = '/login';
  static String daftar = '/daftar';
  static String invoice = '/invoice';
  static String mainMenu = '/mainmenu';
}

var routes = {
  Routes.login: (context) => const Login(),
  Routes.daftar: (context) => const Daftar(),
  Routes.invoice : (context) => const Invoice(),
  Routes.mainMenu : (context) => const MainMenu(),
};
