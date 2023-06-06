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
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
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
            child: ListView(
              children: [
                DataTable(
                    headingTextStyle: headerStyle(),
                    dataTextStyle: cellStyle(),
                    showBottomBorder: true,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Nama',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Harga',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'QTY',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'SubTotal',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    rows: viewModel.createDummyData(20)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 20,
            ),
            color: Colors.white,
            width: double.infinity,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Pembayaran',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Rp. XXX.XXX',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
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
                  padding: const EdgeInsets.only(top: 8.0),
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

  TextStyle headerStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 16,
      
    );
  }

  TextStyle cellStyle() {
    return const TextStyle(fontSize: 11, color: Colors.black);
  }
}
