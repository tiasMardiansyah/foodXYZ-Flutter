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
      body: Form(
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
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Text(
                    'Silahkan Isi data pribadi anda',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: CustomTextFormField(
                    displayText: 'Nama lengkap',
                    errorMessage: 'Nama lengkap harus diisi',
                    controller: viewModel.namaLengkapController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: CustomTextFormField(
                    displayText: 'Username',
                    errorMessage: 'Username harus diisi',
                    controller: viewModel.usernameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: CustomTextFormField(
                    displayText: 'Alamat',
                    errorMessage: 'Alamat harus diisi',
                    controller: viewModel.alamatController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CustomPasswordFormField(
                    controller: viewModel.passwordController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: CustomPasswordFormField(
                    displayText: 'Konfirmasi Password anda',
                    controller: viewModel.passwordConfirmationController,
                  ),
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
    );
  }
}

/*
@override
  Widget build(context) {
    return Form(
      key: _daftarFormKey,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Text(
              'Silahkan Isi data pribadi anda',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CustomTextFormField(
              displayText: 'Nama lengkap',
              errorMessage: 'Nama lengkap harus diisi',
              controller: namaLengkapController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CustomTextFormField(
              displayText: 'Username',
              errorMessage: 'Username harus diisi',
              controller: namaLengkapController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CustomTextFormField(
              displayText: 'Alamat',
              errorMessage: 'Alamat harus diisi',
              controller: alamatController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CustomPasswordFormField(
              controller: passwordController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: CustomPasswordFormField(
              displayText: 'Konfirmasi Password anda',
              controller: passwordConfirmationController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                if (_daftarFormKey.currentState!.validate()) {
                  
                }
              },
              child: const Text('Daftar'),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Sudah punya akun'),
          ),
        ],
      ),
    );
  }
*/
