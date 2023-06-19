import 'package:food_xyz_project/repositories.dart';

void httpErrorHandler(
  int statusCode, {
  Map<int, void Function()?>? statusCodeEvent,
  Map<int, List<String>?>? customText,
}) async {
  switch (statusCode) {
    case 400:
      {
        await showWarningDialog(
          title: 'Bad Request - 400',
          icon: Image.asset('assets/images/not_found.png'),
          texts: customText?[statusCode] ?? ['apa yang anda masukan tidak sesuai dengan ketentuan'],
        );

        statusCodeEvent?[statusCode];
      }
    case 401:
      {
        await showWarningDialog(
          title: 'Autentifikasi Gagal - 401',
          icon: Image.asset('assets/images/not_found.png'),
          texts: customText?[statusCode] ?? ['Autentifikasi gagal'],
        );

        statusCodeEvent?[statusCode] ?? Get.offNamed(Routes.login);
      }
      break;
    case 403:
      {
        await showWarningDialog(
          title: 'Akses Dilarang - 403',
          texts: customText?[statusCode] ?? ['anda mencoba mengakses sesuatu yang bukan milik anda'],
        );
      }

    case 404:
      {
        await showWarningDialog(
          title: 'Tidak ditemukan - 404',
          icon: Image.asset('assets/images/not_found.png'),
          texts: customText?[statusCode] ?? ['Apa yang anda minta tidak ditemukan'],
        );
      }
      break;

    case 500:
      {
        await showWarningDialog(
          title: 'Kesalahan di server - 500',
          texts: customText?[statusCode] ?? ['Sepertinya Server sedang mengalami kendala'],
        );
      }

    default:
      {
        await showWarningDialog(
          title: 'Tidak Tercatat',
          icon: Image.asset('assets/images/not_found.png'),
          texts: ['sepertinya kami belum menambah error kode: $statusCode'],
        );
      }
  }
}
