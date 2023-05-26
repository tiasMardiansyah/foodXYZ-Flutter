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
          const CustomTextFormField(
            displayText: 'Cari Item',
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top:10.0,bottom: 10.0),
              child: Container(
                color: Colors.red,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),

            ),
            onPressed: viewModel.gotToInvoice,
            child: Text('Bayar'),
          )
        ],
      ),
    );
  }
}
