import 'package:food_xyz_project/repositories.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return MVVM<ProfileViewModel>(
      view: () => _View(),
      viewModel: ProfileViewModel(),
    );
  }
}

class _View extends StatelessView<ProfileViewModel> {
  @override
  Widget render(BuildContext context, ProfileViewModel viewModel) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        ProfileWidget(
          name: viewModel.getName(),
          address: viewModel.getAddress(),
          phoneNumber: viewModel.getPhone(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              alignment: Alignment.centerLeft,
            ),
            icon: const Icon(
              Icons.history,
              color: Colors.black,
            ),
            onPressed: () => viewModel.goToLogTransaksi(),
            label: const Text('Lihat Riwayat Transaksi'),
          ),
        ),
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Colors.white,
              foregroundColor: Colors.red,
              elevation: 0,
              alignment: Alignment.centerLeft,
            ),
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: () => viewModel.logout(),
            label: const Text('Keluar'),
          ),
        ),
      ],
    );
  }
}
