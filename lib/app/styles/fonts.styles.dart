import 'package:food_xyz_project/repositories.dart';

TextStyle? customHeaderBold({Color cr = const Color.fromARGB(255, 0, 0, 0)}) {
  return TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: cr,
  );
}

TextStyle? customBodyBold({Color cr = const Color.fromARGB(255, 0, 0, 0)}) {
  return const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}
