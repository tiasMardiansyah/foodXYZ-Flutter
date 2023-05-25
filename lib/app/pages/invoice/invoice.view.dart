import 'package:food_xyz_project/repositories.dart';
//TO DO: Implement pmvvm

class Invoice extends StatelessWidget {
  const Invoice({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _View(),
      viewModel: InvoiceViewModel(),
    );
  }
}

class _View extends StatelessView<InvoiceViewModel> {
  @override
  Widget render(BuildContext context, InvoiceViewModel viewModel) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 223, 223),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: viewModel.close,
        ),
        title: const Text('Invoice'),
      ),
    );
  }
}
