import 'package:food_xyz_project/repositories.dart';

class Browse extends StatelessWidget {
  const Browse({super.key});
  @override
  Widget build(BuildContext context) {
    return MVVM<BrowseViewModel>(
      view: () => _View(),
      viewModel: BrowseViewModel(),
    );
  }
}

class _View extends StatelessView<BrowseViewModel> {
  @override
  Widget render(BuildContext context, BrowseViewModel viewModel) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomSearchBar(
                onChanged: viewModel.onSearchKeywordChanged,
                searchController: viewModel.searchController,
                displayText: 'Cari Item',
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: viewModel.filteredData.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/not_found.png",
                              width: 150,
                            ),
                            Text("Produk Tidak ditemukan"),
                          ],
                        ))
                      : ListView.builder(
                          itemCount: viewModel.filteredData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 5,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: CachedNetworkImage(
                                              imageUrl: viewModel
                                                  .filteredData[index]
                                                  .fotoProduk,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                              memCacheHeight: 200,
                                              memCacheWidth: 200,
                                              filterQuality: FilterQuality.none,
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  viewModel.filteredData[index]
                                                      .namaProduk,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
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
                                                viewModel
                                                    .filteredData[index].rating
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
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
                                                child: Text(
                                                  intToRupiah(viewModel
                                                      .filteredData[index]
                                                      .hargaProduk),
                                                ),
                                              ),
                                              Text(viewModel.getItemQty(
                                                  viewModel.filteredData[index]
                                                      .idProduk)),
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
                                                      viewModel
                                                          .onJumlahProdukDikurang(
                                                        viewModel
                                                            .filteredData[index]
                                                            .idProduk,
                                                        viewModel
                                                            .controllers[index],
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
                                                    child: TextField(
                                                      controller: viewModel
                                                          .controllers[index],
                                                      keyboardType:
                                                          TextInputType.number,
                                                      style: const TextStyle(),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  IconButton(
                                                    onPressed: () {
                                                      viewModel
                                                          .onTambahJumlahProduk(
                                                        viewModel
                                                            .controllers[index],
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                              ),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  viewModel.addToCart(
                                                    viewModel
                                                        .filteredData[index]
                                                        .idProduk,
                                                    viewModel
                                                        .controllers[index],
                                                  );
                                                },
                                                child: const Icon(
                                                    Icons.shopping_cart),
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
                          },
                        ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: viewModel.goToCart,
                child: Row(
                  children: [
                    const Expanded(
                      child: Text('Bayar'),
                    ),
                    Expanded(
                      child: Text(
                        intToRupiah(viewModel.total),
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        if (viewModel.isBusy)
          Container(
            color: const Color.fromARGB(52, 0, 0, 0),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );
  }
}
