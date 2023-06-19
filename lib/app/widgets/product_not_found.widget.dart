import 'package:food_xyz_project/repositories.dart';

class ProductNotFound extends StatelessWidget {
  const ProductNotFound({super.key});

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
              "Tidak ada Barang",
              style: customHeaderBold(),
            ),
          ),
        ],
      ),
    ));
  }
}
