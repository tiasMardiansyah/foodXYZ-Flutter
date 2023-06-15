import 'package:food_xyz_project/repositories.dart';

class Daftar extends StatelessWidget {
  const Daftar({super.key});
  @override
  Widget build(context) {
    return MVVM<DaftarViewModel>(
      view: () => _View(),
      viewModel: DaftarViewModel(),
    );
  }
}

class _View extends StatelessView<DaftarViewModel> {
  @override
  Widget render(BuildContext context, DaftarViewModel viewModel) {
    return Scaffold(
      body: Stack(
        children: [
          Form(
            key: viewModel.formKey,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 45,
                  vertical: 45,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Text(
                        'Silahkan Isi data pribadi anda',
                        style: customHeaderBold(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: viewModel.formNamaLengkap,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: viewModel.formUsername,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: viewModel.formAlamat,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: viewModel.formNoTelepon,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: viewModel.formPassword,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: viewModel.formPasswordConfirmation,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: viewModel.registration,
                        child: const Text('Daftar'),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: viewModel.goToLogin,
                      child: const Text('Sudah punya akun'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (viewModel.isBusy) const LoadingWidget()
        ],
      ),
    );
  }
}
