import 'package:food_xyz_project/repositories.dart';

class PdfView extends StatelessWidget {

  const PdfView({super.key});
  @override
  Widget build(BuildContext context) {
    return MVVM<PdfViewModel>(
      view: () => _View(),
      viewModel: PdfViewModel(),
    );
  }
}

class _View extends StatelessView<PdfViewModel> {
  @override
  Widget render(BuildContext context, PdfViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(title: const Text("PDF Preview")),
      body: PdfPreview(
        build: (context) => viewModel.pdf,
      ),
    );

  }
}
