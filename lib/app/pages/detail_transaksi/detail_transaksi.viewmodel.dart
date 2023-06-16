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
          throw AppError.tokenNotFound;
        }

        await apiCall.deleteLogTransaksi(token, detailTransaksi.invoiceId);
        close(isDeleted: true);
      } catch (e) {
        errorHandler(e);
      }
    }
  }

  void shareTransaksi() async {
    try {
      String? token = await tokenStorage.read(key: "accessToken");
      if (token == null) {
        throw AppError.tokenNotFound;
      }

      UserModel userProfile =
          UserModel.fromJson(await apiCall.getProfile(token));
      await Printing.sharePdf(
          bytes:
              await InvoiceToPdf.fromLogTransaksi(detailTransaksi, userProfile),
          filename: "Foodxyz-Invoice-(${userProfile.namaLengkap}).pdf");
    } catch (e) {
      errorHandler(e);
    }
  }

  //nama perlu di revisi
  void close({bool isDeleted = false}) => Get.back(result: isDeleted);
}
