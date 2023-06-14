import 'package:food_xyz_project/repositories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const tokenStorage = FlutterSecureStorage();

  runApp(
    GetMaterialApp(
      title: 'Aplikasi Food XYZ',
      getPages: routes,
      initialRoute: await tokenStorage.read(key: 'accessToken') == null
          ? Routes.login
          : Routes.mainMenu,
      initialBinding: MainBinding(),
    ),
  );
}
