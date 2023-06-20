import 'package:food_xyz_project/repositories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      title: 'Aplikasi Food XYZ',
      getPages: routes,
      initialRoute: '/',
      initialBinding: MainBinding(),
    ),
  );
}
