import 'package:food_xyz_project/repositories.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    GetMaterialApp(
      title: 'Aplikasi Food XYZ',
      getPages: routes,
      initialRoute: prefs.getString('loginCredentials') == null
          ? Routes.login
          : Routes.mainMenu,
      initialBinding: MainBinding(),
    ),
  );
}
