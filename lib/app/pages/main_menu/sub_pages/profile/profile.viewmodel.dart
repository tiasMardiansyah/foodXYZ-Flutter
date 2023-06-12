import 'package:food_xyz_project/repositories.dart';

class ProfileViewModel extends ViewModel {
  UserModel? _userProfile;
  set userProfile(UserModel value) {
    _userProfile = value;
    notifyListeners();
  }

  String getName() {
    return _userProfile == null ? 'Loading' : _userProfile!.namaLengkap;
  }

  String getAddress() {
    return _userProfile == null ? 'Loading' : _userProfile!.alamat;
  }

  String getPhone() {
    return _userProfile == null ? 'Loading' : _userProfile!.noTelepon;
  }

  final tokenStorage = const FlutterSecureStorage();
  late ApiProvider apiCall;

  @override
  void init() async {
    apiCall = Get.find<ApiProvider>();
    await getUserProfile();
  }

  Future<void> getUserProfile() async {
    try {
      String? token = await tokenStorage.read(key: 'accessToken');
      if (token == null) {
        var error = {
          'statusCode': 404,
          'statusText': 'Not Found',
        };
        throw error;
      }

      
      userProfile = UserModel.fromJson(await apiCall.getProfile(token));
      notifyListeners();
    } catch (e) {
      if (e is Map<String, dynamic>) {
        switch (e['statusCode']) {
          case 404:
            {
              await showWarningDialog(
                title: 'Kredensial akun tidak ditemukan',
                icon: Image.asset('assets/images/not_found.png'),
                texts: ['Harap login kembali'],
              );
              Get.offNamed(Routes.login);
            }
            break;

          case 401:
            {
              //do something, like refresh the token
            }
        }
      } else {
        showWarningDialog(
          title: 'Error Besar',
          icon: Image.asset('assets/images/warning_sign.png'),
          texts: ['Hubungi developer apabila anda melihat pesan ini'],
        );
      }
    }
  }

  Future<void> logout() async {
    bool userConfirmed = await showConfirmDialog(texts: ['Yakin ingin Logout']);
    if (userConfirmed) {
      await tokenStorage.delete(key:'accessToken');
      await tokenStorage.delete(key: 'refreshToken');
      Get.offNamed(Routes.login);
    }
  }

  void goToLogTransaksi() => Get.toNamed(Routes.logTransaksi);
}
