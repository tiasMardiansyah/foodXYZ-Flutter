import 'package:food_xyz_project/repositories.dart';

class DaftarViewModel extends ViewModel {
  final formKey = GlobalKey<FormState>();
  late ApiProvider apiCall;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  final formNamaLengkap = CustomTextFormField(
    displayText: 'Nama lengkap',
    errorMessage: 'Nama lengkap harus diisi',
    controller: TextEditingController(),
  );

  final formUsername = CustomTextFormField(
    displayText: 'Username',
    errorMessage: 'Username harus diisi',
    controller: TextEditingController(),
  );

  final formAlamat = CustomTextFormField(
    displayText: 'Alamat',
    errorMessage: 'Alamat harus diisi',
    controller: TextEditingController(),
  );

  final formNoTelepon = CustomTextFormField(
    displayText: 'No Telepon',
    errorMessage: 'No.Telepon harus diisi',
    inputType: TextInputType.phone,
    controller: TextEditingController(),
  );

  final formPassword = CustomPasswordFormField(
    displayText: 'Password',
    errorMessage: 'Password harus diisi',
    controller: TextEditingController(),
  );

  late CustomPasswordFormField formPasswordConfirmation;

  @override
  void init() {
    super.init();
    apiCall = Get.find<ApiProvider>();
    formPasswordConfirmation = CustomPasswordFormField(
      displayText: 'Konfirmasi password',
      errorMessage: 'Konfirmasi password harus diisi',
      passwordToCheck: formPassword,
      controller: TextEditingController(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    formNamaLengkap.controller!.dispose();
    formUsername.controller!.dispose();
    formAlamat.controller!.dispose();
    formNoTelepon.controller!.dispose();
    formPassword.controller!.dispose();
    formPasswordConfirmation.controller!.dispose();
  }

  void registration() async {
    if (formKey.currentState!.validate()) {
        _isLoading = true;
        await apiCall.addAccount(
          namaLengkap: formNamaLengkap.controller!.text,
          username: formUsername.controller!.text,
          alamat: formAlamat.controller!.text,
          noTelepon: formNoTelepon.controller!.text,
          password: formPassword.controller!.text,
          passwordConfirm: formPasswordConfirmation.controller!.text,
        );

        _isLoading = false;
        goToLogin();
      }
  }

  void goToLogin() => Get.back();
}
