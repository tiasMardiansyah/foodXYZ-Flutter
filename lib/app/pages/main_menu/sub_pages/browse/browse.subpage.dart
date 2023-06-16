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
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 45,
                child: PageView.builder(
                    itemCount: viewModel.filterCategory.length,
                    pageSnapping: true,
                    controller: viewModel.pageController,
                    onPageChanged: (page) => viewModel.filterProduk(viewModel.searchController.text,page),
                    itemBuilder: (context, pagePosition) {
                      return Center(
                        child: Text(
                          viewModel.filterCategory.keys.elementAt(pagePosition),
                          textAlign: TextAlign.center,
                          style: customTabBarBold(),
                          
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    CustomSearchBar(
                      onChanged: viewModel.onSearchKeywordChanged,
                      searchController: viewModel.searchController,
                      displayText: 'Cari Item',
                    ),
                    Expanded(
                      child: viewModel.isBusy
                          ? const LoadingWidget(bgColor: Colors.transparent)
                          : RefreshIndicator(
                              onRefresh: viewModel.getMasterData,
                              child: viewModel.filteredData.isEmpty
                                  ? Center(
                                      child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            "assets/images/not_found.png",
                                            width: 150,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Text(
                                              "Tidak ada Barang",
                                              style: customHeaderBold(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                  : ListView.builder(
                                      itemCount: viewModel.filteredData.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Card(
                                          elevation: 5,
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    child: SizedBox(
                                                      width: 100,
                                                      height: 100,
                                                      child: FittedBox(
                                                        fit: BoxFit.cover,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(45),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: viewModel
                                                                .filteredData[
                                                                    index]
                                                                .fotoProduk,
                                                            progressIndicatorBuilder: (context,
                                                                    url,
                                                                    downloadProgress) =>
                                                                CircularProgressIndicator(
                                                                    value: downloadProgress
                                                                        .progress),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                            memCacheHeight: 200,
                                                            memCacheWidth: 200,
                                                            filterQuality:
                                                                FilterQuality
                                                                    .none,
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
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              viewModel
                                                                  .getNamaProduk(
                                                                      index),
                                                              style:
                                                                  customBodyBold(),
                                                            ),
                                                          ),
                                                          const Icon(
                                                            Icons.star,
                                                            color:
                                                                Colors.yellow,
                                                            size: 18,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                              viewModel
                                                                  .getRatingProduk(
                                                                      index),
                                                              style:
                                                                  customBodyBold())
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 5.0,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(viewModel
                                                                .getHargaProduk(
                                                                    index)),
                                                          ),
                                                          Text(
                                                            viewModel.getItemQty(
                                                                viewModel
                                                                    .filteredData[
                                                                        index]
                                                                    .idProduk),
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
                                                                  viewModel
                                                                      .onJumlahProdukDikurang(
                                                                    viewModel
                                                                        .filteredData[
                                                                            index]
                                                                        .idProduk,
                                                                    viewModel
                                                                            .controllers[
                                                                        index],
                                                                  );
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .remove_circle,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Expanded(
                                                                child: Focus(
                                                                  onFocusChange: (hasFocus) => viewModel.totalItemFocusChange(
                                                                      hasFocus,
                                                                      viewModel
                                                                              .controllers[
                                                                          index]),
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        viewModel
                                                                            .controllers[index],
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 5),
                                                              IconButton(
                                                                onPressed: () {
                                                                  viewModel
                                                                      .onTambahJumlahProduk(
                                                                    viewModel
                                                                            .controllers[
                                                                        index],
                                                                  );
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .add_circle,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 8.0,
                                                          ),
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              viewModel
                                                                  .addToCart(
                                                                viewModel
                                                                    .getIdProduk(
                                                                        index),
                                                                viewModel
                                                                        .controllers[
                                                                    index],
                                                              );
                                                            },
                                                            child: const Icon(Icons
                                                                .shopping_cart),
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
                  ],
                ),
                if (viewModel.cart.isNotEmpty)
                  Positioned(
                    bottom: 10,
                    width: MediaQuery.of(context).size.width - 20,
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
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
