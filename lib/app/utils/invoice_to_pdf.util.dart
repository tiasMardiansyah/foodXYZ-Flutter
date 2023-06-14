import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:food_xyz_project/repositories.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoiceToPdf {
  static Future<Uint8List> fromCart(
      List<CartModel> cart, UserModel user, int totalBayar) async {
    final pdf = pw.Document();
    final imageLogo = pw.MemoryImage((await rootBundle.load(
      'assets/images/fast_food.png',
    ))
        .buffer
        .asUint8List());

    List<pw.TableRow> listProduk = <pw.TableRow>[];

    for (int n = 0; n < cart.length; n++) {
      listProduk.add(
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(10),
              child: pw.Text(cart[n].produk.namaProduk,
                  textAlign: pw.TextAlign.center),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(10),
              child: pw.Text(intToRupiah(cart[n].produk.hargaProduk),
                  textAlign: pw.TextAlign.center),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(10),
              child: pw.Text(cart[n].qty.toString(),
                  textAlign: pw.TextAlign.center),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(10),
              child: pw.Text(
                  intToRupiah(cart[n].produk.hargaProduk * cart[n].qty),
                  textAlign: pw.TextAlign.center),
            )
          ],
        ),
      );
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Column(
              children: [
                //header

                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Row(
                            children: [
                              pw.Text(
                                "Kepada : ",
                                style: const pw.TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              pw.Text(
                                user.namaLengkap,
                                style: pw.TextStyle(
                                  fontSize: 16,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          pw.Text(
                            user.alamat,
                            style: const pw.TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Image(imageLogo, width: 100),
                  ],
                ),
                //akhir dari header

                pw.SizedBox(height: 25),

                //body
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.black),
                  children: [
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.lightBlue,
                      ),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(15),
                          child: pw.Text("Nama",
                              textAlign: pw.TextAlign.center,
                              style: _headerStyle()),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(15),
                          child: pw.Text("Harga",
                              textAlign: pw.TextAlign.center,
                              style: _headerStyle()),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(15),
                          child: pw.Text("Qty",
                              textAlign: pw.TextAlign.center,
                              style: _headerStyle()),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(15),
                          child: pw.Text("SubTotal",
                              textAlign: pw.TextAlign.center,
                              style: _headerStyle()),
                        )
                      ],
                    ),
                    ...listProduk
                  ],
                ),
                //akhhir dari body

                pw.SizedBox(height: 25),

                //footer
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.black),
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(15),
                          child: pw.Text("Total Bayar",
                              textAlign: pw.TextAlign.center,
                              style: _headerStyle()),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(15),
                          child: pw.Text(intToRupiah(totalBayar),
                              textAlign: pw.TextAlign.center,
                              style: _headerStyle()),
                        ),
                      ],
                    ),
                  ],
                ),

                //akhir dari footer
              ],
            )
          ];
        },
      ),
    );

    return pdf.save();
  }

  static Future<Uint8List> fromLogTransaksi(
      LogTransaksiModel logTransaksi, UserModel user) async {
    final pdf = pw.Document();
    final imageLogo = pw.MemoryImage((await rootBundle.load(
      'assets/images/fast_food.png',
    ))
        .buffer
        .asUint8List());

    List<pw.TableRow> listProduk = <pw.TableRow>[];

    for (int n = 0; n < logTransaksi.invoiceDetail.length; n++) {
      listProduk.add(
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(10),
              child: pw.Text(
                  logTransaksi.invoiceDetail[n]['produk']['nama_produk'],
                  textAlign: pw.TextAlign.center),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(10),
              child: pw.Text(
                  intToRupiah(
                      logTransaksi.invoiceDetail[n]['produk']['harga_produk']),
                  textAlign: pw.TextAlign.center),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(10),
              child: pw.Text(logTransaksi.invoiceDetail[n]['qty'].toString(),
                  textAlign: pw.TextAlign.center),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(10),
              child: pw.Text(
                  intToRupiah(logTransaksi.invoiceDetail[n]['produk']
                          ['harga_produk'] *
                      logTransaksi.invoiceDetail[n]['qty']),
                  textAlign: pw.TextAlign.center),
            )
          ],
        ),
      );
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Column(
              children: [
                //header

                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Row(
                            children: [
                              pw.Text(
                                "Kepada : ",
                                style: const pw.TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              pw.Text(
                                user.namaLengkap,
                                style: pw.TextStyle(
                                  fontSize: 16,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          pw.Text(
                            user.alamat,
                            style: const pw.TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Image(imageLogo, width: 100),
                  ],
                ),
                //akhir dari header

                pw.SizedBox(height: 25),

                //body
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.black),
                  children: [
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.lightBlue,
                      ),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(15),
                          child: pw.Text("Nama",
                              textAlign: pw.TextAlign.center,
                              style: _headerStyle()),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(15),
                          child: pw.Text("Harga",
                              textAlign: pw.TextAlign.center,
                              style: _headerStyle()),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(15),
                          child: pw.Text("Qty",
                              textAlign: pw.TextAlign.center,
                              style: _headerStyle()),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(15),
                          child: pw.Text("SubTotal",
                              textAlign: pw.TextAlign.center,
                              style: _headerStyle()),
                        )
                      ],
                    ),
                    ...listProduk
                  ],
                ),
                //akhhir dari body

                pw.SizedBox(height: 25),

                //footer
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.black),
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(15),
                          child: pw.Text("Total Bayar",
                              textAlign: pw.TextAlign.center,
                              style: _headerStyle()),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(15),
                          child: pw.Text(intToRupiah(logTransaksi.totalBayar),
                              textAlign: pw.TextAlign.center,
                              style: _headerStyle()),
                        ),
                      ],
                    ),
                  ],
                ),

                //akhir dari footer
              ],
            )
          ];
        },
      ),
    );

    return pdf.save();
  }
}

pw.TextStyle? _headerStyle() {
  return pw.TextStyle(
    fontSize: 14,
    fontWeight: pw.FontWeight.bold,
  );
}
