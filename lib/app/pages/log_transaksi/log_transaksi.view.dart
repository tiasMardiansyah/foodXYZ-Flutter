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
          onPressed: viewModel.back,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: viewModel.isBusy
                ? Container(
                    color: const Color.fromARGB(54, 0, 0, 0),
                    child: const Center(
                      child: CircularProgressIndicator(),
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
                            subtitle: Text(intToRupiah(
                                viewModel.logsTransaksi?[index].totalBayar ??
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
