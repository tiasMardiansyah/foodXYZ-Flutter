import 'package:food_xyz_project/repositories.dart';

class LogTransaksi extends StatelessWidget {
  const LogTransaksi({super.key});

  @override
  Widget build(context) {
    return MVVM<LogTransaksiViewModel>(
      view: () => _View(),
      viewModel: LogTransaksiViewModel(),
    );
  }
}

class _View extends StatelessView<LogTransaksiViewModel> {
  @override
  Widget render(BuildContext context, LogTransaksiViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('Catatan pembelian'),
        titleTextStyle: customHeaderBold(),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: viewModel.back,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: viewModel.isBusy
                ? const LoadingWidget()
                : viewModel.logsTransaksi?.isEmpty ?? true
                    ? Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/images/empty_box.png",
                                width: 150,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  "anda belum melakukan transaksi apapun",
                                  style: customHeaderBold(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: viewModel.logsTransaksi?.length ?? 0,
                        itemBuilder: ((context, index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: ListTile(
                                leading: const Icon(
                                  Icons.calendar_month,
                                  size: 50,
                                  color: Colors.black,
                                ),
                                title: Text(
                                    viewModel.logsTransaksi?[index].createdAt ??
                                        "???"),
                                subtitle: Text(intToRupiah(viewModel
                                        .logsTransaksi?[index].totalBayar ??
                                    0)),
                                trailing: ElevatedButton(
                                  child: const Text("Lihat Detail"),
                                  onPressed: () {
                                    viewModel.goToDetail(index);
                                  },
                                )),
                          );
                        }),
                      ),
          ),
        ],
      ),
    );
  }
}
