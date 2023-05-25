import 'package:food_xyz_project/repositories.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<LoginViewModel>(
      view: () => _View(),
      viewModel: LoginViewModel(),
    );
  }
}

class _View extends StatelessView<LoginViewModel> {
  @override
  Widget render(BuildContext context, LoginViewModel viewModel) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 45,
            horizontal: 45,
          ),
          child: Form(
            key: viewModel.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/fast_food.png',
                  width: 125,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
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
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: CustomPasswordFormField(
                    controller: viewModel.passwordController,
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
                    onPressed: viewModel.validate,
                    child: const Text('Login'),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: viewModel.goToDaftar,
                  child: const Text('Daftar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
