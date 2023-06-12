import 'dart:developer';

import 'package:food_xyz_project/repositories.dart';

class InvoiceViewModel extends ViewModel {
  final List<CartModel> cart = [];
  int _totalBayar = 0;
  late ApiProvider apiCall;
  final tokenStorage = const FlutterSecureStorage();

  @override
  void init() {
    apiCall = Get.find<ApiProvider>();
    if (Get.arguments[0] is! List<CartModel>) {
      log("Get.arguments[0] : Expecting List<CartModel> but got ${Get.arguments[0].runtimeType}");
    } else {
      cart.addAll(Get.arguments[0]);
    }

    if (Get.arguments[1] is! int) {
      log("Get.arguments[1] : Expecting int but got ${Get.arguments[1].runtimeType}");
    } else {
      _totalBayar = Get.arguments[1];
    }
  }

  String getTotalBayarInRupiah() {
    return intToRupiah(_totalBayar);
  }

  //revisi nama, fungsi ini akan mengembalikan sebuah hasil boolean, di karenakan screen ini dipanggil di main_menu/browser
  void close({bool isSaved = false}) => Get.back(result: isSaved);

  //perlu revisi kembali terutama penamaan
  //intinya ambil dari var cart dan masukan kedalam barisTabelProduk
  //DataTable di view mengambil List<DataRow>
  List<DataRow> setRow() {
    List<DataRow> barisTabelProduk = [];
    for (int n = 0; n < cart.length; n++) {
      barisTabelProduk.add(
        DataRow(
          cells: <DataCell>[
            DataCell(
              Text(
                cart[n].produk.namaProduk,
                softWrap: true,
              ),
            ),
            DataCell(
              Text(
                intToRupiah(cart[n].produk.hargaProduk),
                softWrap: true,
              ),
            ),
            DataCell(
              Text(
                cart[n].qty.toString(),
                softWrap: true,
              ),
            ),
            DataCell(
              Text(
                intToRupiah(cart[n].produk.hargaProduk * cart[n].qty),
                softWrap: true,
              ),
            ),
          ],
        ),
      );
    }
    return barisTabelProduk;
  }

  void shareInvoice() {
    //TODO implementasi sharing invoice
  }

  Future<void> saveInvoice() async {
    bool confirmed = await showConfirmDialog(texts: ["Tuntaskan Transaksi??"]);
    if (confirmed) {
      try {
        String? token = await tokenStorage.read(key: "accessToken");
        if (token == null) {
          var error = {
            "statusCode": "404",
            "statusText": "Token Tidak Ditemukan",
          };
          throw error;
        }

        await apiCall.createLogTransaksi(cart, _totalBayar, token);
        await showWarningDialog(
          title: 'Transaksi berhasil',
          icon: Image.asset('assets/images/check.png'),
          texts: ['Transaksi anda sudah dicatat'],
        );
        close(isSaved: true);

      } catch (e) {
        if (e is Map<String, dynamic>) {
          switch (e['statusCode']) {
            case 404:
              {
                await showWarningDialog(
                  title: 'Kredensial akun tidak ditemukan',
                  icon: Image.asset('assets/images/not_found.png'),
                  texts: ['Harap login kembali'],
                );
                Get.offNamed(Routes.login);
              }
              break;

            case 401:
              {
                //do something, like refresh the token
              }
          }
        } else {
          showWarningDialog(
            title: 'Error Besar',
            icon: Image.asset('assets/images/warning_sign.png'),
            texts: ['Hubungi developer apabila anda melihat pesan ini'],
          );
        }
      }
    }
  }
}
