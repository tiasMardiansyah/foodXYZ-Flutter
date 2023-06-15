import 'dart:developer';

import 'package:food_xyz_project/repositories.dart';

class DetailTransaksiViewModel extends ViewModel {
  LogTransaksiModel detailTransaksi = Get.arguments[0];
  final tokenStorage = const FlutterSecureStorage();
  late ApiProvider apiCall;
  @override
  void init() {
    if (Get.arguments[0] is! LogTransaksiModel) {
      log("Get.arguments[0] : Expecting LogTransaksiModel but got ${Get.arguments[0].runtimeType}");
      Get.back();
    }
    apiCall = Get.find<ApiProvider>();
  }

  List<DataRow> setProdukDetail() {
    List<DataRow> barisTabelProduk = [];
    for (int n = 0; n < detailTransaksi.invoiceDetail.length; n++) {
      barisTabelProduk.add(
        DataRow(
          cells: <DataCell>[
            DataCell(
              Center(
                child: Text(
                  detailTransaksi.invoiceDetail[n]['produk']['nama_produk'],
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            DataCell(
              Center(
                child: Text(
                  intToRupiah(detailTransaksi.invoiceDetail[n]['produk']
                      ['harga_produk']),
                ),
              ),
            ),
            DataCell(
              Center(
                child: Text(
                  detailTransaksi.invoiceDetail[n]['qty'].toString(),
                ),
              ),
            ),
            DataCell(
              Center(
                child: Text(
                  intToRupiah(
                    detailTransaksi.invoiceDetail[n]['produk']['harga_produk'] *
                        detailTransaksi.invoiceDetail[n]['qty'],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return barisTabelProduk;
  }

  void hapusLog() async {
    bool confirmed = await showConfirmDialog(
      texts: ["Yakin ingin menghapus log, aksi ini bersifat permanen"],
      title: "Hapus Log",
    );

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

        await apiCall.deleteLogTransaksi(token, detailTransaksi.invoiceId);
        close(isDeleted: true);
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

  void shareTransaksi() async {
    try {
      String? token = await tokenStorage.read(key: "accessToken");
      if (token == null) {
        var error = {
          "statusCode": "404",
          "statusText": "Token Tidak Ditemukan",
        };
        throw error;
      }

      UserModel userProfile =
          UserModel.fromJson(await apiCall.getProfile(token));
      await Printing.sharePdf(
          bytes:
              await InvoiceToPdf.fromLogTransaksi(detailTransaksi, userProfile),
          filename: "Foodxyz-Invoice-(${userProfile.namaLengkap}).pdf");
    } catch (e) {
      if (e is Map<String, dynamic>) {
        switch (e['statusCode']) {
          case 401:
            {
              await showWarningDialog(
                title: 'Token sudah kadaluarsa',
                icon: Image.asset('assets/images/not_found.png'),
                texts: ['Harap login kembali'],
              );
              Get.offNamed(Routes.login);
            }
            break;

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

  //nama perlu di revisi
  void close({bool isDeleted = false}) => Get.back(result: isDeleted);
}
