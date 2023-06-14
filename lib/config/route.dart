import 'package:food_xyz_project/repositories.dart';

class Routes {
  static String login = '/login';
  static String daftar = '/daftar';

  static String cart = '/cart';
  static String pdfPreview = '/pdf';

  static String mainMenu = '/mainmenu';

  static String logTransaksi = '/log';
  static String detailLogTransaksi = '/detail';
}

var routes = [
  GetPage(
    name: Routes.login,
    page: () => const Login(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: Routes.daftar,
    page: () => const Daftar(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: Routes.cart,
    page: () => const Invoice(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: Routes.mainMenu,
    page: () => const MainMenu(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: Routes.logTransaksi,
    page: () => const LogTransaksi(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: Routes.detailLogTransaksi,
    page: () => const DetailTransaksi(),
    transition: Transition.cupertino,
  ),
  GetPage(
    name: Routes.pdfPreview,
    page: () => const PdfView(),
    transition: Transition.cupertino,
  ),
];
