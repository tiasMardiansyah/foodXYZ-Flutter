import 'package:food_xyz_project/repositories.dart';

class Routes {
  static String login = '/login';
  static String daftar = '/daftar';
  static String cart = '/cart';
  static String mainMenu = '/mainmenu';
  static String logTransaksi = '/history';
}

var routes = [
  GetPage(
    name: Routes.login,
    page: () => const Login(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: Routes.daftar,
    page: () => const Daftar(),
    transition: Transition.leftToRight,
  ),
  GetPage(
    name: Routes.cart,
    page: () => const Invoice(),
    transition: Transition.downToUp
  ),
  GetPage(
    name: Routes.mainMenu,
    page: () => const MainMenu(),
  ),
  GetPage(
    name: Routes.logTransaksi,
    page: () => const CatatanPembelian(),
  )
];
