import 'package:food_xyz_project/repositories.dart';

class CatatanPembelian extends StatelessWidget {
  const CatatanPembelian({super.key});

  @override
  Widget build(context) {
    return MVVM<CatatanPembelianViewModel>(
      view: () => _View(),
      viewModel: CatatanPembelianViewModel(),
    );
  }
}

class _View extends StatelessView<CatatanPembelianViewModel> {
  @override
  Widget render(BuildContext context, CatatanPembelianViewModel viewModel) {
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
                      itemCount: viewModel.masterData?.length ?? 0,
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
                                viewModel.masterData?[index].createdAt ??
                                    "???"),
                            subtitle: Text(intToRupiah(
                                viewModel.masterData?[index].totalBayar ?? 0)),
                            trailing: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Lihat Detail')),
                          ),
                        );
                      }),
                    )),
        ],
      ),
    );
  }
}
