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
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomSearchBar(
                onChanged: viewModel.onSearchKeywordChanged,
                searchController: viewModel.searchController,
                displayText: 'Cari Item',
              ),
            ),
            Expanded(
              child: PageView.builder(
                  itemCount: viewModel.foodCategory.length,
                  pageSnapping: true,
                  controller: viewModel.pageController,
                  onPageChanged: (page) => viewModel.onPageChange(page),
                  itemBuilder: (context, pagePosition) {
                    return Column(
                      children: [
                        Center(
                          child: Text(
                            viewModel.foodCategory.keys.elementAt(pagePosition),
                            textAlign: TextAlign.center,
                            style: customTabBarBold(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: viewModel.getMasterData,
                            child:
                                viewModel.selectedFoodCategory == pagePosition
                                    ? createProductCard(viewModel)
                                    : productCategory(viewModel, pagePosition),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
        if (viewModel.cart.isNotEmpty)
          Positioned(
            bottom: 10,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
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
              ),
            ),
          ),
        if (viewModel.isBusy) const LoadingWidget()
      ],
    );
  }

  //Untuk sementara disimpan secara terpisah sampai saya punya solusi lebih bagus, saya pisahkan terlebih dahulu karena alasan readability
  Widget productCategory(BrowseViewModel viewModel, int page) {
    return Card(
      elevation: 10,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              viewModel.foodCategoryImage.values.elementAt(page),
              width: 150,
            ),
            Text(viewModel.foodCategory.keys.elementAt(page),
                style: customCategoryCardBold())
          ],
        ),
      ),
    );
  }

//Untuk sementara disimpan secara terpisah sampai saya punya solusi lebih bagus, saya pisahkan terlebih dahulu karena alasan readability
  Widget createProductCard(BrowseViewModel viewModel) {
    return viewModel.filteredData.isEmpty
        ? const ProductNotFound()
        : CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
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
                                      imageUrl: viewModel
                                          .filteredData[index].fotoProduk,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        viewModel.getNamaProduk(index),
                                        style: customBodyBold(),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      viewModel.getRatingProduk(index),
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
                                      child:
                                          Text(viewModel.getHargaProduk(index)),
                                    ),
                                    Text(
                                      viewModel.getItemQty(viewModel
                                          .filteredData[index].idProduk),
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
                                              viewModel
                                                  .filteredData[index].idProduk,
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
                                                    hasFocus,
                                                    viewModel
                                                        .controllers[index]),
                                            child: TextField(
                                              controller:
                                                  viewModel.controllers[index],
                                              keyboardType:
                                                  TextInputType.number,
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
                                    child: Container(
                                      
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: IconButton(
                                        color: Colors.white,
                                        onPressed: () {
                                          viewModel.addToCart(
                                            viewModel.getIdProduk(index),
                                            viewModel.controllers[index],
                                          );
                                        },
                                        icon: const Icon(Icons.shopping_cart),
                                      ),
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
                }, childCount: viewModel.filteredData.length),
              )
            ],
          );
  }
}
