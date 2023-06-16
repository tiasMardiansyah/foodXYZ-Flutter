import 'package:food_xyz_project/repositories.dart';

class AppError {
  static const String noConnection = "NO_CONNECTION";
  static const String tokenNotFound = "TOKEN_NOT_FOUND";
}

void appErrorHandler(
  String error, {
  Map<String, void Function()?>? statusCodeEvent,
}) async {
  switch (error) {
    case AppError.noConnection:
      {
        await showWarningDialog(
          title: 'Tidak ada internet',
          icon: Image.asset('assets/images/no_internet.png'),
          texts: ['Anda Tidak tersambung ke internet'],
        );

        statusCodeEvent?[error];
      }
      break;
    
    case AppError.tokenNotFound: 
    {
      await showWarningDialog(
          title: 'Token tidak tersimpan',
          icon: Image.asset('assets/images/not_found.png'),
          texts: ['token tidak ditemukan'],
        );
    }

    default:
      {
        await showWarningDialog(
          title: 'Tidak Tercatat',
          icon: Image.asset('assets/images/not_found.png'),
          texts: ['sepertinya kami belum menambah error : $error'],
        );
      }
  }
}
