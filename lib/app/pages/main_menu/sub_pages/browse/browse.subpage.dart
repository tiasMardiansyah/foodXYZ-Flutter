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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomSearchBar(
            onSubmitted: viewModel.search,
            searchController: viewModel.searchController,
            displayText: 'Cari Item',
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(viewModel.display)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
            onPressed: viewModel.goToInvoice,
            child: Row(
              children: [
                const Expanded(
                  child: Text('Bayar'),
                ),
                Expanded(
                  child: Text(
                    viewModel.totalBayar,
                    textAlign: TextAlign.end,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
