import 'package:food_xyz_project/repositories.dart';

class ProductNotFound extends StatelessWidget {
  const ProductNotFound({
    super.key,
    required this.produkDicari,
    required this.kategori,
  });

  final String produkDicari;
  final String kategori;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/not_found.png",
            width: 150,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              "'$produkDicari' Untuk Kategori '$kategori' Tidak ditemukan",
              style: customHeaderBold(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ));
  }
}
