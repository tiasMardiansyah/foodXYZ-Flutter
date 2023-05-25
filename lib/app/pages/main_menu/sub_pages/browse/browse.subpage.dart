import 'package:food_xyz_project/repositories.dart';

class Browse extends StatelessWidget {

  const Browse({super.key});
  @override
  Widget build(BuildContext context) {
    return MVVM<BrowseViewModel>(view: () => _View(), viewModel: BrowseViewModel(),);
  }

}

class _View extends StatelessView<BrowseViewModel> {
  @override
  Widget render(BuildContext context, BrowseViewModel viewModel) {
    return const Text('Menu Browsing');
  }

}