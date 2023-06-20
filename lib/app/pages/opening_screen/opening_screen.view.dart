import 'package:food_xyz_project/repositories.dart';

//sepertinya saya akan buat seperti ini terlebih dahulu, mungkin akan diubah di kemudian hari
class OpeningScreen extends StatelessWidget {
  const OpeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _View(),
      viewModel: OpeningScreenViewModel(),
    );
  }
}

class _View extends StatelessView<OpeningScreenViewModel> {
  @override
  Widget render(BuildContext context, OpeningScreenViewModel viewModel) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
