/*
import 'package:food_xyz_project/repositories.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.onDecreaseButtonClicked,
    required this.onIncreaseButtonClicked,
    required this.onCartButtonClicked,
    required this.onTotalTextFocus,
    required this.produk,
    required this.cart,
  });

  final void Function() onDecreaseButtonClicked;
  final void Function() onIncreaseButtonClicked;
  final void Function() onCartButtonClicked;
  final void Function() onTotalTextFocus;
  final ProdukModel produk;
  final List<CartModel> cart;

  @override
  State<ProductCard> createState() => _ProductCart();
}

class _ProductCart extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      child: CachedNetworkImage(
                        imageUrl: widget.produk.fotoProduk,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        memCacheHeight: 200,
                        memCacheWidth: 200,
                        filterQuality: FilterQuality.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.produk.namaProduk,
                          style: customBodyBold(),
                        ),
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.produk.rating.toString(),
                        style: customBodyBold(),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 5.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(intToRupiah(widget.produk.hargaProduk)),
                      ),
                      Text(
                        widget.cart.where((element) => widget.cart[element].produk.idProduk ==)
                            .getItemQty(viewModel.filteredData[index].idProduk),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              viewModel.onJumlahProdukDikurang(
                                viewModel.filteredData[index].idProduk,
                                viewModel.controllers[index],
                              );
                            },
                            icon: const Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Focus(
                              onFocusChange: (hasFocus) =>
                                  viewModel.totalItemFocusChange(
                                      hasFocus, viewModel.controllers[index]),
                              child: TextField(
                                controller: viewModel.controllers[index],
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          IconButton(
                            onPressed: () {
                              viewModel.onTambahJumlahProduk(
                                viewModel.controllers[index],
                              );
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          viewModel.addToCart(
                            viewModel.getIdProduk(index),
                            viewModel.controllers[index],
                          );
                        },
                        child: const Icon(Icons.shopping_cart),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/