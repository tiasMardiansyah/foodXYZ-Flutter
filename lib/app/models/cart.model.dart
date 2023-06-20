import 'package:food_xyz_project/app/index.dart';

class CartModel {
  ProdukModel produk;
  int qty;

  CartModel({required this.produk, required this.qty});

  Map<String, dynamic> toJson() {
    var ketProduk = {
      "id_produk": produk.idProduk,
      "nama_produk": produk.namaProduk,
      "harga_produk": produk.hargaProduk,
    };

    var json = {"produk": ketProduk, "qty": qty};

    return json;
  }
}
