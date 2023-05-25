import 'package:food_xyz_project/repositories.dart';

class DaftarScreen extends StatelessWidget {
  const DaftarScreen({super.key});

  @override
  Widget build(context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(45),
          child: SingleChildScrollView(
            child: FormHandler(),
          ),
        ),
      ),
    );
  }
}

class FormHandler extends StatefulWidget {
  const FormHandler({super.key});

  @override
  State<FormHandler> createState() => _FormHandlerState();
}

class _FormHandlerState extends State<FormHandler> {
  final GlobalKey<FormState> _daftarFormKey = GlobalKey<FormState>();
  final namaLengkapController = TextEditingController();
  final usernameController = TextEditingController();
  final alamatController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  @override
  void dispose() {
    namaLengkapController.dispose();
    usernameController.dispose();
    alamatController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }


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
}
