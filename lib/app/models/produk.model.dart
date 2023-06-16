import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ProdukModel {
  @JsonKey(name: 'id_produk')
  final String idProduk;

  @JsonKey(name: 'foto_produk')
  final String fotoProduk;

  @JsonKey(name: 'nama_produk')
  final String namaProduk;

  @JsonKey(name: 'harga_produk')
  final int hargaProduk;

  @JsonKey(name: 'rating')
  final double rating;

  @JsonKey(name: 'jenis')
  final String jenis;

  ProdukModel({
    required this.idProduk,
    required this.fotoProduk,
    required this.namaProduk,
    required this.hargaProduk,
    required this.rating,
    required this.jenis,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    return ProdukModel(
      idProduk: json['id_produk'] as String,
      fotoProduk: json['foto_produk'] as String,
      namaProduk: json['nama_produk'] as String,
      hargaProduk: int.parse(json['harga_produk']),
      rating: double.parse(json['rating']),
      jenis: json['jenis'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_produk': idProduk,
      'foto_produk': fotoProduk,
      'nama_produk': namaProduk,
      'harga_produk': hargaProduk,
      'rating': rating,
      'jenis' : jenis,
    };
  }
}
