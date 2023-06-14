import 'package:food_xyz_project/repositories.dart';

class DetailTransaksi extends StatelessWidget {
  const DetailTransaksi({super.key});

  @override
  Widget build(context) {
    return MVVM<DetailTransaksiViewModel>(
      view: () => _View(),
      viewModel: DetailTransaksiViewModel(),
    );
  }
}

class _View extends StatelessView<DetailTransaksiViewModel> {
  @override
  Widget render(BuildContext context, DetailTransaksiViewModel viewModel) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text('Detail Pembelian'),
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
          actions: [IconButton(onPressed: viewModel.hapusLog, icon: const Icon(Icons.delete, color: Colors.red,))],
        ),
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListTile(
                leading: const Icon(
                  Icons.calendar_month,
                  size: 50,
                  color: Colors.black,
                ),
                title: Text(viewModel.detailTransaksi.createdAt),
                subtitle: Text(
                    intToRupiah(viewModel.detailTransaksi.totalBayar)),
                    trailing: IconButton(onPressed: viewModel.shareTransaksi ,icon: const Icon(Icons.share,color: Colors.blue,)),
              ),
            ),
            Expanded(
              child: DataTable2(
                headingTextStyle: headerStyle(),
                dataTextStyle: cellStyle(),
                showBottomBorder: true,
                columns: const [
                  DataColumn(
                    label: Center(
                      child: Text('Nama'),
                    ),
                  ),
                  DataColumn2(
                    size: ColumnSize.L,
                    label: Center(
                      child: Text('Harga'),
                    ),
                  ),
                  DataColumn(
                    label: Center(
                      child: Text('QTY'),
                    ),
                  ),
                  DataColumn(
                    label: Center(
                      child: Text('SubTotal'),
                    ),
                  ),
                ],
                rows: viewModel.setProdukDetail(),
              ),
            )
          ],
        ));
  }

  TextStyle headerStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 12,
    );
  }

  TextStyle cellStyle() {
    return const TextStyle(fontSize: 10, color: Colors.black);
  }
}
