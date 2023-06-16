import 'package:food_xyz_project/repositories.dart';

Future<void> errorHandler(dynamic e, {Map<int, List<String>?>? warningText}) async {
    //untuk error http request

    //maaf untuk if hell, kemungkinan saya akan ubah apabila saya punya cara detect runtime type di dart
    if (e is Map<String,dynamic>) httpErrorHandler(e['statusCode'],customText: warningText);

    if (e is String) appErrorHandler(e);

  
}
