import 'package:food_xyz_project/repositories.dart';
void main() {

  runApp(
    GetMaterialApp(
      title: 'Aplikasi Food XYZ',
      getPages: routes,
      initialRoute: Routes.login,
    ),
  );
}


