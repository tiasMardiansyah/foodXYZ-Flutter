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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:15.0, vertical: 15.0),
              child: Container(
                color: Colors.red,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: viewModel.saveInvoice,
                        child: const Text('Save'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: viewModel.shareInvoice,
                        child: const Text('Share'),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: viewModel.close,
                    child: const Text('Selesai'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
